#!/bin/bash

distro_id=`grep ^ID= /etc/os-release | awk -F= '{print $2}'|sed -e 's/"//g'`

case $distro_id in
	centos)
		sudo ./docker-install-centos.sh
		;;
	fedora)
		sudo ./docker-install-fedora.sh
		;;
	debian)
		sudo ./docker-install-debian.sh
		;;
	ubuntu)
		sudo ./docker-install-ubuntu.sh
		;;
	*)
		echo "not supported distro"
		;;
esac

echo -n "enter main url (i.e. - http://example.com, use https if tls is required): "
read url

delimiter="://"
string=$url$delimiter

myarray=()
while [[ $string ]]; do
  myarray+=( "${string%%"$delimiter"*}" )
  string=${string#*"$delimiter"}
done

echo -n "enter admin email: "
read email

echo -n "enter admin password: "
read password

cp env.example .env

sed -i '/SR_PROTO=/d' ./.env
sed -i '/SR_HOST=/d' ./.env
sed -i '/ADMIN_EMAIL=/d' ./.env
sed -i '/ADMIN_PASSWORD=/d' ./.env

echo "SR_PROTO=${myarray[0]}" >> ./.env
echo "SR_HOST=${myarray[1]}" >> ./.env
echo "ADMIN_EMAIL=${email}" >> ./.env
echo "ADMIN_PASSWORD=${password}" >> ./.env
