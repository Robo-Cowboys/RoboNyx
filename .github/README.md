<h1 align="center">
      <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg" width="96px" height="96px" />
      <br>

dotfiles <br>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px" /> <br>

</h1>

<br>

<p align="center">
<img src="https://media.discordapp.net/attachments/1020403449092911186/1024341925630844939/unknown.png?width=1122&height=631" width="600" alt="" />
</p>

## 📦 Contents

- [modules](modules) 🍱 modularized NixOS configs
  - [home](modules/home) 🏠 my [Home-Manager](https://github.com/nix-community/home-manager) config
  - [core](modules/core) 🧠 Core NixOS configuration
  - [server](modules/server) ☁️ Server stuff for selfhosting on pi4
  - [wayland](modules/wayland) 🚀 Wayland configs and rice
- [hosts](hosts) 🌳 per-host configuration (All named after saturn moons 🪐)
  - [jupiter](hosts/anthe) 💻 Main Machine with AMD gpu
  - [saturn](hosts/iapetus) 🍓 Media server [🚧]
  - [mercury](hosts/io) 💻 pihole [🚧]
- [pkgs](pkgs) 💿 exported packages

Commands to remember:

- sudo nixos-rebuild switch --flake /home/sincore/nyx#jupiter

## 📦 Useful Commands

- View all available nixosConfigurations `nix flake show`
