{ pkgs, ... }: {
    users.users.ben.home = "/Users/ben";
    system.primaryUser = "ben";

    environment = {
        shells = with pkgs; [ zsh bash ];
        systemPackages = [
            pkgs.coreutils
            pkgs.mkvtoolnix
        ];
        systemPath = [ "/usr/local/bin" ];
        pathsToLink = [ "/Applications" ]; # symlinks /run/current-system/sw
    };

    security.pam.services.sudo_local.touchIdAuth = true;

    # networking.firewall.allowedTCPPorts = [
    #     57621 # allow syncing with local mobile devices
    #     5353  # allow discovery of Spotify Connect (e.g. Google Cast) devices
    # ];

    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.cleanup = "zap";
        # onActivation.upgrade = true;
        # caskArgs.no_quarantine = true;

        casks = [
            "1password"
            "anki"
            "discord"
            "element"
            "firefox"
            "google-chrome"
            "librewolf"
            "obsidian"
            # TODO: "olympus"
            # TODO: "qbittorrent"
            "signal"
            "spotify"
            "steam"
            "tor-browser"
            "vlc"
            # TODO: "WEPA-PrintApp"
            "zoom" # TODO: isolate
            "zotero"
        ];

        masApps = {
            "Brother iPrint&Scan" = 1193539993;
            "Notability: Smarter AI Notes" = 360593530;
            Xcode = 497799835;
        };
    };

    imports = [
    ];

    ##### Technical Details #####
    # Backwards compatibility
    system.stateVersion = 6;
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        # "pipe-operators"
    ];
}
