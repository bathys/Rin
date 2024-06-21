{ config, pkgs, ... }:
let
  theme = config.stylix.base16Scheme;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "Iosevka Nerd Font 12";
    extraConfig = {
      modi = "drun";
      display-drun = "";
      show-icons = true;
      drun-display-format = "{name}";
      sidebar-mode = false;
    };
  };
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
    	modi:                       "drun";
      show-icons:                 true;
    	drun-display-format:        "{name}";
    }
    @theme "/dev/null"
    * {
    font:                        "Product Sans 12";
    background:                  #${theme.base01};
    background-alt:              #${theme.base00};
    foreground:                  #${theme.base04};
    selected:                    #${theme.base0D};
    active:                      #${theme.base0A};
    urgent:                      #${theme.base08};
    }

    window {
    transparency:                "real";
    location:   north west;
    anchor:   north west;
    fullscreen:                  false;
    width:                       360px;
    x-offset:                    290px;
    y-offset:                    20px;

    enabled:                     true;
    border-radius:               15px;
    cursor:                      "default";
    background-color:            @background;
    }

    mainbox {
    enabled:                     true;
    spacing:                     0px;
    background-color:            transparent;
    orientation:                 horizontal;
    children:                    [ "listbox" ];
    }

    listbox {
    spacing:                     20px;
    padding:                     20px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    [ "inputbar", "message", "listview" ];
    }

    dummy {
    background-color:            transparent;
    }

    inputbar {
    enabled:                     true;
    spacing:                     10px;
    padding:                     15px;
    border-radius:               10px;
    background-color:            @background-alt;
    text-color:                  @foreground;
    children:                    [ "textbox-prompt-colon", "entry" ];
    }
    textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "  ";
    font:                        "Iosevka Nerd Font 12";
    background-color:            inherit;
    text-color:                  inherit;
    }
    entry {
    enabled:                     true;
    background-color:            inherit;
    text-color:                  inherit;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:           inherit;
    }

    mode-switcher{
    enabled:                     true;
    spacing:                     20px;
    background-color:            transparent;
    text-color:                  @foreground;
    }
    button {
    padding:                     15px;
    border-radius:               10px;
    background-color:            @background-alt;
    text-color:                  inherit;
    cursor:                      pointer;
    }
    button selected {
    background-color:            @background-alt;
    text-color:                  @selected;
    }

    listview {
    enabled:                     true;
    columns:                     1;
    lines:                       5;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;

    spacing:                     10px;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      "default";
    }

    element {
    enabled:                     true;
    spacing:                     15px;
    padding:                     8px;
    border-radius:               10px;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      pointer;
    }
    element normal.normal {
    background-color:            inherit;
    text-color:                  inherit;
    }
    element normal.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
    }
    element normal.active {
    background-color:            @active;
    text-color:                  @foreground;
    }
    element selected.normal {
    background-color:            @background-alt;
    text-color:                  @selected;
    }
    element selected.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
    }
    element selected.active {
    background-color:            @urgent;
    text-color:                  @foreground;
    }
    element-icon {
    background-color:            transparent;
    text-color:                  inherit;
    size:                        32px;
    cursor:                      inherit;
    }
    element-text {
    background-color:            transparent;
    text-color:                  inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
    }

    message {
    background-color:            transparent;
    }
    textbox {
    padding:                     15px;
    border-radius:               10px;
    background-color:            @background-alt;
    text-color:                  @foreground;
    vertical-align:              0.5;
    horizontal-align:            0.0;
    }
    error-message {
    padding:                     15px;
    border-radius:               20px;
    background-color:            @background;
    text-color:                  @foreground;
    }
  '';
}
