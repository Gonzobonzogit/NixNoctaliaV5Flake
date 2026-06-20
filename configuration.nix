{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.noctalia-greeter.nixosModules.default
  ];

  # ---------------------------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------------------------
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.gonzo = import ./home.nix;
  home-manager.extraSpecialArgs = { inherit inputs; };
  nixpkgs.config.allowUnfree = true;

  # ---------------------------------------------------------------------------
  # Boot / Kernel
  # ---------------------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  #----------------------------------------------------------------------------
  # Auto-Clean boot menu
  #----------------------------------------------------------------------------
  nix.gc = {
  	automatic = true;
  	dates = "weekly";
  	options = "--delete-older-than 7d";
  };

  # ---------------------------------------------------------------------------
  # Networking
  # ---------------------------------------------------------------------------
  networking.hostName = "NERV";
  networking.networkmanager.enable = true;

  nix.settings = {
  	extra-substituters = [ "https://noctalia.cachix.org" ];
  	extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };
   time.timeZone = "America/Chicago";

  # ---------------------------------------------------------------------------
  # Graphics — AMD RX 7900 XTX
  # ---------------------------------------------------------------------------
  hardware.graphics = {
    enable = true;
    enable32Bit = true;          # required for Steam / Proton
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  # ---------------------------------------------------------------------------
  # Display Manager + Desktops (GNOME + Hyprland, mirroring P14s)
  # ---------------------------------------------------------------------------
  services.xserver.xrandrHeads = [
    { output = "eDP-1"; primary = true; }
    #   { output = "HDMI-A-1"; primary = true; }
    #{ ooutput = "DP-3"; }
  ];
  #--------------------------------------------------------------------------
  # Gnome program
  #--------------------------------------------------------------------------
  services.gnome = {
    core-apps.enable = true;
    gnome-keyring.enable = true;
    core-developer-tools.enable = true;
    games.enable = true;
    evolution-data-server.enable = true;
  };

 services.desktopManager.gnome.enable = true;
 
  xdg.portal ={
  	enable = true;
  	extraPortals = [pkgs.xdg-desktop-portal-gtk];
  	config.common.default = "*";
  };


  
  services.greetd = {
    enable = true;
    package = pkgs.greetd;
    restart = !(config.services.greetd.settings ? initial_session);
  };

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings.cursor = {
      theme = "Lyra-X";
      size = 24;
      package = pkgs.lyra-cursors;
    };
  };
  

  #-------------------------------------------------------------------------
  # GDM Service
  #-------------------------------------------------------------------------
  services.displayManager.gdm.enable = false;

  #--------------------------------------------------------------------------
  #Hyprland Tiling WM
  #--------------------------------------------------------------------------

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  programs.niri.enable = true;
  programs.hyprlock.enable = true;




  # ---------------------------------------------------------------------------
  # Audio
  # ---------------------------------------------------------------------------
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth.enable = true;
 #-----------------------------------------------------------------------------
 # Security
 #-------------------------------------------------------------------------------
  
  security.rtkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.unprivilegedUsernsClone = true;
  # ---------------------------------------------------------------------------
  # Input / Misc services
  # ---------------------------------------------------------------------------
  services.libinput.enable = true;
  services.mullvad-vpn.enable = true;
  services.openssh.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  #Fingerprint reader
  services.fprintd.enable = true;


  #Emacs Daemon
  services.emacs ={
  	enable= true;
  };


  #Ollama server
  services.ollama = {
  	enable = true;
  	package = pkgs.ollama-rocm;
  	environmentVariables = {
		OLLAMA_ORIGINS = "*";
    };
  };

  # Jellyfin server — was started via alias on the P14s; declared properly here.
  services.jellyfin = {
    enable = true;
   # openFirewall = true;         # opens 8096 (HTTP) and 8920 (HTTPS)
  };

  # PostgreSQL — was started via alias on the P14s; declared properly here.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     127.0.0.1/32  trust
      host  all       all     ::1/128       trust
    '';
  };

  #Hydra for development projects
  services.hydra = {
  	enable = true;
  	hydraURL = "http://localhost:3000";
  	notificationSender = "hydra@localhost";
  	buildMachinesFiles = [];
  	useSubstitutes = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  programs.mosh.enable = true;

  programs.appimage = {
  	enable = true;
  	binfmt = true;
  };



  # ---------------------------------------------------------------------------
  # Users
  # ---------------------------------------------------------------------------
  users.users.gonzo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "render" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      pkgs.tree
    ];
  };

  #---------------------------------------------------------------------------
  # Environment Variables
  #---------------------------------------------------------------------------
  environment.sessionVariables = {
    XCURSOR_THEME = "Lyra-cursors";
    GTK_THEME = "Catppuccin-Macchiato";
  };


  # ---------------------------------------------------------------------------
  # System packages
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
	  (import ./pkgs/msty.nix { inherit pkgs; })
	  (import ./pkgs/helium.nix {inherit pkgs; })
    # --- Core CLI / system ---
    pkgs.feh
    pkgs.regreet
    pkgs.fuzzel
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.grim
    pkgs.slurp
    pkgs.udev
    pkgs.fprintd
    pkgs.fprintd-tod
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.bluez
    pkgs.gccNGPackages_15.libatomic
    pkgs.proot
    pkgs.starship
    pkgs.electron
    pkgs.wlr-protocols
    pkgs.xwayland
    pkgs.ninja
    pkgs.meson
    pkgs.go
    pkgs.typescript
    pkgs.python3
    pkgs.mmtui
    pkgs.bluetui
    pkgs.fltrdr
    pkgs.tdf
    pkgs.nix-inspect
    pkgs.xplr
    pkgs.wlsunset
    pkgs.projectable
    pkgs.clipse
    pkgs.bit-logo
    pkgs.libcryptui
    pkgs.multimarkdown
    pkgs.rsync
    pkgs.figlet
    pkgs.neo-cowsay
    pkgs.uwufetch
    pkgs.fastfetch
    pkgs.keepassxc
    pkgs.asciiquarium-transparent
    pkgs.ascii-image-converter
    pkgs.asciinema
    pkgs.btop
    pkgs.ddcutil
    pkgs.ddcutil-service
    pkgs.cmatrix
    pkgs.pipes-rs
    pkgs.yazi
    pkgs.bubblewrap
    pkgs.yaziPlugins.rsync
    pkgs.yaziPlugins.starship
    pkgs.yaziPlugins.glow
    pkgs.ffmpeg-full
    pkgs.kdePackages.qt6ct

    # --- PGP/Encryption ---
    pkgs.kdePackages.kleopatra
    pkgs.ssh-to-pgp
    pkgs.gnupg
    pkgs.gpg-tui
    pkgs.pinentry-qt
    #pkgs.openssl_4
    pkgs.mosh

    # --- Vim / Neovim ---
    pkgs.vimPlugins.autosave-nvim
    pkgs.neovim
    pkgs.vimPlugins.astrotheme
    pkgs.vimPlugins.cheatsheet-nvim
    pkgs.vimPlugins.vim-javascript-syntax
    pkgs.dconf2nix


   # ---  text editors ---
    pkgs.nano
    pkgs.micro
    pkgs.obsidian


    # --- Terminals ---
    pkgs.ghostty
    pkgs.kitty
    pkgs.cool-retro-term
    pkgs.tmux
    pkgs.tmuxPlugins.dracula

    # --- Browsers / Comms ---
    pkgs.librewolf
    pkgs.firefox-devedition
    pkgs.ff2mpv
    pkgs.thunderbird
    pkgs.discord
    pkgs.fluffychat
    pkgs.equibop
    pkgs.equicord
    pkgs.materialgram
    pkgs.protonmail-bridge



    # --- Media / Creative ---
    pkgs.spotify
    pkgs.spotify-tray
    pkgs.gimp
    pkgs.libreoffice
    pkgs.vlc
    pkgs.mpv
    pkgs.mpvpaper
    pkgs.wf-recorder
    pkgs.gpu-screen-recorder

    # --- Dev / Databases ---
    pkgs.pgadmin4
    pkgs.postgrest
    pkgs.react-native-debugger
    pkgs.yuicompressor

    # --- MongoDB (commented out — uncomment if/when needed) ---
    # mongodb
    # mongodb-tools
    # mongodb-compass

    # --- AI / Local Inference ---
    pkgs.ollama-rocm
    pkgs.alpaca
    pkgs.lmstudio
    pkgs.mcp-server-fetch
    pkgs.claude-code

    # --- Niri ---
    pkgs.niri
    pkgs.nirius
    pkgs.niriswitcher


    # --- Hyprland ecosystem ---
    pkgs.hyprland
    pkgs.wl-freeze
    pkgs.hyprland-activewindow
    pkgs.hyprshade
    pkgs.hyprcursor
    pkgs.hyprsunset
    pkgs.hyprland-qt-support
    pkgs.hypridle
    pkgs.hyprkeys
    pkgs.hyprviz
    pkgs.hyprpolkitagent
    pkgs.hyprland-protocols
    pkgs.hyprland-qtutils
    pkgs.hyprlock
    pkgs.rose-pine-hyprcursor
    pkgs.hyprlauncher
    pkgs.hyprmon
    pkgs.hyprsysteminfo
    pkgs.hyprshell
    pkgs.hyprland-workspaces-tui

    # --- Noctalia ---
    pkgs.noctalia-qs
    #(pkgs.noctalia-shell.override { calendarSupport = true; })

    #--- Python ---
    pkgs.python312Packages.pyfiglet
    pkgs.python312Packages.pyqt6-webengine
    pkgs.python312Packages.pyqt6
    pkgs.python313Packages.bcrypt
    pkgs.libportal-qt6


    # --- Portals ---
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland

    # --- GNOME extras ---
    pkgs.gnome-tweaks
    pkgs.gnome-keyring
    pkgs.gnome-keysign
    pkgs.gnome-video-effects
    pkgs.gnome-packagekit
    pkgs.gnome-icon-theme
    pkgs.gnome-software
    pkgs.gnote
    pkgs.gnome-extension-manager
    pkgs.code-nautilus
    pkgs.gtk4
    pkgs.gdm-settings


    # --- Themes / Icons / Cursors ---
    pkgs.catppuccin-cursors
    pkgs.faba-icon-theme
    pkgs.rose-pine-kvantum
    pkgs.mojave-gtk-theme
    pkgs.catppuccin
    pkgs.ayu-theme-gtk
    pkgs.sweet-folders
    pkgs.arcticons-sans
    pkgs.marwaita-icons
    pkgs.material-design-icons
    pkgs.dracula-icon-theme
    pkgs.zafiro-icons
    pkgs.nordzy-icon-theme
    pkgs.oranchelo-icon-theme
    pkgs.whitesur-icon-theme
    pkgs.papirus-icon-theme
    pkgs.lyra-cursors
    pkgs.qogir-theme
    pkgs.andromeda-gtk-theme
    pkgs.candy-icons
    pkgs.nixos-artwork.wallpapers.catppuccin-macchiato

    # --- Fonts (Nerd) ---
    nerd-fonts.hack
    nerd-fonts._3270
    nerd-fonts.noto
    nerd-fonts.iosevka
    nerd-fonts.d2coding
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.departure-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts.zed-mono
    nerd-fonts.lilex
    
    # --- VPN ---
    pkgs.mullvad-vpn
    pkgs.mullvad

    # --- Appimages ---
    pkgs.appimage-run
	  pkgs.libappimage
    pkgs.linuxdeploy


    # --- Gaming (just Steam for now) ---
    pkgs.steam
    pkgs.mesen
    pkgs.mgba


    # --- Misc fun / utilities ---
    pkgs.wayland-bongocat
    pkgs.variety
    pkgs.gearlever
    pkgs.doomretro

    # --- Jellyfin ---
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    pkgs.delfin

    # --- Custom ---
    pkgs.gonzo
  ];

    # --- Old Unmaintained Pkgs ---

    nixpkgs.config.permittedInsecurePackages = [
  		"nexusmods-app-0.21.1"
  		"tau-hydrogen"
    ];



  #---------------------------------------------------------------------------
  # Backup SSD with games, ai, etc.
  #---------------------------------------------------------------------------

  fileSystems."/mnt/backUp" = {
  	device = "/dev/disk/by-uuid/831b2301-3bf9-47f5-867c-7973d5f06103";
  	fsType = "ext4";
  	options = [
  	 	"defaults"
  	 	"noatime"
  	 	"nofail"
  	 	"x-systemd.device-timeout=5s"
  	];
  };


  # ---------------------------------------------------------------------------
  # System version — do NOT bump casually
  # ---------------------------------------------------------------------------
  system.stateVersion = "25.11";
}
