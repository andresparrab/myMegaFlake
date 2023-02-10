{

description = "fufexan's NixOS and Home-Manager flake";

 inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay = {
        url = "github:nix-community/neovim-nightly-overlay";
        inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
      };
      hyprpicker.url = "github:hyprwm/hyprpicker";
      hypr-contrib.url = "github:hyprwm/contrib";
      flake-utils.url = "github:numtide/flake-utils";
      nixgl = {                                                             # OpenGL
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      eww = {
        url = "github:elkowar/eww";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.rust-overlay.follows = "rust-overlay";
      };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "fu";
    };
    fu.url = "github:numtide/flake-utils";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
#
#
#
outputs = inputs @ { self, nixpkgs, home-manager, hyprland, hyprpicker, hypr-contrib, flake-utils, nixgl, eww, ... }:
   let                                                                     # Variables that can be used in the config files.
     user = "loco";
     location = "$HOME/.setup";
    in
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user location hyprland eww nixgl;   # Also inherit home-manager so it does not need to be defined here.
        }
      );
};

}
