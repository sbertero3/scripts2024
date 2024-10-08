#!/bin/bash
# Comprova que hi hagi dos arguments d'entrada (nom del client i nom del projecte)
if [ $# -ne 2 ]; then
    echo "Ús: $0 nom-Client nom-Projecte"
    exit 1
fi
CLIENT="$1"
PROJECTE="$2"
# Funció per monitoritzar la memòria RAM
monitoritzar_memoria() {
    read -p "Introdueix el valor límit d'utilització en percentatge (p.ex., 95): " limit
    # Obtenim el percentatge d'utilització de la memòria RAM
    PERCENTATGE=$(free | awk '/Mem:/ {printf("%.2f", ($3/$2)*100)}')
    # Comprovem si supera el límit
    if (( $(echo "$PERCENTATGE > $LIMIT" | bc -l) )); then
        echo "La memòria RAM ha superat el límit del $limit%." > warning.txt
    fi
}
# Funció per monitoritzar la CPU
monitoritzar_cpu() {
    read -p "Introdueix el valor límit d'utilització en percentatge (p.ex., 95): " limit
    # Obtenim el percentatge d'utilització de la CPU
    PERCENTATGE=$(top -b -n 1 | awk '/%Cpu/ {print 100-$8}')
    # Comprovem si supera el límit
    if (( $(echo "$PERCENTATGE > $LIMIT" | bc -l) )); then
        echo "La CPU ha superat el límit del $LIMIT%." > warning.txt
    fi
}
# Funció per monitoritzar l'ús del disc dur
monitoritzar_disc_dur() {
    read -p "Introdueix el valor límit d'utilització en percentatge (p.ex., 95): " limit
    # Obtenim el percentatge d'utilització del disc dur principal "/"
    PERCENTATGE=$(df -h | awk '/\/$/ {gsub("%",""); print $5}')
    # Comprovem si supera el límit
    if (( $(echo "$PERCENTATGE > $LIMIT" | bc -l) )); then
        echo "L'ús del disc dur ha superat el límit del $LIMIT%." > warning.txt
    fi
}
# Demana a l'usuari si vol iniciar la monitorització
read -p "Vols iniciar la monitorització? (S/n): " start_option
if [ "$start_option" == "S" ]; then
    monitoritzar_memoria
    monitoritzar_cpu
    monitoritzar_disc_dur
fi
