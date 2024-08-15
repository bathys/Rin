{pkgs, ... }:
{
  imports = [
      ./options.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    # de stuff
      brightnessctl
      cava
      cliphist
      dunst
      eww
      feh
      gparted
      gwenview
      grim
      grimblast
      kitty
      libnotify
      lm_sensors
      maim
      mpv
      networkmanagerapplet
      rofi-wayland
      polkit_gnome
      slurp
      swappy
      swww
      unrar
      unzip
      wl-clipboard
      wpgtk
      yad
    # audio
      easyeffects
      pamixer
      pavucontrol
      wireplumber
    # programs
      anki-bin
      audiobookshelf
      bitwarden
      bottles
      brave
      brillo
      catppuccinifier-gui
      cpufrequtils
      firefox
      gimp
      greetd.tuigreet
      hypridle
      hyprlock
      hyprpicker
      hyprshade
      kdenlive
      krita
      lutris
      neovide
      obs-studio
      obsidian
      protonup-qt
      steam
      soundconverter
      spicetify-cli
      spotify
      thunderbird
      vencord
      vesktop
      vlc
      udiskie
      wine
      winetricks
      tartube-yt-dlp
    # CLI programs
      acpi
      atuin
      bat
      clinfo
      cmatrix
      cowsay
      curl
      duf
      eza
      fastfetch
      fd
      ffmpeg
      ffmpegthumbnailer
      file
      fzf
      gh # github cli
      git
      htop
      imv
      inxi
      jq
      killall
      libappindicator
      lazygit
      lolcat
      lsd
      lshw
      ncdu
      ncspot
      nh
      nitch
      pciutils
      playerctl
      poppler
      qmk
      ripgrep
      starship
      socat
      spotdl
      unar
      vim
      wget
      xdg-utils
      ydotool
      yt-dlp
      zoxide
    # libs/frameworks
      gtk3
      libsForQt5.kdeconnect-kde
      libsForQt5.qt5.qtwayland
      libvirt
      lxqt.lxqt-policykit
      meson
      ninja
      nixfmt-rfc-style
      nodejs
      opencv
      pkg-config
      python3
      qt6.qtwayland
      v4l-utils
    # vm
      appimage-run
      virt-viewer
      qemu
  ];
}
