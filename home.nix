{ config, pkgs, inputs, ... }:
{
  imports = [ 
    ./dotfiles/hyprland/hyprland.nix
    ./dotfiles/starship/starship.nix
  ];

  home.username = "gonzo";
  home.homeDirectory = "/home/gonzo";
  home.stateVersion = "25.11";
  home.sessionPath = [ "$HOME/.emacs.d/bin" ];



  xdg.configFile."quickshell/noctalia-shell".source =
    "${inputs.noctalia.packages.${pkgs.system}.default}/share/noctalia-shell";

 # --- Managed dotfiles ---
  #xdg.configFile."starship/starship.toml".source =
  #  inputs.self + /dotfiles/starship.toml;
  #home.file.".p10k.zsh".source =
  #  inputs.self + /dotfiles/p10k/.p10k.zsh;

  # --- Zsh Configuration Module ---
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 1000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh-history";
      history.ignorePatterns = [ "rm *" "pkill" "cp *" ];

    
    plugins = [
       {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        file = "share/zsh/plugins/nix/zsh-completions.plugin.zsh";
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
        file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.sh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      # {
      # 	name = "powerlevel10k";
      # 	src = pkgs.zsh-powerlevel10k;
      #  file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; 
      # }
    ];        
      
      # Fastfetch on every terminal open
      initContent=''
  # Auto-detect prompt: p10k everywhere except cool-retro-term
  #case "$TERM_PROGRAM" in
  #  cool-retro-term)
  #    # Starship — friendlier in CRTerm
  #    if command -v starship >/dev/null 2>&1; then
  #      eval "$(starship init zsh)"
  #    fi
  #    ;;
  #  *)
      # Powerlevel10k everywhere else (ghostty, foot, alacritty, TTY, SSH, etc.)
    # if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
    #  source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    # fi
    # [[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
    # ;;
  #esac

        if [ -x "/etc/nixos/fastfetch/fastfetch.sh" ]; then
          "/etc/nixos/fastfetch/fastfetch.sh"
        elif command -v fastfetch >/dev/null 2>&1; then
          fastfetch -c /etc/nixos/fastfetch/config.jsonc
        fi


	  #Adding uv to local binaries
    	  export PATH="$HOME/.local/bin:$PATH"

		  export PATH="$HOME/.local/bin/goose:$PATH"
    
      '';

      oh-my-zsh = {
        enable = true;
        theme = "";
        plugins = [ "git" "sudo" "z" ];
      };

      shellAliases = {
        resetServer = "sudo pkill ollama && ollama serve";
        edit        = "sudo micro";
        suyazi      = "sudo yazi";
        server      = "npx live-server";
        msty        = "capsh --delamb=all -- -c msty --password-store=\"gnome-libsecret\"";
        updateOS    = "nixos-rebuild switch";
        editOS      = "micro /etc/nixos/configuration.nix";
        editFlake   = "micro /etc/nixos/flake.nix";
        flakeUp     = "nixos-rebuild switch --flake";
        editHome    = "micro /etc/nixos/home.nix";
        hyprEdit    = "micro /etc/nixos/hyprland.nix";
        cleanAll    = "nixos-collect-garbage -d";
        cleanBefore = "nixos-collect-garbage --delete-older-than";
        ls          = "lsd";
        ll          = "lsd -alF";
        la          = "lsd -A";
	    emacs       = "~/.config/emacs/bin/doom";
        l           = "lsd -CF";
        ".."        = "cd ..";
        "..."       = "cd ../..";
        "...."      = "cd ../../..";
        r           = "reset";
        c           = "clear";
        gs          = "git status";
        ga          = "git add .";
        gc          = "git commit -m";
        gp          = "git push";
        nano        = "sudo nano";
        py          = "python3";
        act         = "source venv/bin/activate";
        please      = "sudo";
        weather     = "curl wttr.in";
        shrug       = "echo '¯\\_(ツ)_/¯'";
        create      = "touch";
        em          = "emacs";
        startdb     = "sudo systemctl start postgresql";
        jellyfin    = "sudo systemctl start --now jellyfin.service";
        };
      };

    home.packages = with pkgs; [
            direnv
            libclang
            tree-sitter
            nixfmt-rs
            gopls
            sbcl
            terraform
            shellcheck
            emacsPackages.pytest
            emacsPackages.rjsx-mode
            emacsPackages.flymake-shellcheck
	          emacsPackages.god-mode
	          emacsPackages.purescript-mode
          shfmt
          pipenv
          bat
          git
          cmake
          plocate
          pandoc
          gcc
          gnumake
          lsd
          man
          manix
          curl
          nodejs
          wget
          unzip
          swaybg
          alacritty
          xwayland-satellite
          emacs30-pgtk
          git
          ripgrep
          fd
          libtool
          libvterm
          eslint
          eslint_d
        ];

  }
 
