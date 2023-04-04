#!/bin/bash

maquines=(10.0.0.101 10.0.0.102 10.0.0.103 10.0.0.104 10.0.0.105 10.0.0.106)
usuari=lliurex
password=lliurex


for maquinaActual in "${maquines[@]}"
do
	echo "Apagant $maquinaActual"
	ssh $usuari@$maquinaActual "echo $password | sudo -S shutdown -h now"
done
