# ArchLinux_installation-guide
 
## 1) Formate seu HD
* wipefs -a /dev/sda

## 2) Configure seu teclado para o padrao Brasileiro
* loadkeys br-abnt2

## 3) Crie uma nova tabela GPT no seu disco, para que futuramentes possamos criar nossas particoes
* fdisk /dev/sda 
### Seguido das teclas "g" e "w"
