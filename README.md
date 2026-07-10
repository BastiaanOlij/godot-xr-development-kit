# Godot XR Development Kit (GXDK)

> [!IMPORTANT]
> This development kit is the spiritual successor to [Godot XR Tools](https://github.com/godotvr/godot-xr-tools).
> It does not have feature parity with XR Tools and likely won't until a few releases have been made.
> It also approaches a number of things structurally different from XR Tools.
>
> It is by no stretch of the imagination production ready, use at your own peril.
> 
> Check the demo branch for a demo showcasing current features.
>
> While under early development this repository is hosted on my personal GitHub space but it will soon move to the GodotVR repository.

This repository contains a number of support files and support scenes that can be used together with the various AR and VR interfaces for the Godot game engine.

![GitHub forks](https://img.shields.io/github/forks/BastiaanOlij/godot-xr-development-kit?style=plastic)
![GitHub Repo stars](https://img.shields.io/github/stars/BastiaanOlij/godot-xr-development-kit?style=plastic)
![GitHub contributors](https://img.shields.io/github/contributors/BastiaanOlij/godot-xr-development-kit?style=plastic)
![GitHub](https://img.shields.io/github/license/BastiaanOlij/godot-xr-development-kit?style=plastic)

## Versions

Official releases are tagged and can be found [here](https://github.com/BastiaanOlij/godot-xr-development-kit/releases).

The following branches are in active development:

|  Branch  |  Description                  |  Godot version  |
|----------|-------------------------------|-----------------|
|  main    | Current development branch    |  Godot 4.6+     |
|  demo    | Demo project for GXDK         |  Godot 4.6+     |

> [!Note]
> This repo is temporarily hosted on https://github.com/BastiaanOlij but will be moved to https://github.com/GodotVR once we're closer to a stable release.

> [!IMPORTANT]
> CI for release builds run through tags on the `demo` branch of this repository.
> CI on the `main` branch purely applies formatting checks.

## How to use

Documentation for this plugin will become available at a later date when the plugin is more complete.
For now check out [the demo branch](https://github.com/BastiaanOlij/godot-xr-development-kit/tree/demo) in this repository.

## Installation

> [!Warning]
> At this point in time there are no stable releases of this plugin yet.
> Some of the information presented below only applies once a stable release is available.

### Godot Asset Store

Stable releases of this plugin can be found in the Godot Asset Store which is accessible from inside of the Godot IDE.
Simply search for `Godot XR Development Kit`, download the plugin and install it.

> [!Note]
> The store page is not live yet!

### GIT

If you use git for source control of your project, you can submodule Godot XR Development Kit. Godot XR Development Kit must be placed in a specific location.
Open a command prompt and in the root of your Godot project execute:

```
mkdir addons
cd addons
git submodule add https://github.com/BastiaanOlij/godot-xr-development-kit
```

If you require a specific version of this plugin, cd into the `godot-xr-development-kit` folder and use `git checkout` to switch to the correct tag or commit.

### Downloading from Github

You can download a stable release from the releases page or use the download option in the `<> Code` dropdown menu on the main Github page.

Manually create the `addons/godot-xr-development-kit` folder in your project and unzip the contents of Godot XR Development Kit into that folder. 

### Enabling the plugin

Note that you can enable this plugin from within the project settings window after installing it.
While care is taken that the functionality within this plugin will work even when not enabled, enabling the plugin will activate various editor features.

## Upgrading to a new version of this plugin

When upgrading this plugin to a newer v2 version, simply replace the contents of the `addons/godot-xr-development-kit` folder with the new version.
If you've submoduled the plugin, simply pull a new version by executing:
```
cd addons/godot-xr-development-kit
git pull origin main
```

> [!NOTE]
> It's best to do this when Godot is NOT running! 

## Demo

This repository contains a demo project that can be found in [the demo branch](https://github.com/BastiaanOlij/godot-xr-development-kit/tree/demo).
A full project can be downloaded from the releases page.

To obtain the latest version we recommend using git from the command line, this will pull in submodules correctly:
```
git clone -b demo --recurse-submodules https://github.com/BastiaanOlij/godot-xr-development-kit
```

## Licensing

Code in this repository is licensed under the MIT license.
Images are licensed under CC0 unless otherwise specified.

See `LICENSE` for the full license.

### Complying with the license

If you use Godot XR Development Kit in your project, this license must be accessible to your end users either by reproducing it in a credits/about screen or included as a distributed file.

## Contributing

We welcome meaningful contributions to this repository but do ask people to consider that we are a small team that may not be able to review your work in a timely manner.

Before contributing it is always appreciated to discuss changes first either by raising an issue or joining the XR channel on Godots official Discord server.

## About this repository

This repository is primarily maintained by:
- [Bastiaan Olij](https://github.com/BastiaanOlij/)
- [Malcolm Nixon](https://github.com/Malcolmnixon/)

For further contributors please see `CONTRIBUTORS.md`

> As a successor to the original Godot XR Tools, all original contributors are credited.
