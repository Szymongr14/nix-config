{
  flake.modules.darwin.remote-linux-builder = {
    environment.etc."ssh/ssh_config.d/110-datsu-linux-builder.conf".text = ''
      Host datsu-linux-builder
        HostName szymons-mac-mini.deer-bangus.ts.net
        Port 31022
        User builder
        IdentityFile /Users/szymongrrr/.ssh/id_ed25519
        IdentitiesOnly yes
        HostKeyAlias linux-builder
        StrictHostKeyChecking yes
    '';

    nix = {
      distributedBuilds = true;

      buildMachines = [
        {
          hostName = "szymons-mac-mini.deer-bangus.ts.net";
          protocol = "ssh-ng";
          sshUser = "szymongrrr";
          sshKey = "/Users/szymongrrr/.ssh/id_ed25519";
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUdKelJ2cVVqN1czcUdaM0VWWURHZ2VGU3dQM1lZK0ZVUDZZMTExUldqdXkK";
          systems = ["aarch64-darwin"];
          maxJobs = 2;
          speedFactor = 2;
          supportedFeatures = [
            "apple-virt"
            "benchmark"
            "big-parallel"
            "nixos-test"
          ];
        }
        {
          hostName = "szymons-mac-mini.deer-bangus.ts.net:31022";
          protocol = "ssh-ng";
          sshUser = "builder";
          sshKey = "/Users/szymongrrr/.ssh/id_ed25519";
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=";
          systems = ["aarch64-linux"];
          maxJobs = 2;
          speedFactor = 2;
          supportedFeatures = [
            "kvm"
            "benchmark"
            "big-parallel"
            "nixos-test"
            "uid-range"
          ];
        }
      ];

      settings.builders-use-substitutes = true;
    };
  };
}
