# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # boot.loader.grub.efiSupport = true;
    # boot.loader.grub.efiInstallAsRemovable = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you wan<t to install Grub.
    # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
    device = "/dev/sda";
  };

  # Enable sound.
  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "nixos-718"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;
    networkmanager.enable = true; 

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
    firewall.enable = true;
  };



  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
   };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };


  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim firefox emacs gnome3.nautilus gnome3.gedit git killall libsForQt5.vlc gimp alacritty pstree neofetch
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };
  programs.nm-applet.enable = true;

  services = {
    fstrim.enable = true;
    openssh.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      # enable = true;
      # layout = "us";
      # xkbOptions = "eurosign:e";

      # Enable the KDE Desktop Environment.
      # displayManager.sddm.enable = true;
      # desktopManager.plasma5.enable = true;

      enable = true;
      layout = "fr";
      xkbOptions = "eurosign:e";
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          #i3blocks #if you are planning on using i3blocks over i3status
       ];
      };

      # Enable touchpad support.
      libinput = {
        enable = true;
        naturalScrolling = false;
        tapping = true;
        middleEmulation = true;
      };
    };
    blueman.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guilhermo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # wheel = enable ‘sudo’ for the user.
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}



