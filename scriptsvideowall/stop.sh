#!/bin/bash

maquines=(10.0.0.1 10.0.0.2 10.0.0.3 10.0.0.4 10.0.0.5 10.0.0.6)
usuari=administrador
password=administrador

# Comanda a executar en remot
#comanda="pkill -f firefox"
comanda="pkill -f vlc"

for maquinaActual in "${maquines[@]}"
do
	echo "---- Executant en $maquinaActual ----"
	ssh $usuari@$maquinaActual $comanda 
done
