#!/bin/bash

maquines=(10.0.0.1 10.0.0.2 10.0.0.3 10.0.0.4 10.0.0.5 10.0.0.6)
usuari=administrador
password=administrador


for maquinaActual in "${maquines[@]}"
do
	echo "Apagant $maquinaActual"
	ssh $usuari@$maquinaActual "echo $password | sudo -S shutdown -h now"
done
