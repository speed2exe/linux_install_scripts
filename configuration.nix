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
  fonts.packages = with pkgs; [
    nerdfonts
    jost
  ];

  # Programs
  programs.thunar.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Free
    ## Desktop
    sxhkd brightnessctl polybar rofi
    dracula-theme dracula-icon-theme
    lxappearance
    ## Terminal
    starship fortune fzf
    alacritty bat fish git fzf eza
    neovim wget fd ripgrep
    gh killall clang gnumake

    # Unfree
    ## Desktop
    microsoft-edge
  ];

  # Defines the first version of NixOS to be installed on this system.
  system.stateVersion = "23.11";
}
