{ colors, ... }:
{
  imports = [
    ./git.nix
    ./gtk-qt.nix
    ./kitty.nix
    ./starship.nix
    ./spicetify.nix
    ./vscode.nix
    ./yazi.nix
    ./zsh.nix
    ./mpd/mpd.nix
    ./wms/hyprland.nix { inherit colors; }
    ./wms/eww/eww.nix
    ./wms/hypridle.nix
    ./wms/swappy.nix
    ./wms/dunst/dunst.nix
    ./wms/swaylock/swaylock.nix
    ./wms/hyprlock.nix
    #./wms/hyprshade/hyprshade.nix
    #./wms/swaync/swaync.nix
    ./wms/rofi/rofi.nix
    #./wms/waybar/waybar.nix
    #./wms/wlogout/wlogout.nix
  ];
}
