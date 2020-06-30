## 1) Formate seu HD
* wipefs -a /dev/sda

## 2) Configure seu teclado para o padrao Brasileiro
* loadkeys br-abnt2

## 3) Crie uma nova tabela GPT no seu disco, para que futuramentes possamos criar nossas particoes. Utilize o comando abaixo seguido das opcoes "g" e "w"
* fdisk /dev/sda

## 4) Crie suas particoes para [BIOS Boot], [Swap], [Raiz] e [Home]. Para mais detalhes, favor consultar /Examples/Particoes.
* cfdisk /dev/sda

## 5) Formate suas partições corretamente.
* mkfs.fat -F32 BIOS_BOOT
* mkswap SWAP
* mkfs.ext4 RAIZ
* mkfs.ext4 HOME

## 6) Monte suas partições a partir da RAIZ em /mnt.
* mount RAIZ /mnt
* mkdir /mnt/home
* mount HOME /mnt/home
* swapon SWAP

## 7) Edite o arquivo a seguir colocando os espelhos do brasil para o topo do arquivo para que o download dos pacotes não demore mais que o normal.
* vim /etc/pacman.d/mirrorlist

## 8) Instale os pacotes necessários para o sistema.
* pacstrap /mnt base base-devel linux linux-firmware

## 9) Gere o arquivo fstab.
* genfstab -U -p /mnt >> /mnt/etc/fstab

## 10) Acesse seu sistema montado.
* arch-chroot /mnt

## 11) Ajuste a data e hora de seu computador.
* ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
* hwclock --systohc

## 12) Edite o arquivo /etc/locale.gen descomentando a linha “pt_BR.UTF-8 UTF-8”, Em seguida rode o comando a seguir para finalizar a configuracao.
* locale-gen

## 13) Configure a linguagem, teclado e hostname.
* echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
* echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
* echo arch >> /etc/hostname

## 14) Edite o arquivo /etc/hosts adicionando o texto abaixo. Para mais detalhes, favor consultar /Examples/Hosts.
127.0.0.1     localhost.localdomain            localhost<br>
::1           localhost.localdomain            localhost<br>
127.0.1.1     arch.localdomain                 arch 

## 15) Defina a sua senha root.
* passwd

## 16) Adicione alguns pacotes essenciais (Opcional).
* pacman -S dosfstools mtools networkmanager wpa_supplicant wireless_tools dialog sudo netplan net-tools

## 17) Crie seu primeiro usuario.
* useradd -m -g users -G wheel USER_NAME

## 18) adicione o usuário criado no aqruivo /etc/sudoers adicionando o seguinte texto no final do arquivo.
USER_NAME ALL=(ALL)ALL

## 19) Altere a senha de seu novo usuario.
* passwd USER_NAME

## 20) Instale o GRUB para inicialização.
* pacman -S grub
* grub-install --target=i386-pc --recheck /dev/sda
* cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
* grub-mkconfig -o /boot/grub/grub.cfg

## 21) Reinicie a máquina e conecte-se a internet [Cabeada].
* systemctl start NetworkManager

## 21) Reinicie a máquina e conecte-se a internet [Wi-fi] configurando o arquivo /etc/netplan/wifi.yaml. Para mais detalhes, favor consultar /Examples/NetPlan.
* netplan apply

## 22) Atualize o sistema a habilite a inicialiacao do NetworkManager.
* pacman -Sy
* systemctl enable NetworkManager

## 23) Instale o driver de video certo de acrodo com a sua maquina.
*Intel*
* pacman -S xf86-video-intel libgl mesa

*Nvidia*
* pacman -S nvidia nvidia-libgl mesa

*AMD*
* pacman -S mesa xf86-video-amdgpu

*VIRTUAL BOX*
* pacman -S virtualbox-guest-utils mesa mesa-libgl

## 24) Instale sua interface grafica preferida.
*Gnome*
* pacman -S gdm gnome gnome-terminal nautilus gnome-tweaks gnome-control-center gnome-backgrounds adwaita-icon-theme
* systemctl enable gdm

*XFCE*
* pacman -S gdm xfce4 xfce4-goodies xfce4-terminal


## 25) Have fun!!!
