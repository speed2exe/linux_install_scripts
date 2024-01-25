{ config, pkgs, libs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Easiest to use and most distros use this by default.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # User Management
  users.users.zack2827 = {
    isNormalUser = true;
    home = "/home/zack2827";
    extraGroups = [ "wheel" ];
  };

  # X
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [ nerdfonts jost ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Nix
    home-manager

    # Free
    ## Desktop
    xfce.thunar flameshot xclip
    sxhkd brightnessctl polybar rofi
    dracula-theme dracula-icon-theme
    lxappearance picom nitrogen dunst
    ## Terminal
    starship fortune fzf btop
    alacritty bat fish git fzf eza
    wget fd ripgrep neovim procs
    gh killall gcc gnumake

    # Unfree
    ## Desktop
    microsoft-edge
  ];

  # direnv
  programs.direnv.enable = true;

  # GPG sign
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "tty"; # export GPG_TTY=$(tty)
     enableSSHSupport = true;
  };

  # Environment
  environment.variables.EDITOR = "nvim";

  # Defines the first version of NixOS to be installed on this system.
  system.stateVersion = "23.11";
}
