{
  # NOTE: This is an OPT-IN module, not part of `base`.
  # A host has to add `linux-builder` to its modules list to enable it.
  flake.modules.darwin.linux-builder = {
    nix.linux-builder = {
      enable = true;
      ephemeral = true;

      # Decrease maxJobs. This is how many DIFFERENT packages build at the same time.
      # For massive tasks like kernels, building 1 or 2 things at once is faster
      # because it prevents the VM from running out of RAM and swapping.
      maxJobs = 2;

      supportedFeatures = [ "kvm" "benchmark" "big-parallel" ];

      config = {
        virtualisation = {
          darwin-builder = {
            diskSize = 40 * 1024;
            # Bump from 8GB to 10GB.
            # (Don't go higher than 10-11GB on a 16GB Mac, or macOS will start
            # heavily swapping, which slows down the VM).
            memorySize = 10 * 1024;
          };
          # Assuming M4 has 8 to 10 cores. Give 8 cores to the VM.
          cores = 8;
        };

        # CRITICAL: Tell the Nix daemon INSIDE the Linux VM to use all available
        # virtual cores for a single build. This turns `make` into `make -j8`.
        nix.settings.cores = 0;
      };
    };
  };
}
