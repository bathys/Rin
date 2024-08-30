{ pkgs, config, lib, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        sort_by = "natural";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 80;
        max_width = 600;
        max_height = 900;
        ueberzug_scale = 1;
        ueberzug_offset = [0 0 0 0];
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };

      open = {
        rules = [
          {
            use = "open";
            mime = "image/*";
          }
          {
            use = ["play" "reveal"];
            mime = "video/*";
          }
          {
            use = ["play" "reveal"];
            mime = "audio/*";
          }
        ];
      };

      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "pqiv \"$@\"";
            desc = "Open";
          }
        ];
        reveal = [
          {
            run = "''${pkgs.exiftool}/bin/exiftool \"$1\"; echo \"Press enter to exit\"; read _''";
            block = true;
            desc = "Show EXIF";
          }
        ];
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
          }
          {
            run = "''${pkgs.mediainfo}/bin/mediainfo \"$1\"; echo \"Press enter to exit\"; read _''";
            block = true;
            desc = "Show media info";
          }
        ];
        archive = [
          {
            run = "unar \"$1\"";
            desc = "Extract here";
          }
        ];
      };
    };

    keymap = {
      manager.keymap = [
        # Custom command
        {
          run = "shell 'dragon -x -i -T \"$@\"' --confirm";
          desc = "Create a window for drag-and-drop";
          on = ["<A-d>"];
        }
        {
          run = "escape";
          desc = "Exit visual mode, clear selected, or cancel search";
          on = ["<Esc>"];
        }
        {
          run = "escape";
          desc = "Exit visual mode, clear selected, or cancel search";
          on = ["<C-[>"];
        }
        {
          run = "quit";
          desc = "Exit the process";
          on = ["q"];
        }
        {
          run = "quit --no-cwd-file";
          desc = "Exit the process without writing cwd-file";
          on = ["Q"];
        }
        {
          run = "close";
          desc = "Close the current tab, or quit if it is last tab";
          on = ["<C-c>"];
        }
        {
          run = "suspend";
          desc = "Suspend the process";
          on = ["<C-z>"];
        }
        # Hopping
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<Up>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["k"];
        }
        {
          run = "arrow 1";
          desc = "Move Cursor down";
          on = ["<Down>"];
        }
        {
          run = "arrow 1";
          desc = "Move Cursor down";
          on = ["j"];
        }
        {
          run = "arrow -50%";
          desc = "Move cursor up half page";
          on = ["<C-u>"];
        }
        {
          run = "arrow 50%";
          desc = "Move cursor down half page";
          on = ["<C-d>"];
        }
        {
          run = "arrow -100%";
          desc = "Move cursor up one page";
          on = ["<C-b>"];
        }
        {
          run = "arrow 100%";
          desc = "Move cursor down one page";
          on = ["<C-f>"];
        }
        {
          run = "arrow -50%";
          desc = "Move cursor up half page";
          on = ["<S-PageUp>"];
        }
        {
          run = "arrow 50%";
          desc = "Move cursor down half page";
          on = ["<S-PageDown>"];
        }
        {
          run = "arrow -100%";
          desc = "Move cursor up one page";
          on = ["<PageUp>"];
        }
        {
          run = "arrow 100%";
          desc = "Move cursor down one page";
          on = ["<PageDown>"];
        }
        {
          run = "arrow -99999999";
          desc = "Move cursor to the top";
          on = ["g" "g"];
        }
        {
          run = "arrow 99999999";
          desc = "Move cursor to the bottom";
          on = ["G"];
        }
        # Navigation
        {
          run = "leave";
          desc = "Go back to the parent directory";
          on = ["<Left>"];
        }
        {
          run = "leave";
          desc = "Go back to the parent directory";
          on = ["h"];
        }
        {
          run = "enter";
          desc = "Enter the child directory";
          on = ["<Right>"];
        }
        {
          run = "enter";
          desc = "Enter the child directory";
          on = ["l"];
        }
        {
          run = "back";
          desc = "Go back to the previous directory";
          on = ["H"];
        }
        {
          run = "forward";
          desc = "Go forward to the next directory";
          on = ["L"];
        }
        # Seeking
        {
          run = "seek -5";
          desc = "Seek up 5 units in the preview";
          on = ["K"];
        }
        {
          run = "seek 5";
          desc = "Seek down 5 units in the preview";
          on = ["J"];
        }
        # Selection
        {
          run = ["select --state=none" "arrow 1"];
          desc = "Toggle the current selection state";
          on = ["<Space>"];
        }
        {
          run = "visual_mode";
          desc = "Enter visual mode (selection mode)";
          on = ["v"];
        }
        {
          run = "visual_mode --unset";
          desc = "Enter visual mode (unset mode)";
          on = ["V"];
        }
        {
          run = "select_all --state=true";
          desc = "Select all files";
          on = ["<C-a>"];
        }
        {
          run = "select_all --state=none";
          desc = "Inverse selection of all files";
          on = ["<C-r>"];
        }
        # Operation
        {
          run = "open";
          desc = "Open selected files";
          on = ["o"];
        }
        {
          run = "open";
          desc = "Open selected files";
          on = ["<Enter>"];
        }
        {
          run = "open --interactive";
          desc = "Open selected files interactively";
          on = ["<S-Enter>"];
        }
        {
          run = "open --interactive";
          desc = "Open selected files interactively";
          on = ["O"];
        }
        {
          run = "yank";
          desc = "Yank selected files (copy)";
          on = ["y"];
        }
        {
          run = "yank --cut";
          desc = "Yank selected files (cut)";
          on = ["x"];
        }
        {
          run = "paste";
          desc = "Paste yanked files";
          on = ["p"];
        }
        {
          run = "paste --force";
          desc = "Paste yanked files (overwrite if the destination exists)";
          on = ["P"];
        }
        {
          run = "link";
          desc = "Symlink the absolute path of yanked files";
          on = ["-"];
        }
        {
          run = "link --relative";
          desc = "Symlink the relative path of yanked files";
          on = ["_"];
        }
        {
          run = "hardlink";
          desc = "Hardlink yanked files";
          on = ["<C-->"];
        }
        {
          run = "unyank";
          desc = "Cancel the yank status";
          on = ["Y"];
        }
        {
          run = "unyank";
          desc = "Cancel the yank status";
          on = ["X"];
        }
        {
          run = "remove";
          desc = "Trash selected files";
          on = ["d"];
        }
        {
          run = "remove --permanently";
          desc = "permanently delete selected files";
          on = ["D"];
        }
        {
          run = "create";
          desc = "Create a file (ends with / for directories)";
          on = ["a"];
        }
        {
          run = "rename --cursor=before_exit";
          desc = "Rename selected file(s)";
          on = ["r"];
        }
        {
          run = "shell --interactive";
          desc = "Run a shell command";
          on = [";"];
        }
        {
          run = "shell --block --interactive";
          desc = "Run a shell command (block untill finishes)";
          on = [":"];
        }
        {
          run = "hidden toggle";
          desc = "Toggle the visibility of hidden files";
          on = ["."];
        }
        {
          run = "search fd";
          desc = "Search files by name using fd";
          on = ["s"];
        }
        {
          run = "search rg";
          desc = "Search files by content using ripgrep";
          on = ["S"];
        }
        {
          run = "escape --search";
          desc = "Cancel the ongoing search";
          on = ["<C-s>"];
        }
        {
          run = "plugin zoxide";
          desc = "Jump to a directory using zoxide";
          on = ["z"];
        }
        {
          run = "plugin fzf";
          desc = "Jump to a directory or reveal a file using fzf";
          on = ["Z"];
        }
        # Linemode
        {
          run = "linemode size";
          desc = "Set linemode to size";
          on = ["m" "s"];
        }
        {
          run = "linemode permission";
          desc = "set linemode to permission";
          on = ["m" "p"];
        }
        {
          run = "linemode ctime";
          desc = "Set linemode to ctime";
          on = ["m" "c"];
        }
        {
          run = "linemode mtime";
          desc = "Set linemode to mtime";
          on = ["m" "m"];
        }
        {
          run = "linemode owner";
          desc = "Set linemode to owner";
          on = ["m" "o"];
        }
        {
          run = "linemode none";
          desc = "Set linemode to none";
          on = ["m" "n"];
        }
        # Copy
        {
          run = "copy path";
          desc = "Copy the file path";
          on = ["c" "c"];
        }
        {
          run = "copy dirname";
          desc = "Copy the directory path";
          on = ["c" "d"];
        }
        {
          run = "copy filename";
          desc = "Copy the filename";
          on = ["c" "f"];
        }
        {
          run = "copy name_without_ext";
          desc = "Copy the filename without extension";
          on = ["c" "n"];
        }
        # Filter
        {
          run = "filter --smart";
          desc = "Filter files";
          on = ["f"];
        }
        # Find
        {
          run = "find --smart";
          desc = "Find next file";
          on = ["/"];
        }
        {
          run = "find --previous --smart";
          desc = "Find previous file";
          on = ["?"];
        }
        {
          run = "find_arrow";
          desc = "Go to the next found";
          on = ["n"];
        }
        {
          run = "find_arrow --previous";
          desc = "Go to the previous found";
          on = ["N"];
        }
        # Sorting
        {
          run = ["sort modified --reverse=no" "linemode mtime"];
          desc = "Sort by modified time";
          on = ["," "m"];
        }
        {
          run = ["sort modified --reverse" "linemode mtime"];
          desc = "Sort by modified time (reverse)";
          on = ["," "M"];
        }
        {
          run = ["sort created --reverse=no" "linemode ctime"];
          desc = "Sort by created time";
          on = ["," "c"];
        }
        {
          run = ["sort created --reverse" "linemode ctime"];
          desc = "Sort by created time (reverse)";
          on = ["," "C"];
        }
        {
          run = "sort extension --reverse=no";
          desc = "Sort by extension";
          on = ["," "e"];
        }
        {
          run = "sort extension --reverse";
          desc = "Sort by extension (reverse)";
          on = ["," "E"];
        }
        {
          run = "sort alphabetical --reverse=no";
          desc = "Sort alphabetically";
          on = ["," "a"];
        }
        {
          run = "sort alphabetical --reverse";
          desc = "Sort alphabetically (reverse)";
          on = ["," "A"];
        }
        {
          run = "sort natural --reverse=no";
          desc = "Sort naturally";
          on = ["," "n"];
        }
        {
          run = "sort natural --reverse";
          desc = "Sort naturally (reverse)";
          on = ["," "N"];
        }
        {
          run = ["sort size --reverse=no" "linemode size"];
          desc = "Sort by size";
          on = ["," "s"];
        }
        {
          run = ["sort size --reverse" "linemode size"];
          desc = "Sort by size (reverse)";
          on = ["," "S"];
        }
        {
          run = "sort random --reverse=no";
          desc = "Sort randomly";
          on = ["," "r"];
        }
        # Goto
        {
          run = "cd ~";
          desc = "Go to the home directory";
          on = ["g" "h"];
        }
        {
          run = "cd ~/.config";
          desc = "Go to the config directory";
          on = ["g" "c"];
        }
        {
          run = "cd ~/Downloads";
          desc = "Go to the downloads directory";
          on = ["g" "d"];
        }
        {
          run = "cd --interactive";
          desc = "Go to a directory interactively";
          on = ["g" "<Space>"];
        }
        # Tabs
        {
          run = "tab_create --current";
          desc = "Create a new tab with CWD";
          on = ["t"];
        }
        {
          run = "tab_switch 0";
          desc = "Switch to the first tab";
          on = ["1"];
        }
        {
          run = "tab_switch 1";
          desc = "Switch to the second tab";
          on = ["2"];
        }
        {
          run = "tab_switch 2";
          desc = "Switch to the third tab";
          on = ["3"];
        }
        {
          run = "tab_switch 3";
          desc = "Switch to the fourth tab";
          on = ["4"];
        }
        {
          run = "tab_switch 4";
          desc = "Switch to the fifth tab";
          on = ["5"];
        }
        {
          run = "tab_switch 5";
          desc = "Switch to the sixth tab";
          on = ["6"];
        }
        {
          run = "tab_switch 6";
          desc = "Switch to the seventh tab";
          on = ["7"];
        }
        {
          run = "tab_switch 7";
          desc = "Switch to the eighth tab";
          on = ["8"];
        }
        {
          run = "tab_switch 8";
          desc = "Switch to the ninth tab";
          on = ["9"];
        }
        {
          run = "tab_switch -1 --relative";
          desc = "Switch to the previous tab";
          on = ["["];
        }
        {
          run = "tab_switch 1 --relative";
          desc = "Switch to the next tab";
          on = ["]"];
        }
        {
          run = "tab_swap -1";
          desc = "Swap current tab with previous tab";
          on = ["{"];
        }
        {
          run = "tab_swap 1";
          desc = "Swap current tab with next tab";
          on = ["}"];
        }
        # Tasks
        {
          run = "task_show";
          desc = "Show task manager";
          on = ["w"];
        }
        # Help
        {
          run = "help";
          desc = "Open help";
          on = ["~"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["<F1>"];
        }
      ];

      completion.keymap = [
        {
          run = "close";
          desc = "Cancel completion";
          on = ["<C-c>"];
        }
        {
          run = "close --submit";
          desc = "Submit the completion";
          on = ["<Tab>"];
        }
        {
          run = ["close --submit" "close_input --submit"];
          desc = "Submit the completion and input";
          on = ["<Enter>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<Up>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<A-k>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<C-p>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<Down>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<A-j>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<C-n>"];
        }
        # Help
        {
          run = "help";
          desc = "Open help";
          on = ["~"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["<F1>"];
        }
      ];

      tasks.keymap = [
        {
          run = "close";
          desc = "Close task manager";
          on = ["<Esc>"];
        }
        {
          run = "close";
          desc = "Close task manager";
          on = ["<C-[>"];
        }
        {
          run = "close";
          desc = "Close task manager";
          on = ["<C-c>"];
        }
        {
          run = "close";
          desc = "Close task manager";
          on = ["w"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<Up>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["k"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<Down>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["j"];
        }
        {
          run = "inspect";
          desc = "Inspect the task";
          on = ["<Enter>"];
        }
        {
          run = "cancel";
          desc = "Cancel the task";
          on = ["x"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["~"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["<F1>"];
        }
      ];
      select.keymap = [
        {
          run = "close";
          desc = "Cancel selection";
          on = ["<Esc>"];
        }
        {
          run = "close";
          desc = "Cancel selection";
          on = ["<C-[>"];
        }
        {
          run = "close";
          desc = "Cancel selection";
          on = ["<C-c>"];
        }
        {
          run = "close --submit";
          desc = "Submit the selection";
          on = ["<Enter>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<Up>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["k"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<Down>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["j"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["~"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["<F1>"];
        }
      ];
      input.keymap = [
        {
          run = "close";
          desc = "Cancel input";
          on = ["<C-c>"];
        }
        {
          run = "close --submit";
          desc = "Submit the input";
          on = ["<Enter>"];
        }
        {
          run = "escape";
          desc = "Go back the normal mode, or cancel input";
          on = ["<Esc>"];
        }
        {
          run = "escape";
          desc = "Go back the normal mode, or cancel input";
          on = ["<C-[>"];
        }
        # Mode
        {
          run = "insert";
          desc = "Enter insert mode";
          on = ["1"];
        }
        {
          run = "insert --append";
          desc = "Enter append mode";
          on = ["a"];
        }
        {
          run = ["move -999" "insert"];
          desc = "Move to the BOL, and enter insert mode";
          on = ["I"];
        }
        {
          run = ["move 999" "insert --append"];
          desc = "Move to the EOL, and enter append mode";
          on = ["A"];
        }
        {
          run = "visual";
          desc = "Enter visual mode";
          on = ["v"];
        }
        {
          run = ["move -999" "visual" "move 999"];
          desc = "Enter visual modde nad select all";
          on = ["V"];
        }
        # Character-wise movement
        {
          run = "move -1";
          desc = "Move back a character";
          on = ["h"];
        }
        {
          run = "move -1";
          desc = "Move back a character";
          on = ["<Left>"];
        }
        {
          run = "move -1";
          desc = "Move back a character";
          on = ["<C-b>"];
        }
        {
          run = "move 1";
          desc = "Move forward a character";
          on = ["l"];
        }
        {
          run = "move 1";
          desc = "Move forward a character";
          on = ["<Right>"];
        }
        {
          run = "move 1";
          desc = "Move forward a character";
          on = ["<C-f>"];
        }
        # Word-wise movement
        {
          run = "backward";
          desc = "Move back to the start of the current or previous word";
          on = ["b"];
        }
        {
          run = "forward";
          desc = "Move forward to the start of the next word";
          on = ["w"];
        }
        {
          run = "forward --end-of-word";
          desc = "Move forward to the end of the current or next word";
          on = ["e"];
        }
        {
          run = "backward";
          desc = "Move back to the start of the current or previous word";
          on = ["<A-b>"];
        }
        {
          run = "forward --end-of-word";
          desc = "Move forward to the end of the current or next word";
          on = ["<A-f>"];
        }
        # Line-wise movement
        {
          run = "move -999";
          desc = "Move to the BOL";
          on = ["0"];
        }
        {
          run = "move 999";
          desc = "Move to the EOL";
          on = ["$"];
        }
        {
          run = "move -999";
          desc = "Move to the BOL";
          on = ["<C-a>"];
        }
        {
          run = "move 999";
          desc = "Move to the EOL";
          on = ["<C-e>"];
        }
        {
          run = "move -999";
          desc = "Move to the BOL";
          on = ["<Home>"];
        }
        {
          run = "move 999";
          desc = "Move to the EOL";
          on = ["<End>"];
        }
        # Delete
        {
          run = "backspace";
          desc = "Delete the character before the cursor";
          on = ["<Backspace>"];
        }
        {
          run = "backspace --under";
          desc = "Delete the character under the cursor";
          on = ["<Delete>"];
        }
        {
          run = "backspace";
          desc = "Delete the character before the cursor";
          on = ["<C-h>"];
        }
        {
          run = "backspace --under";
          desc = "Delete the character under the cursor";
          on = ["<C-d>"];
        }
        # kill
        {
          run = "kill bol";
          desc = "Kill backwards to the BOL";
          on = ["<C-u>"];
        }
        {
          run = "kill eol";
          desc = "Kill forwards to the EOL";
          on = ["<C-k>"];
        }
        {
          run = "kill backward";
          desc = "Kill backwards to the start of the current word";
          on = ["<C-w>"];
        }
        {
          run = "kill forward";
          desc = "Kill forwards to the end of the current word";
          on = ["<A-d>"];
        }
        # Cut/Yanl/Paste
        {
          run = "delete --cut";
          desc = "Cut the slected characters";
          on = ["d"];
        }
        {
          run = ["delete --cut" "move 999"];
          desc = "Cut until the EOL";
          on = ["D"];
        }
        {
          run = "delete --cut --insert";
          desc = "Cut the selected characters, and enter insert mode";
          on = ["c"];
        }
        {
          run = ["delete --cut --insert" "move 999"];
          desc = "Cut until the EOL, and enter insert mode";
          on = ["C"];
        }
        {
          run = ["delete --cut" "move 1 --in-operating"];
          desc = "Cut the current character";
          on = ["x"];
        }
        {
          run = "yank";
          desc = "Copy the selected characters";
          on = ["y"];
        }
        {
          run = "paste";
          desc = "Paste the copied characters after the cursor";
          on = ["p"];
        }
        {
          run = "paste --before";
          desc = "Paste the copied characters before the cursor";
          on = ["P"];
        }
        # Undo/Redo
        {
          run = "undo";
          desc = "Undo the last operation";
          on = ["u"];
        }
        {
          run = "redo";
          desc = "Redo the last operation";
          on = ["<C-r>"];
        }
        # Help
        {
          run = "help";
          desc = "Open help";
          on = ["~"];
        }
        {
          run = "help";
          desc = "Open help";
          on = ["<F1>"];
        }
      ];
      help.keymap = [
        {
          run = "escape";
          desc = "Clear the filter, or hide the help";
          on = ["<Esc>"];
        }
        {
          run = "escape";
          desc = "Clear the filter, or hide the help";
          on = ["<C-[>"];
        }
        {
          run = "close";
          desc = "Exit the process";
          on = ["q"];
        }
        {
          run = "close";
          desc = "Hide the help";
          on = ["<C-c>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["<Up>"];
        }
        {
          run = "arrow -1";
          desc = "Move cursor up";
          on = ["k"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["<Down>"];
        }
        {
          run = "arrow 1";
          desc = "Move cursor down";
          on = ["j"];
        }
        {
          run = "filter";
          desc = "Apply a filter for the help items";
          on = ["f"];
        }
      ];
    };
    theme = {
      manager = {
        
      };
      icon = {
        rules = [
          {
            name = "*.jsx";
            text = "";
          }
          {
            name = "*.lua";
            text = "";
          }
          {
            name = "*.nix";
            text = "";
          }
        ];
      };
      filetype = {
        rules = [
          # Images
          {
            mime = "image/*";
          }
        ];
      };
    };
  };
}
