{ config, lib, pkgs, ... }:

{
  home.username = "jbgreer";
  home.homeDirectory = "/home/jbgreer";

  # home manager release compatibility
  home.stateVersion = "23.05";
  # home manager can install and manage itself
  programs.home-manager.enable = true;

  # packages installed to user profile
  home.packages = with pkgs; [
    alacritty               # fast shell
    bat                     # cat substitute
    cowsay                  # what do the cow say?
    emacs                   # ultimate customizable editor
    file                    # learn file type
    firefox                 # browser
    fortune                 # fortune generator
    fzf                     # fast finder
    gnupg                   # encrypt/decrypt/sign/validate
    jetbrains-mono          # for emacs
    neovim                  # better vim
    nix-zsh-completions     # zsh completions for nix
    nixpkgs-fmt             # format nix files
    oh-my-zsh               # zsh configurator
    pavucontrol             # volume control for pipewire
    ripgrep                 # grep substitute
    stow                    # dotfile manager
    tldr                    # better man pages
    tmux                    # terminal multiplexer
    ubuntu_font_family      # for emacs
    unzip                   # uncompress files
    xbindkeys               # X bind keys
    xclip                   # X cut-n-paste
    xorg.xmodmap            # X key remapper
    zellij                  # terminal multiplexer
    zip                     # compress files
    zsh                     # default shell
  ];

  #fonts = {
    #fontDir.enable = true;
    #enableDefaultFonts = true;
    #enableGhostscriptFonts = true;

    #fontconfig.enable = true;

    #fonts = with pkgs; [
      #corefonts
      #nerdfonts
      #powerline-fonts
      #xkcd-font
      #hack-font
      #fira-code
      #fira-code-symbols
      #jetbrains-mono
      #ubuntu_font_family
    #];
  #};

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12;
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Jim Greer";
    userEmail = "jbgreer@grimjeer.com";
  };

  # gnupg
  #programs.gnupg.agent.enable = true;

  # ssh agent
  #programs.ssh.startAgent = true;

  # zsh
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "emacs"
        "git"    
        #"github"
        "sudo"
        "tmux"
        "vi-mode"
      ];
      theme = "robbyrussell";
    };
  };
}
