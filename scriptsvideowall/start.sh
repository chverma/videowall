#!/bin/bash

maquines=(10.0.0.101 10.0.0.102 10.0.0.103 10.0.0.104 10.0.0.105 10.0.0.106)
#maquines=(10.0.0.101)



usuari=lliurex
password=lliurex

# Comanda a executar en remot
#comanda=reboot
scriptRemoto=provaRemoto.sh

for maquinaActual in "${maquines[@]}"
do
	echo "---- Executant en $maquinaActual ----"
	#ssh $usuari@$maquinaActual $comanda
	scp ./$scriptRemoto $usuari@$maquinaActual:~
	ssh $usuari@$maquinaActual "~/$scriptRemoto" &
#	ssh $maquinaActual $comanda &
done
