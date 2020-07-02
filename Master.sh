#!/bin/bash
clear
if [ "$1" == "-s1" ]
then
	clear
	echo "[+] Inicializando"
	sleep 4
	clear

	wipefs -a /dev/sda > /dev/null 2>&1
	echo "[+] HD Formatado"
	sleep 2
	clear

	loadkeys br-abnt2 > /dev/null 2>&1
	echo "[+] Teclado configurado"
	sleep 2
	clear
	
	echo "[-] Etapa manual"
	echo "[-] Crie uma tabela GPT com as opções 'g' e 'w'"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	fdisk /dev/sda
	clear

	echo "[-] Etapa manual"
	echo "[-] Crie as partições"
	echo "[-]"
	echo "[-] [BIOS boot] [Size: 1G]   [Type: BIOS boot]"
	echo "[-] [SWAP]      [Size: 5G]   [Type: Linux swap]"
	echo "[-] [RAIZ]      [Size: 50G]  [Type: Linux file sytem]"
	echo "[-] [HOME]      [Size: MAX]  [Type: Linux file system]"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	cfdisk /dev/sda
	clear
	
	echo "[-] Etapa semi-automatica"
	echo "[-] Confirme as mensagens a seguir se necessário"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	mkfs.fat -F32 /dev/sda1
	mkswap /dev/sda2
	mkfs.ext4 /dev/sda3
	mkfs.ext4 /dev/sda4
	clear

	mount /dev/sda3 /mnt > /dev/null 2>&1
	mkdir /mnt/home
	mount /dev/sda4 /mnt/home > /dev/null 2>&1
	swapon /dev/sda2 > /dev/null 2>&1
	clear
	echo "[+] Partições montadas"
	sleep 2
	clear

	cat Resources/mirrorlist > /etc/pacman.d/mirrorlist
	clear
	echo "[+] Espelhos atualizados"
	sleep 2
	clear

	echo "[+] Os pacotes essênciais serao instalados"
	echo "[+] Esta etapa pode demorar um pouco"
	echo "[+]"
	read -p "[+] Enter para continuar..." R
	pacstrap /mnt base base-devel linux linux-firmware
	clear
	echo "[+] Pacotes instalados"
	sleep 2
	clear

	genfstab -U -p /mnt >> /mnt/etc/fstab
	clear
	echo "[+] Arquivo fstab gerado"
	sleep 2
	clear

	echo "[-] Etapa manual"
	echo "[-]"
	echo "[-] Acesse o diretorio '/root/ArchLinuxInstaller'"
	echo "[-] E utilize o comando './Master.sh -s2' para continuar a instalacao"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	clear
	cp -r ../ArchLinuxInstaller /mnt/root
	arch-chroot /mnt

elif [ "$1" == "-s2" ]
then

	clear
	echo "[+] Alguns pacotes ser�o instalados"
	echo "[+] Esta etapa pode demorar um pouco"
	echo "[+]"
	read -p "[+] Enter para continuar..." R
	clear
	pacman -S grub dosfstools networkmanager wpa_supplicant wireless_tools dialog vim sudo netplan net-tools
	clear
	echo "[+] Pacotes instalados"
	sleep 2
	clear

	ln -sf /usr/share/zoneinfo/America/Sao_paulo /etc/localtime
	hwclock --systohc
	clear
	echo "[+] Data e hora ajustadas"
	sleep 2
	clear

	echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen
	locale-gen > /dev/null 2>&1
	echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
	echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
	echo arch >> /etc/hostname
	clear
	echo "[+] Linguagem, teclado e hostname configurados"
	sleep 2
	clear

	cat Resources/hosts > /etc/hosts
	clear
	echo "[+] Arquivo de hosts configurado"
	sleep 2
	clear

	echo "[-] Etapa manual"
	echo "[-]"
	echo "[-] Defina uma nova senha para o root"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	clear
	passwd
	clear
	echo "[-] Senha atualizada"
	sleep 2
	clear

	useradd -m -g users -G wheel administrator
	clear
	echo "[+] Usuário administrator criado"
	sleep 2
	clear
	
	echo 'administrator ALL=(ALL)ALL' >> /etc/sudoers
	clear
	echo "[+] Usuário administrator adicionado ao sudoers"
	sleep 2
	clear

	echo "[-] Etapa manual"
	echo "[-]"
	echo "[-] Defina uma nova senha para o administrator"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	clear
	passwd administrator
	clear
	echo "[-] Senha atualizada"
	sleep 2
	clear

	echo "[+] Grub sendo instalado, favor aguarde..."
	grub-install --target=i386-pc --recheck /dev/sda > /dev/null 2>&1
	cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
	grub-mkconfig -o /boot/grub/grub.cf > /dev/null 2>&1
	clear
	echo "[+] Grub configurado"
	sleep 2
	clear

	systemctl start NetworkManager > /dev/null 2>&1
	systemctl enable NetworkManager > /dev/null 2>&1
	clear
	echo "[+] NetworkManager habilitado"
	sleep 2
	clear

	echo "[-] Etapa manual"
	echo " "
	echo "[-] Reinicie a maquina com 'exit' seguido de 'reboot'"
	echo "[-] Em seguida atualize os pacotes"
	echo "[-]"
        echo "[-] Welcome to Arch linux !!!"

elif [ "$1" == "-wifi" ]
then	
	clear
	mkdir /etc/netplan
	touch /etc/netplan/wifi.yaml
	cat Resources/Wifi.yaml >> /etc/netplan/wifi.yaml
	echo "[-] Etapa manual"
	echo "[-]"
	echo "[-] Defina o SSID e Password de sua rede wifi manualmente"
	echo "[-]"
	read -p "[-] Enter para continuar" R
	vim /etc/netplan/wifi.yaml
	clear
	netplan apply > /dev/null 2>&1
	clear
	echo "[-] Configurações realizadas"
	echo "[+] Reiniciando"
	reboot

elif [ "$1" == "-interface" ]
then
	echo "Não implementado"
else
	clear
	echo "Linux4dev Arch-Linux-Installer"
	echo " "
	echo "Manual de utilizção"
	echo " "
	echo "-s1 : Inicializa a primeira etapa do programa, deve ser utilizada logo após o boot do archlinux, dentre suas diversas implementações a mais importante é a parte de formatação e particionamento do disco, portanto siga exatamente as instruções fornecidas para que tudo ocorra como o esperado"
	echo " "
	echo "-s2 : Inicializa a segunda parte do programa, responsável pela manipulação da arquivos de configuração e instalação de pacotes para o correto funcionamento do sistema."
	echo " "
	echo "-wifi : Utilizado para realizar as configurações semi-automaticas do netplan que irá te permiter se conectar via Wifi"
	echo " "
	echo "-interface : Utilizado para realizar a instalação e configuração de uma interface grafica escolhida pelo usuário"
	echo " "
fi
