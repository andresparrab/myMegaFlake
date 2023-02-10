{ config, lib, pkgs, user, ... }:

{ 
#  imports =                                   # Home Manager Modules
#    (import ../modules/programs) ++
#    (import ../modules/services);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      nitch             # Minimal fetch
      ranger            # File Manager

      # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      vlc               # Media Player

      # Apps

      # File Management
      unzip             # Zip Files
#      unrar             # Rar Files
      zip               # Zip

    ];
#    file.".config/wall".source = ../modules/themes/wall;
 #   file.".config/wall.mp4".source = ../modules/themes/wall.mp4;
    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Dracula-cursors";
      #name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
#    stateVersion = "22.05";
  };

#  programs = {
#    hyprland.enable = true;
#  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      #name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-gtk.override {
      #  accents = ["mauve"];
      #  size = "compact";
      #  variant = "mocha";
      #};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      #name = "JetBrains Mono Medium";
      name = "FiraCode Nerd Font Mono Medium";
    };                                        # Cursor is declared under home.pointerCursor
  };

}
