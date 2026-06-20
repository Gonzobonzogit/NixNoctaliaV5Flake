{ pkgs ? import <nixpkgs> {} }:

	let
	  # Your existing appimage tool wrapper
	  msty-wrapped = pkgs.appimageTools.wrapType2 {
	    pname = "msty";
	    version = "2.7.6";
	    src = pkgs.fetchurl {
		url = "https://next-assets.msty.studio/app/latest/linux/MstyStudio_x86_64.AppImage";
		hash = "sha256-94TBxwU1dTvLRe8Lr00ery68TcjDVKuW8516LwI6+tg=";
	    };
	  };
	in
	pkgs.stdenv.mkDerivation {
	  pname = "msty-capsh-wrapped";
	  version = msty-wrapped.version;

	  # We use buildInputs to pull in the tools we need to rewrite the execution path
	  nativeBuildInputs = [ pkgs.makeWrapper ];

	  dontUnpack = true;

	  installPhase = '' 
	    mkdir -p $out/bin

	    # Create a wrapper that forces capsh to drop ambient caps before calling the appimage binary
	    makeWrapper ${pkgs.libcap}/bin/capsh $out/bin/msty \
	      --add-flags "--delamb=all -- -c ${msty-wrapped}/bin/msty"

	    # Copy over the desktop item if your original wrapper generated one
	    if [ -d "${msty-wrapped}/share" ]; then
	      ln -s ${msty-wrapped}/share $out/share
	    fi
	  '';
	}

