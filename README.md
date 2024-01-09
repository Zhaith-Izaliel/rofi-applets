<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GNU GPL v3.0][license-shield]][license-url]

[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
<h1 align="center">🍪Rofi Applets, the Nix way.</h3>

  <p align="center">
    A collection of Rofi applets, with their own derivations and modules to be
    used with Home Manager and Nix.
    <br />
    <a href="https://gitlab.com/Zhaith-Izaliel/rofi-applets"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://gitlab.com/Zhaith-Izaliel/rofi-applets">View Demo</a>
    ·
    <a href="https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues">Report Bug</a>
    ·
    <a href="https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>

<!-- vim-markdown-toc GitLab -->

* [About The Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
    * [Nix/NixOS + Home Manager (With Flakes)](#nixnixos-home-manager-with-flakes)
    * [Without Nix](#without-nix)
  * [Installation](#installation)
    * [Nix/NixOS + Home Manager (With Flakes)](#nixnixos-home-manager-with-flakes-1)
      * [Building applets with Rofi for X11, not Wayland](#building-applets-with-rofi-for-x11-not-wayland)
    * [Without Nix](#without-nix-1)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Acknowledgments](#acknowledgments)

<!-- vim-markdown-toc -->

</details>


<!-- ABOUT THE PROJECT -->
## About The Project

[![Rofi Applets Screenshot][product-screenshot]](https://gitlab.com/Zhaith-Izaliel/rofi-applets)

Rofi Applets is a collection of dmenu bash utilities built for Rofi, similar to
[Aditya Shakya's Rofi applets][adi1090x-rofi] but built specifically to work
with Nix and Home Manager while not assuming theming by default.

These applets have high customizations capabilities you can easily set up using
their corresponding Home Manager modules, or just by creating their theme and
updating their `.conf` files. All applets can be tailored to your specific needs.

They, however, do not assume theming by default, **as such, you need to make
your own Rofi theme**. Some example themes are provided in the `example`
directory.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

* [![Nix][Nix]][Nix-url]
* [![Bash][Bash]][Bash-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

There are two ways of installing the applets, either with Home Manager using
flakes, or by installing them yourself, with all their dependencies on a non-Nix
system.

### Prerequisites

#### Nix/NixOS + Home Manager (With Flakes)

To install and use these applets with Nix you will need:

* Nix installed on your system.
* A Home Manager ready configuration built **with flakes**.

#### Without Nix

Without Nix, installing these applets require their individual dependencies. For
every packages you will need at least:

* Rofi 1.7.5+
* Bash 5.2.21+

Dependencies for every applet

* Bluetooth applet:
  * Bluez with access to `bluetoothctl` command
  * GNU Grep
* Favorites applet:
  * All the applications you wish to run with `rofi-favorites` should be in your
  `PATH`
* MPD applet:
  * An MPD server up and running to use
  * MPC to control MPD in command line
  * Dunst for the `dunstify` command to send notifications
* Network-Manager applet:
  * This applet is external to this repository, if you wish to install it, you
  can find instructions [here][rofi-network-manager].
* Power-Profiles applet:
  * Power Profiles Daemon, with access to the `powerprofilesctl` command.
* Quicklinks applet:
  * XDG Utils, with access to the `xdg-open` command.

### Installation

#### Nix/NixOS + Home Manager (With Flakes)

We assume you have a fair bit of knowledge on how flakes with nix works.

1. Add this repository to your flake inputs:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rofi-applets = {
      url = "gitlab:Zhaith-Izaliel/rofi-applets";
      inputs.nixpkgs.follows = "nixpkgs" # Optional
    };
  };
}
```
2. Add the packages overlay to your overlays in your outputs:
```nix
nixpkgs.overlays = [ inputs.rofi-applets.overlays.default ];
```

3. Add the modules to your Home Manager modules list:

```nix
inputs.home-manager.lib.homeManagerConfiguration {
  modules = [
    inputs.rofi-applets.homeManagerModules.${name} # Where name is the name of the applet module you wish to add
    # Alternatively you can import the `default` module which contains every applets
    inputs.rofi-applets.homeManagerModules.default
  ];
}
```
4. Every module provided by the flake are under `programs.rofi.applets.<name>`.
   You can start configuring from there!

##### Building applets with Rofi for X11, not Wayland

By default, the applets are built with the `rofi-wayland` package available in
Nixpkgs. However, it is possible to build with them `rofi` directly, if you
don't need to support Wayland.

To do so, override the packages definition:
```nix
{ pkgs, ... }:

{
  programs.rofi.applets.favorites.package = pkgs.rofi-favorites.override { useWayland = false; };
}
```
Replace `rofi-favorites` and `favorites` by the applet you want to override. You
can also override this package definition in `home.packages` and
`environment.systemPackages` in the same way.

#### Without Nix

1. Install the applets dependencies with your package manager.

2. Copy the applet you wish to install to `/usr/local/bin` and make it
   executable:
```bash
cp <applet-name>/<applet-name>.sh /usr/local/bin/<name>
sudo chmod +x /usr/local/bin/<name>
```
3. Every applet configuration files are put into:
   `$HOME/.config/rofi/<name>.conf` and their theme are in
   `$HOME/.config/rofi/<name>.rasi`. For example `rofi-favorites` configuration
   file and theme are in `$HOME/.config/rofi/rofi-favorites.conf` and
   `$HOME/.config/rofi/rofi-bluetooth.rasi` respectively.


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

~Each applet has its own documentation located in their corresponding directory.
You can find usage information in there!~ The documentations are WIP and will
come ✨soon✨.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

- [ ] Add documentation for every applets
- [ ] Create our own Network-Manager applet following the same pattern of
configuration and theming options.

See the [open issues](https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

**Contributions are only available on GitLab.**

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project **on GitLab**
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`), your
   commit message should follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specifications
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the GNU General Public License v3.0. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Best-README-Template](https://github.com/othneildrew/Best-README-Template) for their amazing README template
* [adi1090x/rofi][adi1090x-rofi] for their collection of Rofi applets that I took inspiration on. Without it, this project wouldn't be the same.
* [Rofi-Bluetooth](https://github.com/nickclyde/rofi-bluetooth) for the fork of rofi-bluetooth I re-adapted for the purpose of making a module for home-manager
* [Home Manager](https://github.com/nix-community/home-manager), without it, it wouldn't work.
* [Rofi-NetWork-Manager][rofi-network-manager], for the network manager applet used directly in the flake.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/gitlab/contributors/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[contributors-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/graphs/master?ref_type=heads

[forks-shield]: https://img.shields.io/gitlab/forks/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[forks-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/forks

[stars-shield]: https://img.shields.io/gitlab/stars/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[stars-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/starrers

[issues-shield]: https://img.shields.io/gitlab/issues/open/Zhaith-Izaliel%2Frofi-applets?style=for-the-badge

[issues-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues

[license-shield]: https://img.shields.io/gitlab/license/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[license-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/blob/master/LICENSE?ref_type=heads

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/virgil-ribeyre-810135196/

[product-screenshot]: images/screenshot.png
[Nix]: https://img.shields.io/badge/nix-bedbf1?style=for-the-badge&logo=nixos
[Nix-url]: https://nixos.org/
[Bash]: https://img.shields.io/badge/Bash-000000?style=for-the-badge&logo=gnubash&logoColor=FFFFFF
[Bash-url]: https://www.gnu.org/software/bash/
[adi1090x-rofi]: https://github.com/adi1090x/rofi/tree/master
[rofi-network-manager]: https://github.com/P3rf/rofi-network-manager

