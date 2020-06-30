# ArchLinux_installation-guide
 
## 1) Formate seu HD
* wipefs -a /dev/sda

## 2) Configure seu teclado para o padrao Brasileiro
* loadkeys br-abnt2

## 3) Crie uma nova tabela GPT no seu disco, para que futuramentes possamos criar nossas particoes. Utilize o comando abaixo seguido das opcoes "g" e "w"
* fdisk /dev/sda

## 4) Crie suas particoes para [BIOS Boot], [Swap], [Raiz] e [Home]. Consultar "/Examples/Particoes" para mais detalhes.
* cfdisk /dev/sda

## 5) Formate suas partições corretamente
* mkfs.fat -F32 PARTICAO_BIOS_BOOT
* mkswap PARTICAO_SWAP
* mkfs.ext4 PARTICAO_RAIZ
* mkfs.ext4 PARTICAO_HOME

## 6) Monte suas partições a partir da RAIZ em /mnt:
* mount *PARTICAO_RAIZ* /mnt


