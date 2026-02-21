# Nix-based Dotfiles

This is my managing of dotfiles and other configurations based with Nix.

To update things, use the following from this `/etc/nix-darwin` directory:

```bash
darwin-rebuild build --flake .#Borealis
```

## Structure

While not currently needed, the structure is set up to allow better modularity
in the future (largely bc that's what most people seem to do and it makes sense).
Basically everything lives under `modules`, except the flake. The flake basically
connects machines/systems/hosts to their appropriate configurations. I'm not
100% how this works but I'm pretty sure its based off checking the current hostname
and using the respective configuration in `flake.nix`. For example, on my MacBook
Borealis, it will select `darwinConfigurations."Borealis"`.

`hosts` manages... hosts. Devices in the network. In principle, this could be your
stuff on a big server like with DigitalOcean Droplets, a virtual machine, or, more
practically probably, your laptop. My MacBook is called "Borealis" so we have
`hosts/Borealis`. Now, these manage more system-wide settings. Things like printers,
(internet) networking, etc. If you think "this feels very operating system-y" then
it probably belongs here.

## On Applications

I think this is what's going on with Applications: First, Nix-Darwin sets up the
system. Among this is creating (empty) things (files or directories) in
`/run/current-system/sw -> /nix/store/[hash]-system-path` (creates in `...system-path`
and links `...sw -> ...sysem-path`) based on `environment.pathsToLink`. Now then,
Home-Manager downloads the file in the nix store (with the crazy hash
`nix/store/[hash]-home-manager-path/...`; see `home.packages`). Home-Manager then
links the `/run/current-system/sw/...` file structure (the `...`) to
`/nix/store/[hash]-user-environment/... <- /etc/static/profiles/per-user/$USER
<- /etc/profiles/per-user/$USER`. Finally, things get linked appropriately in
`/Users/$USER`. Importantly for us here, we get
`/Users/$USER/Applications/Home\ Manager\ Apps` (which are actually directly
linked to the original files in the nix store).

NOTE: Stylix doesn't style Homebrew apps :(

## TODO

- make the update thing more in line with nix
- find a way to nicely "subclass" home-manager from darwin.
  - updating darwin stuff should update home-manager but should be able to update
  home-manager without dealing with darwin
  - I don't think this is really possible. Switching darwin needs sudo but that
  is exactly what I want to not have to do. I think I need to fully separate out
  home manager a la [Reckenrode](https://github.com/reckenrode/nixos-configs/blob/main/flake.nix)
- appropriate modules across hosts and user profiles
