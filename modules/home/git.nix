{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Szymon Groszkowski";
          email = "szymongr14@gmail.com";
        };

        init.defaultBranch = "main";
        push.autoSetupRemote = true;

        core.editor = "nvim";

        alias = {
          dog = "log --all --decorate --oneline --graph";
          sta = "status";
          st = "status -s";
          cane = "commit --amend --no-edit";
          cm = "commit -m";
          rc = "rebase --continue";
          pr = "pull --rebase";
          ri = "rebase -i";
          sw = "switch";
          blog = "log --oneline origin/master..HEAD";
        };
      };

      ignores = [
        ".DS_Store"
        ".envrc"
      ];
    };
  };
}
