
{ lib, inputs, nixpkgs, home-manager, user, location,  hyprland, eww, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {                               # Desktop profile
    inherit system;
    specialArgs = {
      inherit inputs user location;
      host = {
        hostName = "desktop";
        mainMonitor = "HDMI-A-3";
        secondMonitor = "DP-1";
      };
    };
    modules = [
    ./configuration.nix
    #./laptop
    hyprland.nixosModules.default                      #setting upp hyperland

    home-manager.nixosModules.home-manager {          # Home-Manager module that is used.
       home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs user hyprland; # hypr-contrib;
          host = {
            hostName = "myLaptop";     #For Xorg iGPU  | Videocard 
            mainMonitor = "HDMI-A-3"; #HDMIA3         | HDMI-A-1
            secondMonitor = "DP-1";   #DP1            | DisplayPort-1
          };
        };
        home-manager.users.${user} = {
       
        home.stateVersion = "22.11";
          imports = [(import ./home.nix)] ++ 
           #[(import ./desktop/home.nix)];
           [(import ../home/wayland)];
        };
     }

    ];
};
}
