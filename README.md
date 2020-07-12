# my dotfiles
This repo is where I'll store all my important dotfiles, as well as instructions on how to install Arch so that I don't forget in the future. Eventually, I want to make a [Larbs-y](https://larbs.xyz) script to install this automatically, but I will have to have some free time for that.

## my setup

OS - [Arch Linux](https://www.archlinux.org)  
Desktop Manager - [LightDM](https://wiki.archlinux.org/index.php/LightDM)  
Window Manager - [AwesomeWM](https://awesomewm.org)  
Editor - Reluctantly [Neovim](https://github.com/neovim/neovim)  
Terminal - My own fork of [st](https://st.suckless.org) with [tabbed](https://tools.suckless.org/tabbed/)  
Shell - [Zsh](https://www.zsh.org) (with no package manager)

# arch installation

The golden rule of installing/using Arch Linux is this:  
### **TRUST THE [ARCH WIKI](https://wiki.archlinux.org).**  
This tutorial is meant to supplement the Arch Wiki's wonderful install guide with some of my own findings.  
*If anything I say conflicts with the Arch Wiki, trust the Arch Wiki.*

That being said, to start, go to the wiki's [installation guide](https://wiki.archlinux.org/index.php/Installation_guide) and follow the instructions.  
This README will match the headers of the wiki with my two cents. *Read both fully before doing anything. Installation is way wackier on Arch than on a more accessible distro.*

Oh--also, this README is kinda targeted towards non-dual-booting. Dual booting shouldn't be that different though, just read [this](https://wiki.archlinux.org/index.php/Dual_boot_with_Windows).

Alright, let's go.

## pre-installation
You're gonna want to get a `.iso`. These are available from a list of mirrors in the **HTTP Direct Downloads** section of [this site.](https://www.archlinux.org/download/).  
I recommend scrolling down to the **United States** section of the mirrors and downloading from one of the `.edu` sources, since they're implicitly trustworthy.

### verify signature
It's probably prudent to do this, but I don't think anybody really does.

### boot the live environment
If you're making a [live USB stick](https://wiki.archlinux.org/index.php/USB_flash_installation_medium), I recommend using [the command-line utility `dd`](https://wiki.archlinux.org/index.php/USB_flash_installation_medium#Using_basic_CLI_utilities).  
It's one single command that does everything that a GUI tool like Etcher or GNOME Disk Utility will do.  

Your flash drive is likely `/dev/sda` or `/dev/sdb`. If you know the size of the flash drive, you can probably figure out which it is using `lsblk`. Otherwise, just unplug it and see which entry disappears. :+1:

Once you boot the live environment, your goal will be to **install Arch and make it self-sufficient.** I recommend adding as few bells/whistles as possible during installation--being in the live environment means playing with `root` access, which is *spooky*.

### set the keyboard layout
It's US by default. There are ways to permanently change keyboard layout, or to toggle it, but for now, just use  
`loadkeys colemak`  
at the beginning of your session.
(To get it back to normal, use `loadkeys us`)

### verify the boot mode
You're UEFI. You can double check if you don't believe me.

### connect to the internet
In the live install, [use `iwctl`](https://wiki.archlinux.org/index.php/Iwd#iwctl) to configure wifi. You'll likely [use `nm` or its brethren](https://wiki.archlinux.org/index.php/NetworkManager) in your actual install, but `iwctl` is fine for what we're doing.  
*Note: The live disk can't store any network configuration, so if you have to reboot the live disk, you'll need to redo this step.*

### update the system clock
sure. just do what it says.

### partition the disks
This is likely going to be your most nervewracking step. Instead of the visual partition system that you're used to, you'll [use `parted`](https://wiki.archlinux.org/index.php/Parted) to do your partitioning through the command line! Hooray!  

If you're dual booting, make sure you **DON'T** write an entirely new partition table. In fact, it's recommended to [resize your Windows partitions in Windows, then install Arch entirely in the free space you left, without touching Windows at all](https://wiki.archlinux.org/index.php/Dual_boot_with_Windows#Installation).  

If you're moving entirely to Arch (**READ: Not Dual Booting**), [then make sure you *do* write an entirely new partition table](https://wiki.archlinux.org/index.php/Parted#Create_new_partition_table).  

I recommend the following partitions:  
The recommended 260MiB for EFI  
For swap, [RAM + sqrt(RAM)](https://help.ubuntu.com/community/SwapFaq). (Ex: 16GiB RAM -> 16 + 4 = 20 GiB swap)  
The rest allocated to the root directory  

There's a case to be made for using a separate /home partition, but I personally don't think it's worth the hassle.

### format the partitions
Your partitions are labeled: If your drive is `/dev/nvme0n1`, your third partition is `/dev/nvme0n1p3`, for instance.  
You need to format your root partition. You do not need to format your EFI partition or swap.

### mount the file systems
Mount your root filesystem as `/mnt`, and your EFI partition as `/mnt/efi`. This is purely so that you can access those filesystems from the live USB.  
*Note: The live disk will unmount these directories on reboot, so if you have to reboot the live disk, you'll need to redo this step.*

## installation
Hard part's over. I promise. (Well, I don't *promise*, it's sorta all the hard part.)

### select the mirrors
You shouldn't have to do this.

### install essential packages
The command they give you here will install the most barebones Arch Linux there is, and it is *not* enough to make the system self-sufficient.  
Most importantly, it lacks any way to connect to the internet and get new packages. I recommend the slightly beefier:

```pacstrap /mnt base linux linux-firmware vim man-db man-pages networkmanager grub efibootmgr sudo base-devel```

This installs the following extra packages:
- `vim`: a text editor. you can also use `neovim` or `nano`, but i tend to install `neovim` later
- `man-db`, `man-pages`: tools to view man pages. good if you get stuck.
- `networkmanager`: wifi connectivity
- `grub`, `efibootmgr`: necessities to install [GRUB](https://wiki.archlinux.org/index.php/GRUB)
- `sudo`: so you can get out of `root` as fast as possible
- `base-devel`: a large set of packages useful in development and bash scripting, like `which`, `sed`, `awk`, `gcc`, etc.

## Configure the system
Home stretch!

### fstab
Do what it says. This is actually super important for being such a tiny section.

### chroot
Okay, so once you execute that command, you'll be in your installed version of Arch! There's still some stuff to set up, but here are the big changes you'll notice:
- There aren't nearly as many bells and whistles as the Live USB. That's because you've installed barely anything so far.
- `pacstrap` won't install new packages for you. Since you're in the new system, you get to use [the entirety of `pacman`](https://wiki.archlinux.org/index.php/pacman).

### time zone
This isn't that important. Eventually, you can [set it based on location](https://wiki.archlinux.org/index.php/System_time#Setting_based_on_geolocation) which will overwrite whatever you do now.

### localization
Again, this is a very important thing to do.  
However, I wouldn't recommend changing the keyboard layout using `/etc/vconsole.conf`. Eventually, you can set up a toggle-able keymap switcher in AwesomeWM with [the utility `setxkbmap`](https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_setxkbmap). For now, just deal with `loadkeys` until we leave the command line behind.

### network configuration
Do what it says.

You should still be connected to wifi from before, but you could check again with `ping archlinux.org`.  
We'll set up the new wifi system when we reboot.

### initramfs
You won't need to do this.

### root password
Set the root password with `passwd`. We'll deal with the user account later.

### boot loader
Here is the [GRUB install page](https://wiki.archlinux.org/index.php/GRUB#Installation_2).  
Make sure that after you run the `grub-install` command on the wiki, you also run the `grub-mkconfig` command in the [**Configuration** section](https://wiki.archlinux.org/index.php/GRUB#Generate_the_main_configuration_file).

### reboot
Before exiting chroot and rebooting, you should set up your user.  
`useradd -G wheel <username>` (`-G wheel` adds you to the `wheel` group, which is basically an "admin" group)  
`passwd <username>` (set your password)  
`mkdir -vp ~/home/<username>` (make your home directory)  
`chown <username> ~/home/<username>` (set ownership of your home directory)

Next, you'll need to add yourself (or, more accurately, the `wheel` group) as sudoers. To do this, run `visudo`.  
*Note: you may need to install `vi` to use visudo. To do so, just run `pacman -S vi`.*

Once you are in the sudoers file, uncomment the following line:
```
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
```

Your user account should be set up! You should be able to exit chroot, reboot, and log in.

-----------------

## post-installation
You did it! As long as you didn't run into any hiccups (which, let's be honest, you probably did), you are now a proud Arch User!  
You're probably not liking it very much, though. Let's get a window manager installed.

### connecting to Wi-Fi
To [connect to wifi with NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples):  
Enable nmcli [through `systemd`](https://wiki.archlinux.org/index.php/systemd) with `systemctl start NetworkManager.service`.  
Run `nmcli device wifi connect <SSID> password <password>` to connect to a wifi network. We'll have a better solution later.

### clone this repo
The directory doesn't matter. You'll end up copying a lot to ~/.config.

### setting up yay
I highly recommend [reading up on `pacman`, Arch's package manager](https://wiki.archlinux.org/index.php/Pacman). Arch has two places to get packages from: The official Arch repo, which `pacman` uses, and the [Arch User Repository (AUR)](https://wiki.archlinux.org/index.php/Arch_User_Repository). Unlike the official Arch repo, packages sourced from the AUR must be compiled from source.

We will do this by hand once, in order to set up [an AUR helper called `yay`](https://aur.archlinux.org/packages/yay/). Follow the instructions on [yay's git repo](https://github.com/Jguer/yay) to do so.  
*Note: you might need to install git to do so with* `sudo pacman -S git`.


Once `yay` is installed, it will wrap all `pacman` commands, but it will also source from the AUR, so there's no real need to use `pacman` anymore. Note that unlike `pacman`, `yay` shouldn't be run with `sudo`. 
- `yay -S <package>` - install package
- `yay -Rs <package>` - remove package, as well as its unneeded dependencies
- `yay -Syu` - update all packages
- `yay -Q <package>` - search for a package. If `<package>` is not specified, will list all packages.
- `yay -Qe` - list all packages that you *explicitly* installed (i.e. not dependencies).

Setting up yay's settings is not too hard either. First, enable color:  
`sudo vim pacman.conf`  
Uncomment this line in **Misc Options**:  
`# Color`

The rest will be handled by copying `dotfiles/.config/yay/` to `~/.config/yay`.

## setting up a graphical environment
Cool, let's get you set up in AwesomeWM. Clone this repo.  
If you wish to use similar tools, but not use my specific dotfiles, there are some things you need to watch out for. I'll mention those as they come up.

### lightdm
`yay -S lightdm lightdm-webkit2-greeter xorg-server`  
Then, [edit the ligtdm config to use the webkit greeter](https://wiki.archlinux.org/index.php/LightDM#Greeter).  
Finally, [enable the systemd service](https://wiki.archlinux.org/index.php/LightDM#Enabling_LightDM) using `systemctl enable lightdm.service`.

Eventually I'll make my own webkit theme. :)

### awesomeWM
`yay -S awesome-git`  
*Note: This will install the beta version of awesomeWM. It has a better notification system. In the future, this will switch to awesome*

Copy `dotfiles/.config/awesome/` to `~/.config/awesome`.

### st
```
cd dotfiles/suckless/st
sudo make install
cd ../tabbed
sudo make install
```
