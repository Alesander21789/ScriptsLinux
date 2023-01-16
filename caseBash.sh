# Parte 1
while true; do
    echo "Menu Principal"
    echo "1. Opción 1"
    echo "2. Opción 2"
    echo "3. Opción 3"
    echo "4. Opción 4"
    echo "5. Salir"
    read -p "Seleccione una opción: " option

    case $option in
        1)
            while true; do
                echo "Menu Opción 1"
                echo "1. Subopción 1"
                echo "2. Subopción 2"
                echo "3. Salir"
                read -p "Seleccione una opción: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopción 1 de la opción 1"
                        ;;
                    2)
                        echo "Ejecutando subopción 2 de la opción 1"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opción no válida"
                esac
            done
            ;;
        2)


# Parte 2
        3)
            while true; do
                echo "Menu Opción 3"
                echo "1. Subopción 1"
                echo "2. Subopción 2"
                echo "3. Salir"
                read -p "Seleccione una opción: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopción 1 de la opción 3"
                        ;;
                    2)
                        echo "Ejecutando subopción 2 de la opción 3"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opción no válida"
                esac
            done
            ;;
        4)
            while true; do
                echo "Menu Opción 4"
                echo "1. Subopción 1"
                echo "2. Subopción 2"
                echo "3. Salir"
                read -p "Seleccione una opción: " suboption

                case $suboption in
                    1)
                        echo "Ejecutando subopción 1 de la opción 4"
                        ;;
                    2)
                        echo "Ejecutando subopción 2 de la opción 4"
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Opción no válida"
                esac
            done
            ;;
        5)
            break
            ;;
        *)
            echo "Opción no válida"
    esac
done
