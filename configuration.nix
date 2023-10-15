{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    defaultGateway = "192.168.1.254";
    enableIPv6 = false;
    firewall.enable = true;
    hostName = "jbg";
    interfaces.eth0.ipv4.addresses = [ 
      {
        address = "192.168.1.1";
        prefixLength = 24;
      }
    ];
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # X / Wayland
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "vim";
  };

  # install packages to support flakes
  environment.systemPackages = with pkgs; [
    curl
    git
    vim
    wget
  ];

  # Programs
  programs.ssh.startAgent = true;
  programs.zsh.enable = true;

  # PipeWire A/V daemon
  services.pipewire = {
    enable = true;
    #alsa.enable = true;
    #jack.enable = true;
    pulse.enable = true;
    socketActivation = true;
  };

  # X11
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager.job.preStart = "sleep 2";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      i3blocks
    ];
  };

  # user account
  users.users.jbgreer = {
    isNormalUser = true;
    description = "James B Greer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  # NixOS release default settings for stateful data
  system.stateVersion = "23.05";
}
