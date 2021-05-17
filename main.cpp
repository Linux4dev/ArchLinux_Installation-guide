#include <iostream>
#include <unistd.h>

using namespace std;

void setup(){
    system("clear");
}

void print(string text){
    cout << text << endl;
}

void teardown(){
    sleep(2);
}

void enterToContinue(){
    print("[-] Press ENTER to continue...");
    cin.get();
    system("clear");
}

void start(){
	setup();
    print("[+] Initializing");
	teardown();
}

void formatting(){
    setup();
    print("[+] Formatting the primary HD");
	system("wipefs -a /dev/sda > /dev/null 2>&1");
	teardown();
}

void keyboardConfig(){
    setup();
    print("[+] Configuring the keyboard");
	system("loadkeys br-abnt2 > /dev/null 2>&1");
	teardown();
}

void buildHD(){
    setup();
    print("[-] Manual step");
    print("[-] Create a GPT table with the 'g' and 'w' options");
    print("[-]");
    enterToContinue();
	system("fdisk /dev/sda");

	setup();
    print("[-] Manual step");
    print("[-] Create the partitions");
    print("[-]");
    print("[-] [BIOS boot] [Size: 1G]   [Type: BIOS boot]");
    print("[-] [SWAP]      [Size: 5G]   [Type: Linux swap]");
    print("[-] [ROOT]      [Size: 50G]  [Type: Linux file system]");
    print("[-] [HOME]      [Size: MAX]  [Type: Linux file system]");
    print("[-]");
    enterToContinue();
    system("cfdisk /dev/sda");
}

void mountPartitions(){
    setup();
    print("[-] Semi-automatic step");
    print("[-] Confirm the following messages if necessary");
    print("[-]");
    enterToContinue();

    system("mkfs.fat -F32 /dev/sda1");
    system("clear");
    system("mkswap /dev/sda2");
    system("clear");
    system("mkfs.ext4 /dev/sda3");
    system("clear");
    system("mkfs.ext4 /dev/sda4");
    system("clear");
    system("mount /dev/sda3 /mnt > /dev/null 2>&1");
    system("mkdir /mnt/home");
    system("mount /dev/sda4 /mnt/home > /dev/null 2>&1");
    system("swapon /dev/sda2 > /dev/null 2>&1");
    system("clear");

    print("[+] Mounted partitions");
    teardown();
}

void mirrorsConfig(){
    setup();
    system("cat Resources/mirrorlist > /etc/pacman.d/mirrorlist");
    system("clear");
    print("[+] Configured mirrors");
    teardown();
}

void installPackages(){
    setup();
    print("[+] Essential packages will be installed");
    print("[+] This step may take a while");
    print("[+]");
    enterToContinue();
    system("pacstrap /mnt base base-devel linux linux-firmware");
    system("clear");
    print("[+] Installed packages");
    teardown();
}

void generateFstab(){
    setup();
    system("genfstab -U -p /mnt >> /mnt/etc/fstab");
    system("clear");
    print("[+] Generated fstab file");
    teardown();
}

void switchSystem(){
    setup();
    print("[-] Manual step");
    print("[-]");
    print("[-] Access the directory '/root/ArchLinux_Installer'");
    print("[-] And use the command './setup -s2' to continue the installation");
    print("[-]");
    enterToContinue();
    system("git clone https://github.com/Linux4dev/ArchLinux_Installer /mnt/root");
    system("arch-chroot /mnt");
}

void installMorePackages(){
    setup();
    print("[+] Some packages will be installed");
    print("[+] This step may take a while");
    print("[+]");
    enterToContinue();
    system("pacman -S grub dosfstools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog vim glibc git sudo netplan net-tools");
    system("clear");
    print("[+] Installed packages");
    teardown();
}

void timezoneConfig(){
    setup();
    system("ln -sf /usr/share/zoneinfo/America/Sao_paulo /etc/localtime");
    system("hwclock --systohc");
    system("clear");
    print("[+] Configured date and time");
    teardown();
}

void langConfig(){
    setup();
    system("echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen");
    system("locale-gen > /dev/null 2>&1");
    system("echo LANG=pt_BR.UTF-8 >> /etc/locale.conf");
    system("echo KEYMAP=br-abnt2 >> /etc/vconsole.conf");
    system("echo arch >> /etc/hostname");
    system("clear");
    print("[+] Configured language, keyboard and hostname");
    teardown();
}

void hostsConfig(){
    setup();
    system("cat Resources/hosts > /etc/hosts");
    system("clear");
    print("[+] Configured hosts");
    teardown();
}

void usersConfig(){
    setup();
    print("[-] Manual step");
    print("[-]");
    print("[-] Set a new password for the root user");
    print("[-]");
    enterToContinue();
    system("passwd");
    system("clear");
    print("[-] Password updated");
    teardown();

    setup();
    system("useradd -m -g users -G wheel administrator");
    system("clear");
    print("[+] Administrator user created");
    teardown();

    setup();
    system("echo 'administrator ALL=(ALL)ALL' >> /etc/sudoers");
    system("clear");
    print("[+] Administrator user added to sudoers");
    teardown();

    setup();
    print("[-] Manual step");
    print("[-]");
    print("[-] Set a new password for the administrator");
    print("[-]");
    enterToContinue();
    system("passwd administrator");
    system("clear");
    print("[-] Password updated");
    teardown();
}

void grubConfig(){
    setup();
    system("grub-install --target=i386-pc --recheck /dev/sda > /dev/null 2>&1");
    system("cp /usr/share/locale/en\\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo");
    system("grub-mkconfig -o /boot/grub/grub.cfg > /dev/null 2>&1");
    print("[+] Grub configured");
    teardown();
}

void networkConfig(){
    setup();
    system("systemctl start NetworkManager > /dev/null 2>&1");
    system("systemctl enable NetworkManager > /dev/null 2>&1");
    print("[+] NetworkManager enabled");
    teardown();
}

void finish(){
    setup();
    print("[-] Manual step");
    print("[-]");
    print("[-] Use 'exit' to return to the main system and 'reboot' to restart it");
    print("[-]");
    print("[-] Welcome to Arch linux !!!");
    print("[-]");
    teardown();
}

void helpMessage(){
    setup();
    print("Linux4dev Arch-Linux-Installer");
    print(" ");
    print("User manual");
    print(" ");
    print("-s1 : Initializes the first step of the script, it must be used right after the ArchLinux boot.");
    print(" ");
    print("-s2 : Initializes the second part of the script, responsible for configuring and installing essential packages.");
    print(" ");
    print("--wifi : Used to perform the semi-automatic configurations of the netplan that will allow you to connect via Wifi");
    print(" ");
    teardown();
}

void invalidCommandMessage(){
    setup();
    print("Invalid argument !!!");
    print("type '--help' to know the available commands");
    teardown();
}

void s1Command(){
    start();
	formatting();
	keyboardConfig();
    buildHD();
    mountPartitions();
    mirrorsConfig();
    installPackages();
    generateFstab();
    switchSystem();
}

void s2Command(){
    installMorePackages();
    timezoneConfig();
    langConfig();
    hostsConfig();
    usersConfig();
    grubConfig();
    networkConfig();
    finish();
}

void i3Command(){
    setup();
    print("[+] Warning: Do not run this command as the root user");
    print("[+] If you are as a super user, cancel the execution with (CTRL + C)");
    print("[+]");
    enterToContinue();
    system("sudo pacman -S xorg-server xorg-xinit xorg-apps i3-gaps dmenu i3status i3blocks i3lock xfce4-terminal chromium picom thunar xdg-user-dirs nitrogen leafpad pulseaudio pavucontrol alsa-utils feh imagemagick xcompmgr lxappearance arc-icon-theme arc-gtk-theme cmatrix lolcat neofetch");
    
    setup();
    print("[-] Manual step");
    print("[-]");
    print("[-] The following commands will assist you in using the I3-Gaps");
    print("[-]");
    print("[-] 'setxkbmap br' = Used to configure your keyboard to the standard br-abnt2");
    print("[-] 'startx'       = Used to initialize your I3-Gaps at each reboot");
    print("[-]");
    enterToContinue();
    system("cp Resources/xinitrc ~/.xinitrc");
    system("startx");
}

int main(int argc, char* argv[]){
	if(argc > 1){
		if(argv[1] == string("-s1")){
			s1Command();
		} else if(argv[1] == string("-s2")){
            s2Command();
        } else if (argv[1] == string("-i3")){
            //i3Command(); need repair
        } else if(argv[1] == string("--help")){
            helpMessage();
        } else{
            invalidCommandMessage();
		}
	} else{
        helpMessage();
	}
	return 0;
}