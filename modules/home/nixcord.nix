{ inputs, ... }:

{
  flake.modules.generic.home-nixcord = {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

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
  };
}
