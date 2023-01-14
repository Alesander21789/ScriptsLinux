
#!/bin/bash
# Script to collect information by utilizing volatility

####  Configurable Settings #############
homeDir='/home/malware-analysis'
memImage="$homeDir/1bc928ac.vmem"
locVolPy='/usr/share/vol2-4/volatility-2.4/vol.py'
volProfile=''
#########################################
date
outputDir="$homeDir/output"
dumpDir="$homeDir/dumpdir"
tempDir="$homeDir/temp"

if [ ! -d $outputDir ]; then
    mkdir $outputDir
    mkdir $outputDir/dlllist
    mkdir $outputDir/getsids
    mkdir $outputDir/handles
    mkdir $outputDir/ldrmodules
    mkdir $dumpDir
    mkdir $tempDir
fi

# Find the profile for the image that is being analyzed and store it in volProfile
#python2.7 $locVolPy -f $memImage imageinfo > $outputDir/imageinfo
#cat $outputDir/imageinfo | grep "Suggested Profile(s)" | awk '{print "Identified Profile: " $4}' | sed 's/,//'
#volProfile=`cat $outputDir/imageinfo | grep "Suggested Profile(s)" | awk '{print $4}' | sed 's/,//'`

# Run a variety of volatility plugins and save the output
for pluginCommand in pslist pstree psscan psxview connections connscan filescan iehistory svcscan cmdscan consoles hivelist sockets sockscan driverscan ssdt cachedump timeliner netscan;
do
    echo "Running $pluginCommand and saving results to $outputDir/$pluginCommand"
    python2.7 $locVolPy -f $memImage --profile=$volProfile $pluginCommand > $outputDir/$pluginCommand
done


echo "Running evtlogs and saving results to $outputDir/evtlogs"
python2.7 $locVolPy -f $memImage --profile=$volProfile evtlogs --dump-dir $outputDir

echo "Find processes in psxview that is using Direct Kernel Object Manipulation (DKOM)"
echo "Display from psxview any processes with "False" in the psscan, pslist, thrdproc"
echo "Find processes in psxview that is using Direct Kernel Object Manipulation (DKOM)" > $outputDir/possibleDKOM
echo "Display from psxview any processes with "False" in the psscan, pslist, thrdproc" >> $outputDir/possibleDKOM
while read line
do
    pslistColumn=`echo $line | awk '{print $4}'`
    psscanColumn=`echo $line | awk '{print $5}'`
    thrdprocColumn=`echo $line | awk '{print $6}'`
    if [ $pslistColumn == 'False' ]; then
        echo "$line" >> $outputDir/possibleDKOM
    fi
    if [ $psscanColumn == 'False' ]; then
        echo "Found: $line" >> $outputDir/possibleDKOM
    fi
    if [ $thrdprocColumn == 'False' ]; then
        echo "Found: $line" >> $outputDir/possibleDKOM
    fi
done < $outputDir/psxview
echo



echo "Running mftparser and saving results to $outputDir/mftpparser"
python2.7 $locVolPy -f $memImage --profile=$volProfile mftparser --output=body --output-file=$outputDir/mftparser.csv
mactime -b $outputDir/mftparser.csv -d -z UTC-6 > $outputDir/mftparserMactime.csv

echo "Saving the results of the hashdump to $outputDir/hashdump"
# Find the virtual address of the SYSTEM hive
while read line
do
    if [[ $line == *YSTEM* ]] || [[ $line == *ystem* ]]; then
        systemVAddr=`echo $line | awk '{print $1}'`
    fi
done < $outputDir/hivelist
# Find the virtual address of the SAM hive
while read line
do
    if [[ $line == *SAM* ]]; then
        samVAddr=`echo $line | awk '{print $1}'`
    fi
done < $outputDir/hivelist
python2.7 $locVolPy -f $memImage --profile=$volProfile -y $systemVAddr -s $samVAddr hashdump > $outputDir/hashdump

echo "Running malfind and saving results to $outputDir/malfind"
python2.7 $locVolPy -f $memImage --profile=$volProfile malfind --dump-dir $dumpDir > $outputDir/malfind

# Export to output/dlllist the PIDs found in the pslist output file
cat $outputDir/pslist | grep -v -e "Offset(V)" -e "------" | awk '{print $3}' > $tempDir/PIDlist
while read line
do
    python2.7 $locVolPy -f $memImage --profile=$volProfile dlllist -p $line > $outputDir/dlllist/proc-$line
    python2.7 $locVolPy -f $memImage --profile=$volProfile getsids -p $line > $outputDir/getsids/proc-$line
    python2.7 $locVolPy -f $memImage --profile=$volProfile handles -p $line > $outputDir/handles/proc-$line
    python2.7 $locVolPy -f $memImage --profile=$volProfile ldrmodules -p $line > $outputDir/ldrmodules/proc-$line
done < $tempDir/PIDlist

# With the dlllists look for unique path's
rm -f $tempDir/dlllistPaths
rm -f $tempDir/dlllistCommandline
touch $tempDir/dlllistPaths
touch $tempDir/dlllistCommandline
for file in $outputDir/dlllist/*
do
    cat $file | grep "0x" | awk '{print $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}' >> $tempDir/dlllistPaths
    cat $file | grep "Command line :" >> $tempDir/dlllistCommandline
done
cat $tempDir/dlllistPaths | sort | uniq -c | sort -n | grep -v -i -e "windows.system32" > $outputDir/dlllist-OutsideSystem32
cat $tempDir/dlllistPaths | sort | uniq -c | sort -n | grep "1" > $outputDir/dlllist-SingleInstance
cat $tempDir/dlllistCommandline | sed 's/Command line :" //' > $outputDir/dlllist-Commandline

# With the getsids look for unique sids or something out-of-the-ordinary
rm -f $tempDir/getsids-temp-list
touch $tempDir/getsids-temp-list
for file in $outputDir/getsids/*
do
    cat $file | awk -F ":" '{print $2}' >> $tempDir/getsids-temp-list
done
cat $tempDir/getsids-temp-list | sort | uniq -c | sort -n > $outputDir/getsids-list
cat $outputDir/svcscan | grep "Binary Path: " | sort | uniq -c > $outputDir/svcscan-binarypath

cat $outputDir/ldrmodules/proc-* | grep "0x" | grep "-" > $outputDir/ldrmodules-NoPathInfo
cat $outputDir/ssdt | egrep -v '(ntoskrnl | win32k)' > $outputDir/ssdt-modified

# Extract from the registry specific keys of interest
python2.7 $locVolPy -f $memImage --profile=$volProfile printkey -K "Software\Microsoft\Windows\CurrentVersion\Run" > $outputDir/registryRunKeys
#http://digital-forensics.sans.org/blog/2010/10/20/digital-forensics-autorun-registry-keys/
#SysInternals autorun utility


date

echo