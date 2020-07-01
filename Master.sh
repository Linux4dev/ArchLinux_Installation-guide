#!/bin/bash
clear
echo "[+] ATENÇÃO [+]"
echo " "
echo "Este script tem o objetivo de auxiliar seus usuários"
echo " durante a instalação do archlinux em suas máquinas."
echo "   O mesmo foi baseado no tutorial da Linux4dev"
echo " " 
read -p "Precione qualquer tecla para continuar..." -n 1 X

loop="y"
while [ "$loop" == "y" ]
do
echo "1) Formate seu HD"
echo "2) Configure seu teclado"
echo "3) Crie uma nova tabela GPT em seu disco"
echo "4) Crie as partições [Boot, Swap, Raiz e Home]"
echo "5) Formate suas partições corretamente"
echo "6) Monte suas partições"
echo "7) Ajustar espelhos"
echo "8) Instalar pacotes essênciais em /mnt"
echo "9) Gerar arquivo fstab"
echo "10) Acesse seu sistema montado"
echo "11) Ajustar data e hora"
echo "12) Ajustar idioma [Pendênte]"
echo "13) Ajustar linguagem, teclado e hostname"
echo "14) Editar arquivo /etc/hosts"
echo "15) Defina sua senha root"
echo "16) Instalar pacotes essênciais"
echo "17) Crie seu primeiro usuário"
echo "18) Adicione o usuário ao arquivo de sudoers"
echo "19) Altere a senha de seu novo usuário"
echo "20) Instalar e configurar o grub"
echo "21) Habilitar NetworkManager"
echo "22) Reinicie a máquina e atualize os pacotes"
echo "23) Gerar exemplar de NetPlan [Apenas para wifi]"
echo "24) Aplicar NetPlan [Apenas para wifi]"
echo "25) Reinicie a maquina"
echo " "
echo "[+] Drivers [+]"
echo " "
echo "26) Install Intel drivers"
echo "27) Install Nvidia drivers"
echo "28) Install AMD drivers"
echo "29) install VirtualBox drivers"
echo " "
echo "[+] Interface  [+]"
echo " "
echo "30) Gnome"
echo "31) XFCE"
echo " "
read -p "Escolha uma opção: " -n 2 Resp

case $Resp in
1)
	clear
	echo "Aguarde..."
	wipefs -a /dev/sda >/dev/null
	echo " "
	sleep 3	
	echo "[+] Seu HD foi formatado [+]"
;;
2)
	clear	
	echo "Aguarde..."
	loadkeys br-abnt2
	echo " "
	sleep 3
	echo "[+] Teclado configurado [+]"       	
;;
3)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "Crie uma tabela GPT em seu disco:"
	echo " "
	echo "fdisk /dev/sda"
	echo " "
	echo "Seguido das opções 'g' e 'w'"
;;
4)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "utilize o comando 'cfdisk /dev/sda'"
	echo "Para criar as partições:" 
	echo " "
	echo "[BIOS boot][Size: 1G][Type: BIOS Boot]"
	echo "[Swap][Size: 5G][Type: Linux swap]"
	echo "[Raiz][Size: 50G][Type: Linux file system]"
	echo "[Home][Size: Restante][Type: Linux file system]"
	echo " "
	echo "Tutorial em video ()"
;;
5)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "Formate suas partições:"
	echo " "
	echo "mkfs.fat -F32 BIOS_BOOT"
	echo "mkswap SWAP"
	echo "mkfs.ext4 RAIZ"
	echo "mkfs.ext4 HOME"	
;;
6)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "Monte suas partições:"
	echo " "
	echo "mount RAIZ /mnt"
	echo "mkdir /mnt/home"
	echo "mount HOME /mnt/home"
	echo "swapon SWAP"
;;
7)
	clear
	echo "Aguarde..."
	cat Resources/mirrorlist > /etc/pacman.d/mirrorlist
	echo " "
	sleep 3
	clear
	echo "[+] Mirrorlist ajustada [+]"

;;
8)
	clear
	echo "Aguarde.."
	sleep 2
	pacstrap /mnt base base-devel linux linux-firmware
	echo " "
	sleep 3
	clear
	echo "[+] Pacotes instalados com sucesso  [+]"
;;
9)
	clear
	echo "Aguarde.."
	genfstab -U -p /mnt >> /mnt/etc/fstab
	echo " "
	sleep 3
	clear
	echo "[+] Arquivo fstab gerado [+]"
;;
10)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "Utilize o comando 'arch-chroot /mnt'"
;;
11)
	clear
	echo "Aguarde.."
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	hwclock --systohc
	sleep 3
	clear
	echo "[+] Data e hora ajustadas [+]"
;;
12)
	clear
	echo "[+] ETAPA MANUAL [+]"
	echo " "
	echo "Descomente a linha 'pt_BR.UTF-8 UTF-8'"
	echo "localizada no arquivo: /etc/locale.gen"
	echo " "
	echo "Agora utilize o comando 'locale-gen'"
	echo "para finalizar a configuração"
;;
13)
	clear
	echo "Aguarde..."
	echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
	echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
	echo arch >> /etc/hostname
	sleep 3
	clear
	echo "[+] Linguagem, teclado e hostname configurados [+]"
;;
14)
	clear
	echo "Aguarde..."
	cat Resources/hosts > /etc/hosts
	sleep 3
	clear
	echo "[+] Arquivo de hosts configurado [+]"
;;
15)
	clear
	echo "Aguarde..."
	sleep 3
	clear
	passwd
	sleep 3
	clear
	echo "[+] Senha atualizada [+]"
;;
16)
	clear
	echo "Aguarde..."
	pacman -S dosfstools mtools networkmanager wpa_supplicant wireless_tools dialog sudo netplan net-tools
	sleep 3
	clear
	echo "[+] Pacotes instalados [+]"
;;
17)
	clear
	echo "Aguarde..."
	useradd -m -g users -G wheel administrator
        sleep 3
	clear
	echo "[+] Usuario administrator criado [+]"
;;
18)
	clear
	echo "Aguarde..."
	echo 'administrator ALL=(ALL)ALL' >> /etc/sudoers
	sleep 3
	clear
	echo "[+] Usuario administrator agora como sudo [+]"

;;
19)
	clear
	echo "Aguarde..."
	sleep 3
	clear
	`passwd alan`
	pwd
	sleep 3
	clear
	echo "[+] Senha do usuario administrator atualiada [+]"
;;
20)
	clear
	echo "Aguarde..."
	pacman -S grub
	grub-install --target=i386-pc --recheck /dev/sda
	cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
	grub-mkconfig -o /boot/grub/grub.cfg
;;
21)
	clear
	echo "Aguarde..."
	systemctl start NetworkManager
	systemctl enable NetworkManager
	sleep 3
	clear
	echo "[+] NetworkManager habilitado [+]"
;;
22)
	clear
	echo "Após a reinicialização atualize a maquina"
	sleep 8
	reboot
;;
23)
	clear
	echo "Aguarde..."
	mkdir /etc/netplan
	touch /etc/netplan/wifi.yaml
	cat Resources/Wifi.yaml >> /etc/netplan/wifi.yaml
        sleep 3
	clear
	echo "Edite o arquivo /etc/netplan/wifi.yaml"
	echo "para as configurações da sua internet"
;;
24)
	clear
	echo "Aguarde..."
	netplan apply
	sleep 3
	clear
	echo "[+] Netplan aplicado [+]"
;;
25)
	clear
	echo "Reiniciando, Have fun!!!"
	sleep 5
	reboot
;;
*)
	clear
	echo "Não implementado"
;;
esac

















	
	echo " "
	read -p "Deseja selecionar outra opção? [y/n]" -n 1 loop
	clear
done
