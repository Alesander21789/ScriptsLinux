# Parte 1
while true; do
    echo "Menu Principal"
    echo "1. Opci�n 1"
    echo "2. Opci�n 2"
    echo "3. Opci�n 3"
    echo "4. Opci�n 4"
    echo "5. Salir"
    read -p "Seleccione una opci�n: " option

    case $option in
        1)
            while true; do
                echo "Menu Opci�n 1"
                echo "1. Subopci�n 1"
                echo "2. Subopci�n 2"
                echo "3. Salir"
                read -p "Seleccione una opci�n: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopci�n 1 de la opci�n 1"
                        ;;
                    2)
                        echo "Ejecutando subopci�n 2 de la opci�n 1"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opci�n no v�lida"
                esac
            done
            ;;
        2)


# Parte 2
        3)
            while true; do
                echo "Menu Opci�n 3"
                echo "1. Subopci�n 1"
                echo "2. Subopci�n 2"
                echo "3. Salir"
                read -p "Seleccione una opci�n: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopci�n 1 de la opci�n 3"
                        ;;
                    2)
                        echo "Ejecutando subopci�n 2 de la opci�n 3"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opci�n no v�lida"
                esac
            done
            ;;
        4)
            while true; do
                echo "Menu Opci�n 4"
                echo "1. Subopci�n 1"
                echo "2. Subopci�n 2"
                echo "3. Salir"
                read -p "Seleccione una opci�n: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopci�n 1 de la opci�n 4"
                        ;;
                    2)
                        echo "Ejecutando subopci�n 2 de la opci�n 4"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opci�n no v�lida"
                esac
            done
            ;;
        5)
            break
            ;;
        *)
            echo "Opci�n no v�lida"
    esac
done
