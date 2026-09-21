# Godot XR Development Kit Demo

This is the demo branch of the Godot XR Development Kit plugin that shows you how you can incorporate GXDK into your project.
It is recommended to install the Godot OpenXR Vendor plugin, this is not included by default.

## Cloning this repo

As Godot XR Development Kit is included as a submodule in the addons folder of this demo, you need to recursively clone this repository with the following command:
```
git clone -b demo --recurse-submodules https://github.com/GodotVR/godot-xr-development-kit
```

Alternatively, you can download the demo from the releases page either as a fully running application for various platforms, or download `godot-xr-development-kit-demo.zip` for a fully setup Godot project. 

## Spectator view

This demo includes a spectator view solution.
On PCVR platforms (Windows, Linux, MacOS) Godot can output something separate to the desktop monitor while the wearer of the headset sees the first person stereo output.
This works by loading the `spectator.tscn` scene instead of the default `main.tscn` scene (which is included and rendered to a SubViewport in the spectator system).

> [!NOTE]
> Using a Linux ARM64 build for devices such as the Steam Frame, we also get separate output to the "desktop".
> The spectator system is thus also used here however this output is only shown when the user opens the system menu.
> To prevent overhead, we apply a `minimum_spectator` feature tag that results in a lower resolution output and
> a simplified view.

## Licensing

Code in this repository is licensed under the MIT license.
Images are licensed under CC0 unless otherwise specified.

See `LICENSE` for the full license.
