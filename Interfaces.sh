#!/bin/bash
clear
if [ "$1" == "-i3" ]
then
	clear
	echo "[+] Aviso: Nao execute este comando como usuario root"
	echo "[+] Caso esteja como super usuario, cancele a execucao com (CTRL + C)"
	echo "[+]"
	read -p "[+] Enter para proseguir com a instalacao dos pacotes..."
	clear
	sudo pacman -S xorg-server xorg-xinit xorg-apps i3-gaps dmenu i3status i3blocks i3lock xfce4-terminal chromium picom thunar xdg-user-dirs nitrogen leafpad pulseaudio pavucontrol
	clear
	echo "[-] Etapa manual"
	echo "[-]"
	echo "[-] Os comandos a seguir irão lhe auxiliar na utilizacao do I3-Gaps"
	echo "[-]"
	echo "[-] 'setxkbmap br' = Utilizado para configurar seu teclado para o padrao br-abnt2"
	echo "[-] 'startx'       = Utilizado para inicializar seu I3-Gaps a cada reinicializacao"
	echo "[-]"
	read -p "[-] Enter para continuar..." R
	cp Resources/xinitrc ~/.xinitrc
	startx
else
	clear
	echo "Linux4dev Arch-Linux-Interfaces"
	echo " "
	echo "Manual de utilizacao"
	echo " "
	echo "-i3 : utilize este comando para instalar e inicializar o I3-Gaps em seu arch linux."
	echo " "
fi
