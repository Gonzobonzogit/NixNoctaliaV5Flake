{

  description = ''
  My Personal NixOS Flake featureing a NoctaliaV5 Shell with a custom starship terminal theme
    Includes:
    Helium Browser as NixPkg
    Zen Browser as NixPkg
    MstyStudio as NixPkg
    Custom Starship theme
  '';

nixConfig = {
  extra-substituters = [ "https://noctalia.cachix.org" ];
  extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
};

  inputs = {
      # --- Misc. extra NixPkgs ---
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      # --- Terminal ScreenSaver ---
    drift.url = "github:phlx0/drift";
      # --- Zen Browser nixpkg ---
    zen-browser = {
        url = "github:youwen5/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    }; 

      # --- Home Manager ---
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };

      # --- NoctaliaV5 ---
    noctalia = {
       url = "github:noctalia-dev/noctalia";
       inputs.nixpkgs.follows = "nixpkgs";
    };

      # --- Noctalia theme for greetd ---
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  

  outputs = { self, nixpkgs, home-manager, zen-browser, noctalia, ... }@inputs: {
    nixosConfigurations.NERV = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./dotfiles/noctalia-shell/noctalia.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;    
          home-manager.useUserPackages = true;     
       		home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
       	}
      ];
    };
      hydraJobs = {
    	inherit (self)
    	 packages;
    };
  };
}
