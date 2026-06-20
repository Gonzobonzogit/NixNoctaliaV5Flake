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
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    drift.url = "github:phlx0/drift";
      zen-browser = {
        url = "github:youwen5/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      }; 
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      noctalia = {
       url = "github:noctalia-dev/noctalia";
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
