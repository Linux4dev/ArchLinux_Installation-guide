# ArchLinux_installation-guide
 
## 1) Formate seu HD
* wipefs -a /dev/sda

## 2) Configure seu teclado para o padrao Brasileiro
* loadkeys br-abnt2

## 3) Crie uma nova tabela GPT no seu disco, para que futuramentes possamos criar nossas particoes. Utilize o comando abaixo seguido das opcoes "g" e "w"
* fdisk /dev/sda

## 4) Crie as partições para ["BIOS boot" Size: 1G Type: BIOS Boot], ["Swap" Size: 5G Type: Linux swap], ["Raiz" Size: 50G Type: File System], ["Home" Size: 1G Type: File System] e  com o comando abaixo. Obs: nao esquecer de escrever as particoes antes de sair do programa, exemplos em: */Examples/Particoes*
* cfdisk /dev/sda

## 5) Formate suas partições corretamente utilizando os comandos abaixo:
* mkfs.fat -F32 BIOS_BOOT
* mkfs.ext4 RAIZ
* mkfs.ext4 HOME
* mkswap SWAP


