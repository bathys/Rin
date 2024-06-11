{ config, lib, pkgs, ... }:
{
  services.swaync = {
    enable = true;
    style = ''
      @define-color cc-bg #141b1e;
      @define-color noti-bg #232a2d;
      @define-color noti-bg-darker #141b1e;
      @define-color noti-bg-hover #141b1e;
      @define-color noti-bg-focus #141b1e;
      @define-color noti-close-bg #141b1e;
      @define-color noti-close-bg-hover #2E3030;
      @define-color text-color #dadada;
      @define-color text-color-disabled #928374;
      @define-color bg-selected #1B1D1D;

      @define-color black     #232a2d;
      @define-color red       #67b0e8;
      @define-color green     #000000;
      @define-color yellow    #000000;
      @define-color blue      #e57474;
      @define-color purple    #c47fd5;
      @define-color aqua      #6cbfbf;
      @define-color gray      #b3b9b8;
      @define-color brgray    #80AA9E;
      @define-color brred     #F3594B;
      @define-color brgreen   #ee5396;
      @define-color bryellow  #E9B243;
      @define-color brblue    #80AA9E;
      @define-color brpurple  #D3869B;
      @define-color braqua    #8CBA7F;
      @define-color white     #E0CDA5;
      @define-color bg2       #504945;

      * {
        font-family: Iosevka Nerd Font;
        /* font-weight: bolder; */
        }

      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
        opacity: 1;
        background: alpha(@red, 0.25);
        border-radius: 0px;
        margin: 0px;
      }
      .notification {
        border-radius: 10px;
        padding: 0;
        border: 1px solid @noti-close-bg;
        background: @noti-bg-darker;
        /* box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.75);*/
      }
      .notification-content {
        background: transparent;
        padding: 10px;
      }
      .close-button {
        background: @noti-close-bg;
        color: @red;
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 20px;
        margin-right: 13px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px
      }
      .close-button:hover {
        box-shadow: none;
        background: @noti-close-bg-hover;
        transition: all .15s ease-in-out;
        border: none
      }
      .notification-default-action,
      .notification-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: @noti-bg;
        border: none;
        color: @text-color;
        transition: all .15s ease-in-out;
        font-size: 10.5pt;
      }
      .notification-default-action:hover,
      .notification-action:hover {
        -gtk-icon-effect: none;
        background: @noti-bg-hover;
        /* text-shadow: 0 0 3px @text-color; */
      }
      .notification-default-action {
        border-radius: 8px
      }
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0
      }
      .notification-action {
        border-radius: 0;
        border-top: none;
        border-right: none
      }
      .notification-action:first-child {
        border-bottom-left-radius: 10px;
        background: @bgblack
      }
      .notification-action:last-child {
        border-bottom-right-radius: 10px;
        background: @bgblack
      }
      .notification-group-headers {
        font-weight: bold;
        font-size: 10.5pt;
        color: @white;
      }
      .notification-group-icon {
        color: @red;
        margin-right: 8px;
      }
      .notification-group-collapse-button {
        background: @noti-close-bg;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }
      .notification-group-collapse-button:hover {
        background: @noti-close-bg-hover;
        color: @red;
      }
      .notification-group-close-all-button {
        background: @noti-close-bg;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }
      .notification-group-close-all-button:hover {
        background: @noti-close-bg-hover;
        color: @red
      }
      .inline-reply {
        margin-top: 8px
      }
      .inline-reply-entry {
        background: @noti-bg-darker;
        color: @text-color;
        caret-color: @text-color;
        border: 1px solid @noti-border-color;
        border-radius: 10px
      }
      .inline-reply-button {
        margin-left: 4px;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        border-radius: 10px;
        color: @text-color
      }
      .inline-reply-button:disabled {
        background: initial;
        color: @text-color-disabled;
        border: 1px solid transparent
      }
      .inline-reply-button:hover {
        background: @noti-bg-hover;
      }
      .body-image {
        margin-top: 0px;
        background-color: transparent;
        border-radius: 10px
      }
      .summary {
        font-size: 10.5pt;
        font-weight: bold;
        font-style: italic;
        background: transparent;
        color: @red;
        margin-left: 10px;
        /* text-shadow: 0 0 3px @red; */
      }
      .time {
        font-size: 10.5pt;
        font-weight: bold;
        font-style: italic;
        background: transparent;
        color: @brgreen;
        text-shadow: none;
        margin-right: 10px
      }
      .body {
        font-size: 10.5pt;
        font-weight: normal;
        background: transparent;
        color: @text-color;
        text-shadow: none;
        font-weight: bold;
        margin-left: 10px;
      }
      .image {
        background: transparent;
        border-radius: 8px;
      }
      .control-center {
        background: alpha(@cc-bg, 1);
        border-left: 1px solid @noti-close-bg;
        border-radius: 10px;
        margin-left: 10px;
        box-shadow: 0 0 5px 0 #232a2d;
      }
      .control-center-list {
        background: transparent;
      }
      .control-center-list-placeholder {
        opacity: .5
      }
      .floating-notifications .notification-row {
        background: transparent;
        margin: 15px 10px 0 0;
      }
      .blank-window {
        background: alpha(black, 0.0)
      }
      .widget-title {
        color: @red;
        margin: 20px 20px 5px 20px;
        font-size: 10.5pt;
        font-weight: bold;
        font-style: italic;
        /* text-shadow: 0 0 3px @red; */
      }
      .widget-title>button {
        font-size: initial;
        font-weight: bold;
        font-family: 'Symbols Nerd Font';
        color: @brgreen;
        text-shadow: none;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        box-shadow: none;
        border-radius: 10px;
      }
      .widget-title>button:hover {
        background: @noti-bg-hover;
        /* text-shadow: 0 0 3px @brgreen; */
      }
      .widget-dnd {
        color: @text-color;
        margin: 5px 20px 5px 20px;
        font-size: 10.5pt;
        font-weight: bold;
      }
      .widget-dnd>switch {
        font-size: initial;
        border-radius: 999px;
        background: @black;
        /* border: 1px solid @bgblack; */
        box-shadow: none;
        padding: 1px;
        transition: all .1s ease-in-out;
      }
      .widget-dnd>switch:checked {
        background: @brgreen
      }
      .widget-dnd>switch slider {
        background: @noti-bg-hover;
        border-radius: 999px
      }
      .widget-label {
        margin: 10px;
      }
      .widget-label>label {
        font-size: 1.5rem;
        color: @text-color;
      }
      .widget-mpris {
        color: @text-color;
        background: @noti-bg;
        padding: 10px;
        margin: 10px;
        border: 1px solid @noti-close-bg;
        border-radius: 10px;
        /*box-shadow: 0 0 5px 0 rgba(0, 0, 0, 1);*/
      }
      .widget-mpris-player {
        padding: 0px;
        margin: 0px
      }
      .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem
      }
      .widget-mpris-subtitle {
        font-size: 1.1rem
      }
      .widget-buttons-grid {
        font-size: x-large;
        padding: 8px;
        margin: 20px 10px 10px;
        border: 1px solid @noti-close-bg;
        border-radius: 10px;
        background: @noti-bg;
        /*box-shadow: 0 0 5px 0 rgba(0, 0, 0, 1);*/
      }
      .widget-buttons-grid>flowbox>flowboxchild>button {
        margin: 3px;
        background: transparent;
        border-radius: 10px;
        color: @text-color
      }
      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        /* background: @noti-bg-hover; */
        color: @brgreen;
        /* text-shadow: 0 0 3px @white; */
      }
      .widget-menubar>box>.menu-button-bar>button {
        border: none;
        background: transparent
      }
      .topbar-buttons>button {
        border: none;
        background: transparent
      }
      .widget-volume {
        background: @noti-bg;
        padding: 8px;
        padding-left: 16px;
        margin: 10px;
        border: 1px solid @noti-close-bg;
        border-radius: 8px;
        font-size: x-large;
        color: @brgreen;
      }
      .widget-volume>box>button {
        background: @red;
        border: 1px solid @noti-close-bg;
      }
      .per-app-volume {
        background-color: @noti-bg;
        padding: 4px 8px 8px;
        margin: 0 8px 8px;
        border-radius: 10px
      }
      .widget-backlight {
        background: @noti-bg;
        padding: 8px;
        padding-left: 16px;
        margin: 10px;
        border: 1px solid @noti-close-bg;
        border-radius: 8px;
        font-size: x-large;
        color: @brgreen;
      }
      .widget-inhibitors {
        margin: 8px;
        font-size: 1.5rem
      }
      .widget-inhibitors>button {
        font-size: initial;
        color: @text-color;
        text-shadow: none;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        box-shadow: none;
        border-radius: 10px
      }
      .widget-inhibitors>button:hover {
        background: @noti-bg-hover
      }
      '';

settings = {
    "positionX" = "left";
    "positionY" = "top";
    "control-center-margin-top" = 10;
    "control-center-margin-bottom" = 10;
    "control-center-margin-right" = 10;
    "control-center-margin-left" = 10;
    "notification-icon-size" = 48;
    "notification-body-image-height" = 100;
    "notification-body-image-width" = 200;
    "timeout" = 5;
    "timeout-low" = 5;
    "timeout-critical" = 20;
    "fit-to-screen" = true;
    "control-center-width" = 350;
    "notification-window-width" = 350;
    "keyboard-shortcuts" = true;
    "image-visibility" = "when-available";
    "transition-time" = 200;
    "hide-on-clear" = false;
    "hide-on-action" = true;
    "script-fail-notify" = true;
    "widgets" = [
        "title"
        "dnd"
        "notifications"
        "mpris"
        "volume"
        "backlight"
        "buttons-grid"
    ];
    "widget-config" = {
        "title" = {
            "text" = "󰂚 :: Notifications";
            "clear-all-button" = true;
            "button-text" = "󰎟 ";
        };
        "dnd" = {
            "text" = "Do Not Disturb";
        };
        "label" = {
            "max-lines" = 1;
            "text" = "Notification Center";
        };
        "mpris" = {
            "image-size" = 96;
            "image-radius" = 10;
        };
        "volume" = {
            "label" = "󰕾 ";
        };
        "backlight" = {
            "label" = "󰃟 ";
            "subsystem" = "backlight";
        };
        "buttons-grid" = {
            "actions" = [
                {
                    "label" = "󰔏";
                    "command" = "hyprshade toggle redshift";
                }
                {
                    "label" = "󰌵";
                    "command" = "hyprshade toggle dim";
                }
                {
                    "label" = "󰊠";
                    "command" = "hyprshade toggle grayscale";
                }
                {
                    "label" = "󰏘";
                    "command" = "hyprshade toggle vibrance";
                }
                {
                    "label" = "󰌁";
                    "command" = "hyprshade toggle invert";
                }
            ];
          };
        };
      };
    };
  }
