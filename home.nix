
{ pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
    inputs.spicetify-nix.homeManagerModules.default
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
  # SPICETIFY
  # ------------------------------------------

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];

    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };


  # ------------------------------------------
  # DISCORD / NIXCORD
  # ------------------------------------------

  programs.nixcord = {
    enable = true;
    vesktop.enable = false;

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
        readAllNotificationsButton.enable = true;
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
