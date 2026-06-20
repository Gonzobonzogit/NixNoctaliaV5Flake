{ config, pkgs, inputs, ... }: {
  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "25.11";

 programs.starship = {
	enable = true;
	enableZshIntegration = true;
	settings = {
	    format= ''
---------------------------------------------------	    
[┌───────────────────>](bold green)
[│](bold green) $directory$git_branch$git_status
[└─>](bold green) $character
'';
right_format = "$username$hostname";

#-------Left Side--------
 	directory = {
	     style = "bold cyan";
	     format = "$path";
	     truncation_length = 3;
	     fish_style_pwd_dir_length = 1;
	};

	git_branch = {
	    symbol = "git:(";
	    style = "bold magenta";
	    format = "$symbol$branch";
	};

	git_status = {
	      format = "($all_status$ahead_behind) ";
	      style = "bold magenta";
	};

#------- Right Side --------

	username = {
	      show_always = true;
              style_user = "bold blue";
              style_root = "bold red";
              format = "$user";
    };

    	hostname = {
      	       ssh_only = false; # Set to true if you only want it when SSH'd
	       style = "bold blue";
      	       format = "@$hostname";
    	};

	character = {
	       success_symbol = "[✔](bold green) ";
	       error_symbol = "[✘](bold red) ";
	};
 };	  
};

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

  }
}
