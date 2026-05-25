{
  flake.modules.darwin.base = { config, ... }: {
    system.stateVersion = config.host.state.darwin;
  };
}
