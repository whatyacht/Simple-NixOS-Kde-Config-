
{ pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  # ------------------------------------------
  # HOME MANAGER
  # ------------------------------------------

  home = {
    username = "whatyacht";
    homeDirectory = lib.mkForce"/home/whatyacht";

    enableNixpkgsReleaseCheck = false;

    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # ------------------------------------------
  # VS CODE
  # ------------------------------------------

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
  };

  # ------------------------------------------
  # DISCORD / NIXCORD
  # ------------------------------------------

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    discord = {
      vencord.enable = true;
      krisp.enable = true;
    };

    quickCss = ''
      @import url("https://ridge.codeberg.page/Discord-Adblock/discord-adblock.css");
    '';

    config = {
      useQuickCss = true;

      plugins = {
        fixImagesQuality.enable = true;
        fixYoutubeEmbeds.enable = true;

        disableCallIdle.enable = true;
        callTimer.enable = true;

        shikiCodeblocks.enable = true;

        fullSearchContext.enable = true;
        voiceMessages.enable = true;
        gifPaste.enable = true;
        betterUploadButton.enable = true;

        hideMedia.enable = true;

        noTrack.enable = true;
        alwaysTrust.enable = true;
        platformIndicators.enable = true;
        showHiddenChannels.enable = true;
        showConnections.enable = true;
        consoleJanitor.enable = true;
        translate.enable = true;

        fakeNitro = {
            enable = true;

            enableEmojiBypass = true;
            emojiSize = 48;
            transformEmojis = true;

            enableStickerBypass = true;
            stickerSize = 160;
            transformStickers = true;
            transformCompoundSentence = false;

            enableStreamQualityBypass = true;

            useHyperLinks = true;
            hyperLinkText = "{{NAME}}";

            disableEmbedPermissionCheck = false;
          };

        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreStreaming = true;
          ignoreWatching = true;
          ignoreListening = true;
          ignoreCompeting = true;
        };

        webScreenShareFixes.enable = true;
        biggerStreamPreview.enable = true;
        streamerModeOnStream.enable = true;

      };
    };
  };

  # ------------------------------------------
  # MANGOHUD
  # ------------------------------------------

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  # ------------------------------------------
  # FASTFETCH
  # ------------------------------------------

  
  programs.fastfetch = {
      enable = true;

      settings = builtins.fromJSON ''
        {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
              "type": "kitty",
              "source": "~/.config/fastfetch/logo.png",
              "width": 30,
              "height": 15,
              "padding": {
                  "top": 1,
                  "left": 2
              }
          },
          "display": {
              "color": {
                  "keys": "blue"
              },
              "separator": "",
              "constants": [
                  "──────────────────────────────────────────────────────────────────────",
                  "\u001b[71D",
                  "\u001b[71C",
                  "\u001b[70C",
                  "══════════════════════════════════════════════════════════════════════"
              ],
              "brightColor": false
          },
          "modules": [
              "break",
              {
                  "type": "version",
                  "key": "╔═══════════════╦═{$5}╗\u001b[55D",
                  "format": "\u001b[1m{#keys} {1} - {2} "
             },
              {
                  "type": "os",
                  "key": "║  {icon}  \u001b[s{sysname}\u001b[u\u001b[10C║{$3}║{$2}"
              },
              {
                  "type": "kernel",
                  "key": "║  {icon}  Kernel    ║{$3}║{$2}"
             },
              {
                  "type": "datetime",
                  "key": "║  {icon}  Fetched   ║{$3}║{$2}",
                  "format": "{year}-{month-pretty}-{day-pretty} {hour-pretty}:{minute-pretty}:{second-pretty} {timezone-name}"
              },
              {
                  "type": "custom",
                  "key": "║{#cyan}┌──────────────┬{$1}┐{#keys}║\u001b[50D",
                  "format": "{#bright_cyan} Hardware "
             },
              {
                  "type": "memory",
                  "key": "║{#cyan}│ {icon}  RAM       │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "cpu",
                  "key": "║{#cyan}│ {icon}  CPU       │{$4}│{#keys}║{$2}",
                  "showPeCoreCount": true
              },
              {
                  "type": "gpu",
                  "key": "║{#cyan}│ {icon}  GPU       │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "disk",
                  "key": "║{#cyan}│ {icon}  Disk      │{$4}│{#keys}║{$2}",
                  "format": "{size-used} / {size-total} ({size-percentage}) - {filesystem}"
              },
              {
                  "type": "battery",
                  "key": "║{#cyan}│ {icon}  Battery   │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "custom",
                  "key": "║{#cyan}└──────────────┴{$1}┘{#keys}║",
                  "format": ""
              },
              {
                  "type": "custom",
                  "key": "║{#green}┌──────────────┬{$1}┐{#keys}║\u001b[49D",
                  "format": "{#bright_green} Desktop "
              },
              {
                  "type": "de",
                  "key": "║{#green}│ {icon}  Desktop   │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "wm",
                  "key": "║{#green}│ {icon}  Session   │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "display",
                  "key": "║{#green}│ {icon}  Display   │{$4}│{#keys}║{$2}",
                  "compactType": "original-with-refresh-rate"
              },
              {
                  "type": "gpu",
                  "key": "║{#green}│ {icon}  G-Driver  │{$4}│{#keys}║{$2}",
                  "format": "{driver}"
              },
              {
                  "type": "custom",
                  "key": "║{#green}└──────────────┴{$1}┘{#keys}║",
                  "format": ""
              },
              {
                  "type": "custom",
                  "key": "║{#yellow}┌──────────────┬{$1}┐{#keys}║\u001b[50D",
                  "format": "{#bright_yellow} Terminal "
              },
              {
                  "type": "shell",
                  "key": "║{#yellow}│ {icon}  Shell     │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "terminal",
                  "key": "║{#yellow}│ {icon}  Terminal  │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "terminalfont",
                  "key": "║{#yellow}│ {icon}  Term Font │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "packages",
                  "key": "║{#yellow}│ {icon}  Packages  │{$4}│{#keys}║{$2}"
              },
              {
                 "type": "custom",
                  "key": "║{#yellow}└──────────────┴{$1}┘{#keys}║",
                  "format": ""
              },
              {
                  "type": "custom",
                  "key": "║{#red}┌──────────────┬{$1}┐{#keys}║\u001b[51D",
                  "format": "{#bright_red} Development "
              },
              {
                  "type": "command",
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  Rust      │{$4}│{#keys}║{$2}",
                  "text": "rustc --version",
                  "format": "rustc {~6,13}"
              },
              {
                  "type": "command",
                  "condition": {
                      "!system": "Windows"
                  },
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  Clang     │{$4}│{#keys}║{$2}",
                  "text": "command -v clang >/dev/null && clang --version | sed -n 's/.*version \\([0-9][0-9.]*\\).*/\\1/p'",
                  "format": "clang {}"
              },
              {
                  "type": "command",
                  "condition": {
                  "system": "Windows"
                  },
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  Clang     │{$4}│{#keys}║{$2}",
                  "text": "clang --version | findstr version",
                  "format": "clang {~-6}"
              },
              {
                  "type": "command",
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  NodeJS    │{$4}│{#keys}║{$2}",
                  "text": "node --version",
                  "format": "node {~1}"
              },
              {
                  "type": "command",
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  Go        │{$4}│{#keys}║{$2}",
                  "text": "command -v go >/dev/null && go version | cut -d' ' -f3",
                  "format": "go {~2}"
              },
              {
                  "type": "command",
                  "keyIcon": "",
                  "key": "║{#red}│ {icon}  Zig       │{$4}│{#keys}║{$2}",
                  "text": "zig version",
                  "format": "zig {}"
              },
              {
                  "type": "editor",
                  "key": "║{#red}│ {icon}  Editor    │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "command",
                  "keyIcon": "󰊢",
                  "key": "║{#red}│ {icon}  Git       │{$4}│{#keys}║{$2}",
                  "text": "git version",
                  "format": "git {~12}"
              },
              {
                  "type": "font",
                  "key": "║{#red}│ {icon}  Interface │{$4}│{#keys}║{$2}"
              },
              {
                  "type": "custom",
                  "key": "║{#red}└──────────────┴{$1}┘{#keys}║",
                  "format": ""
              },
              {
                  "type": "custom",
                  "key": "║{#magenta}┌──────────────┬{$1}┐{#keys}║\u001b[49D",
                  "format": "{#bright_magenta} Uptime "
              },
              {
                  "type": "uptime",
                  "key": "║{#magenta}│ {icon}  Uptime    │{$4}│{#keys}║{$2}"
              },
              {
                  "condition": {
                      "!system": "macOS"
                  },
                  "type": "disk",
                  "keyIcon": "",
                  "key": "║{#magenta}│ {icon}   OS Age    │{$4}│{#keys}║{$2}",
                  "folders": "/",
                  "format": "{create-time:10} [{days} days]"
              },
              {
                  "condition": {
                      "system": "macOS"
                  },
                  "type": "disk",
                  "keyIcon": "",
                  "key": "║{#magenta}│ {icon}  OS Age    │{$4}│{#keys}║{$2}",
                  "folders": "/System/Volumes/VM",
                  "format": "{create-time:10} [{days} days]"
              },
              {
                  "type": "custom",
                  "key": "║{#magenta}└──────────────┴{$1}┘{#keys}║",
                  "format": ""
              },
              {
                  "type": "custom",
                  "key": "╚═════════════════{$5}╝",
                  "format": ""
              },
              "break"
          ]
      }
    '';
  };


  # ------------------------------------------
  # GIT
  # ------------------------------------------

  programs.git = {
    enable = true;

    settings = {
      user.name = "whatyacht";
      user.email = "clockwork78900@gmail.com";
    };
  };
}
