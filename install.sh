#!/bin/bash

distro_id=`grep ^ID= /etc/os-release | awk -F= '{print $2}'|sed -e 's/"//g'

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

