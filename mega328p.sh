#!/bin/bash

sudo dtparam spi=on

function mega328p {
whiptail --title "Проверка процессора" --msgbox "Проверка процессора начата" 10 60
sudo dtparam spi=on

count=$(/home/pi/test_atm | grep -c "param=[1-9][0-9]*")
#echo $count
if [[ $count -eq 7 ]]
then
	pwd=$(/home/pi/test_atm | awk '/PWD.*param=/{print $10}' | awk -F= '{print $2}')
	#echo $pwd
	if [[ ${#pwd} -le 6 ]];
	then
		v5=$(/home/pi/test_atm | awk '/5V.*param=/{print $10}' | awk -F= '{print $2}')
		A=$((v5 * 10 / 1000 ))
		B=$((v5 % 100 ))
		echo "При 5-ти вольтах устройство выдаёт $A.$B миливольт" >> results.txt

		v12=$(/home/pi/test_atm | awk '/12V.*param=/{print $10}' | awk -F= '{print $2}')
                C=$((v12 * 10 / 1000 ))
		D=$((v12 % 100 ))
                echo "При 12-ти вольтах устройство выдаёт $C.$D миливольт" >> results.txt

		#echo $pwd
		echo "Процессор от mega328p работает" >> results.txt
	else
		echo "Возникли проблемы с паролем процессора" >> results.txt
	fi
else
	echo "Возникли проблемы с процессором" >> results.txt
fi

whiptail --title "Проверка процессора" --msgbox "Отправьте на номер телефона, который вам звонил смс с паролем: $pwd. Устройство должно перезагрузится" 10 60

}
#mega328p
