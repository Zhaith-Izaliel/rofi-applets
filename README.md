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
  <a href="https://gitlab.com/Zhaith-Izaliel/rofi-applets">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Rofi Applets, the Nix way.</h3>

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
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `github_username`, `repo_name`, `twitter_handle`, `linkedin_username`, `email_client`, `email`, `project_title`, `project_description`

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Nix][Nix]][Nix-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

#### Nix/NixOS + Home Manager (With Flakes)

To install and use these applets you will need:

* Nix installed on your system.
* A Home Manager ready configuration built **with flakes**.

#### Without Nix


### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/Zhaith-Izaliel/rofi-applets.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

**Contributions are only available on Gitlab.**

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the GNU General Public License v3.0. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://gitlab.com/Zhaith-Izaliel/rofi-applets](https://gitlab.com/Zhaith-Izaliel/rofi-applets)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Best-README-Template](https://github.com/othneildrew/Best-README-Template) for their amazing README template
* [adi1090x/rofi](https://github.com/adi1090x/rofi/tree/master) for their collection of Rofi applets that I took inspiration on. Without it, this project wouldn't be the same.
* [Rofi-Bluetooth](https://github.com/nickclyde/rofi-bluetooth) for the fork of rofi-bluetooth I readapted for the purpose of making a module for home-manager
* [Home Manager](https://github.com/nix-community/home-manager), without it, it wouldn't work.
* [Rofi-NetWork-Manager](https://github.com/P3rf/rofi-network-manager), for the network manager applet used directly in the flake.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/gitlab/contributors/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[contributors-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/graphs/master?ref_type=heads

[forks-shield]: https://img.shields.io/gitlab/forks/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[forks-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/forks

[stars-shield]: https://img.shields.io/github/stars/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[stars-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/starrers

[issues-shield]: https://img.shields.io/github/issues/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[issues-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/issues

[license-shield]: https://img.shields.io/github/license/Zhaith-Izaliel/rofi-applets.svg?style=for-the-badge&logo=gitlab
[license-url]: https://gitlab.com/Zhaith-Izaliel/rofi-applets/-/blob/master/LICENSE.md?ref_type=heads

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username

[product-screenshot]: images/screenshot.png
[Nix]: https://img.shields.io/badge/nix-000000?style=for-the-badge&logo=nixos&logoColor=white
[Nix-url]: https://nixos.org/

