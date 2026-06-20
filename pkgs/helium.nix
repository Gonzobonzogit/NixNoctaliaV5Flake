{ pkgs ? import <nixpkgs> {}  }:

let 
	helium-wrapped = pkgs.appimageTools.wrapType2 {
		pname = "helium";
		version = "latest";
		src = pkgs.fetchurl {
			url = "https://github.com/imputnet/helium-linux/releases/download/0.12.4.1/helium-0.12.4.1-x86_64.AppImage";
			hash = "sha256-OgS8HkLBseFrEhNFJxMwp1bg0gzPdfY1VaySAAp7vq0=";
		};

		nativeBuildInputs = [ pkgs.makeWrapper ];
		
	 extraInstallCommands = ''
  	  mv $out/bin/helium $out/bin/helium-original
    	makeWrapper $out/bin/helium-original $out/bin/helium \
      	--add-flags "--user-data-dir=\$HOME/.config/helium-\$HOSTNAME"
	  '';
	};

	helium-icon = pkgs.fetchurl {
			url = "https://raw.githubusercontent.com/imputnet/helium/tree/main/resources/branding/app_icon/raw.png";
			hash = "sha256-5KcjBRmMrhQtHtm267z2MQ+7kKSnIQ8zqD+kuuKr+n0=";	
	};

helium-desktop = pkgs.makeDesktopItem {
		name = "Helium";
		desktopName = "Helium browser";
		exec = "helium %U";
		icon = "/nix/store/f1zgg3vmj1cscny4y50x85z6gbb2x0vw-numix-icon-theme-circle-26.02.21/share/icons/Numix-Circle/48@2x/apps/helium-browser.svg";
		comment = "DeGoogled Chromium based Browser";
		categories = [ "Network" "WebBrowser" ];
		mimeTypes = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
		};
		
		in
         pkgs.symlinkJoin {
         	name = "helium";
         	paths = [ helium-wrapped helium-desktop ];
         	postBuild = ''
         		mkdir -p $out/share/icons/hicolor/256x256/apps
         		cp ${helium-icon} $out/share/icons/hicolor/256x256/apps/helium.png
         	'';         	
         }


