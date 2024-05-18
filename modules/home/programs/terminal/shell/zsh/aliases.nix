{
  pkgs,
  config,
  ...
}: let
  p = pkgs.writeShellScript "p" ''
    local sail_cmd="php"
    local test_cmd="phpunit"

    if [ -f vendor/bin/sail ]; then
      sail_cmd="./vendor/bin/sail php"
    fi

    if [ -f vendor/bin/pest ]; then
      test_cmd="pest"
    fi

    eval "$sail_cmd ./vendor/bin/$test_cmd"
  '';

  pf = pkgs.writeShellScript "pf" ''
    local sail_cmd="php"
    local test_cmd="phpunit"

    if [ -f vendor/bin/sail ]; then
      sail_cmd="./vendor/bin/sail php"
    fi

    if [ -f vendor/bin/pest ]; then
      test_cmd="pest"
    fi

    eval "$sail_cmd ./vendor/bin/$test_cmd --filter \"$@\""
  '';

  sup = pkgs.writeShellScript "sup" ''
    if [ -f vendor/bin/sail ]; then
      ./vendor/bin/sail up -d
    else
      docker-compose up -d
    fi
  '';

  sdo = pkgs.writeShellScript "sdo" ''
    if [ -f vendor/bin/sail ]; then
      ./vendor/bin/sail down
    else
      docker-compose down
    fi
  '';
in {
  config = {
    programs.zsh.shellAliases = {
      # make sudo use aliases
      sudo = "sudo ";

      # nix specific aliases
      cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      repair = "nix-store --verify --check-contents --repair";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      build = "nix build $@ --builders \"\"";

      # Laravel / Docker Specific
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      sup = "${sup}";
      sdo = "${sdo}";
      p = "${p}";
      pf = "${pf}";
      a = "sail artisan";
      nrd = "sail npm run dev";

      # Nixos
      ns = "nix-shell --run zsh";
      nix-shell = "nix-shell --run zsh";
      #      nix-switch = "sudo nixos-rebuild switch --flake ~/nyx#${host}";
      #      nix-switchu = "sudo nixos-rebuild switch --upgrade --flake ~/nyx#${host}";
      nix-flake-update = "sudo nix flake update ~/nyx#";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      # nix-clean = "sudo nix-collect-garbage -d";
      # nix-cleanold = "sudo nix-collect-garbage --delete-old";
      # nix-cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";

      # quality of life aliases
      #    cat = "${getExe bat} --style=plain";
      #    grep = "${getExe ripgrep}";
      #    du = "${getExe du-dust}";
      #    ps = "${getExe procs}";
      #    mp = "mkdir -p";
      #    fcd = "cd $(find -type d | fzf)";
      #    ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      #    l = "ls -lF --time-style=long-iso --icons";
      #    ytmp3 = ''
      #      ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
      #    '';

      #    # system aliases
      #    sc = "sudo systemctl";
      #    jc = "sudo journalctl";
      #    scu = "systemctl --user ";
      #    jcu = "journalctl --user";
      #    la = "${getExe eza} -lah --tree";
      #    tree = "${getExe eza} --tree --icons=always";
      #    http = "${getExe python3} -m http.server";
      #    burn = "pkill -9";
      #    diff = "diff --color=auto";
      #    killall = "pkill";
      #    switch-yubikey = "gpg-connect-agent \"scd serialno\" \"learn --force\" /bye";

      # faster navigation
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };
  };
}
