# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "zen";
  networking.wireless = {
    enable = true;
    interfaces = [ "wlp2s0" ];
    userControlled.enable = true;
    # v--- this is required to autogenerate wpa_supplicant.conf
    networks = { dummy = {}; };
  };
  networking.connman.enable = true;
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true; # Chrome
  environment.systemPackages = with pkgs; [
    wget vim git
    i3 termite xorg.xbacklight escrotum
    google-chrome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  services.ntp.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.libinput.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;



  users.mutableUsers = false;
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$1$bUCc9/PD$GcGnBauKqhCEvI8nrW4XP/";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
