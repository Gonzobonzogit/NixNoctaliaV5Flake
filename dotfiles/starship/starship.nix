  # --- Starship ---
  { ... }:

{
  programs.starship = {
	  enable = true;
	  enableZshIntegration = true;
	  settings = {
	      format = ''
      ┌────\[$jobs$directory\]───\[$username@$hostname$os\]──>
      │$git_branch$git_status$character
      └──>>'';
        right_format = ''\[$time\]'';
    # --- 2. Directory ---
  	  directory={
	      format = "$path";
	      style = "green";
	      read_only = "🔒";
	      read_only_style = "(#84050d)";
	      truncation_length = 0;
	      truncation_symbol = "/";
	    };
    # --- 3. Git ---
	    git_branch ={
	      format = "[$symbol $branch ]($style)";
	      symbol = "on ";
	      style = "(#9500a0)";
      };
	    git_status ={
	      format = "[($all_status$ahead_behind)]($style)";
	      style = "(#4500a0)";
	      staged = "✚";
	      up_to_date = "✅";
	      stashed = "🗄";  
	      modified = "✺";
	      deleted = "✖";
	      renamed = "➜";
	      untracked = "✳";
	      conflicted = "💥";
      };
    # --- 4. Jobs ---
	    jobs = {
	      symbol = "✦ ";
        number_threshold = 2;
        symbol_threshold = 1;
        style = "bold blue";
        format = "[$symbol$number]($style)";	   
      };
      # --- 5. Operating System ---
      os = {
        format = "[$symbol]($style)";
        symbols = { NixOS= "❄"; };
        style = "(#13f9f9)";
      };

      #--- 6. Host ---
    	hostname={
	      ssh_only = false;
	      ssh_symbol = "🌐";
	      format = "[$hostname](#ff69b4)";
      };
      # --- 7. Username --- 
	    username ={
    	  show_always = true;
	      format = "[$user](#87ceeb)";
      };
      # --- 8. Prompt Input Character ---
	    character={
	      success_symbol = "[✔](bold green) ";
	      error_symbol = "[✘](bold red) ";
      };
      # --- 9. Dynamic Language Icons (optional) ---
	    nodejs={
	      format = "[$symbol]($style)";
	      symbol = "";
	      style = "(#b7007d)";
      };
      # --- 10. Sysytem Time ---
      time={
        disabled = false;
        format = "[$time]($style)";
        time_format = "%I:%M:%p";
        style = "(#FFFFFF)";
        utc_time_offset = "local";
      }; 
      # --- 11. Google Cloud ---
	    gcloud = { 
        format = "[$symbol]";
        symbol = "☁️";
	    };
    # --- 11. Continuation Line ---
      continuation_prompt ="▶";
   };
  }; 
}  
