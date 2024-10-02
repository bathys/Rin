{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
      disable_loading_bar = true;
      grace = 10;
      hide_cursor = true;
      no_fade_in = false;
      };
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      image = [
        {
          path = "$HOME/.config/pfp.png";
          size = 150;
          border_size = 4;
          border_color = "rgb(A6DA95)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(8AADF4)";
          inner_color = "rgb(5B6078)";
          outer_color = "rgb(24273A)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}