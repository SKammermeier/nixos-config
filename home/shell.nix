{lib, ...}: {
  allowUnfreePkg = [
    "zsh-abbr"
  ];
  #   nixpkgs.config.allowUnfree =  builtins.warn "Checking " true;
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Simon Kammermeier";
          email = "simon.kammermeier@tum.de";
        };
      };
      lfs.enable = true;
    };

    zsh = {
      enable = true;
      zsh-abbr = {
        enable = true;
        abbreviations = {
          ll = "ls -l";
          la = "ls -la";
        };
        globalAbbreviations = {
          G = "| grep";
          L = "| less -R";
        };
      };
      enableVteIntegration = true;
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
        ignoreDups = true;
        save = 500000;
        size = 500000;
      };
      syntaxHighlighting.enable = true;
      #TODO
      initContent = lib.mkMerge [
        (lib.mkOrder 550 ''
          zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _correct _approximate
          zstyle ':completion:*' completions 1
          zstyle ':completion:*' expand prefix suffix
          zstyle ':completion:*' glob 1
          zstyle ':completion:*' group-name '''
          zstyle ':completion:*' ignore-parents parent pwd
          zstyle ':completion:*' insert-unambiguous false
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
          zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
          zstyle ':completion:*' list-suffixes true
          zstyle ':completion:*' matcher-list ''' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
          zstyle ':completion:*' max-errors 2
          zstyle ':completion:*' menu select=1
          zstyle ':completion:*' old-menu false
          zstyle ':completion:*' original false
          zstyle ':completion:*' preserve-prefix '//[^/]##/'
          zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
          zstyle ':completion:*' substitute 1
          zstyle ':completion:*' use-compctl true
          zstyle ':completion:*' verbose true
          zstyle ':completion:*' word true
        '')
        ''
          _tmux_refresh_agent() {
            [[ -n $TMUX ]] && eval "$(tmux show-environment -s SSH_AUTH_SOCK 2>/dev/null)"
          }
          autoload -Uz add-zsh-hook
          add-zsh-hook precmd _tmux_refresh_agent
        ''
      ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    tmux = {
      enable = true;
      historyLimit = 500000;
      mouse = true;
      newSession = true;
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
