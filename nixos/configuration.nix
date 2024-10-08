{ pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./driver/amd-drivers.nix
      ./packages.nix
      ./fonts/fonts.nix
      ./modules/bundle.nix
  ];

  # Network.
  networking = {
    networkmanager.enable = true;
    hostId = "a5bd07e9";
    hostName = "Rin";
    firewall = {
      enable = true;
      allowedUDPPorts = [];
      allowedTCPPorts = [ 80 443 ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASUREMENT = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UTF-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };
  # Input methods.
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
      ];
    };
  };

  # Shell
  programs.zsh.enable = true;

  # User
  users = {
    users.sumelan = {
      isNormalUser = true;
      description = "Su melan";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" ];
    };
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
  };
  # Enable automatic login for the user.
  services.getty.autologinUser = "sumelan";

  # Security
  security = {
    pam.services.swaylock = {};  #REQUIRE if use swaylock.
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
          && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
          {
            return polkit.Result.YES;
          }
      } )
      '';
    # sudo without password
    sudo.wheelNeedsPassword = false;
  };

  # Systemd
    systemd.services = {
	    NetworkManager-wait-online.enable = false;
	    firewalld.enable = true;
	    power-profiles-daemon = {
		    enable = true;
		    wantedBy = [ "multi-user.target" ];
      };
    };
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

  # Services
  services = {
    openssh = {
      enable = true;
      # Add your SSH public key(s) here, if you plan on using SSH to connect.
      # authorizedKeys.keys = [ ];
      settings = {
        PermitRootLogin = "no";
        # Change to false if you want to SSH using public key(s). (recommended)
        PasswordAuthentication = true;
      };
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user ryan via home-manager!
          user = "sumelan";
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          # command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    flatpak.enable = false;
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    gnome.gnome-keyring.enable = true;
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = "sumelan";
      dataDir = "/home/sumelan";
      configDir = "/home/sumelan/.config/syncthing";
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
  	'';
  };

  # zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
   swapDevices = 1;
  };

  # Extra Module Options
  drivers.amdgpu.enable = true;

  # Add ~/.local/bin/ to $PATH
  environment.localBinInPath = false;

  # Env
  environment.variables = {
    EDITOR = "neovim";
    RANGER_LOAD_DEFAULT_RC = "FALSE";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
  };

  # Virt Manager
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # XDG-Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enableing flakes and optimize store.
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Set system version.
  system.stateVersion = "24.05";
}
