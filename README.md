
# Nanocodebug's Pop!_OS setup notes
- specifically for the Framework laptop, but these steps should apply to other Ubuntu based (and maybe Debian) distributions.
- tested on the 22.04 LTS Pop!_OS release with a 12th gen 1260p Framework.

# Power Management

## vaapi GPU rendering with Firefox

```bash
sudo apt install intel-media-va-driver intel-gpu-tools
```

In firefox about:config set the following to **true**

```
media.rdd-ffmpeg.enabled
media.ffmpeg.vaapi.enabled
media.navigator.mediadatadecoder_vpx_enabled
```

Validate by playing a 4k video and seeing that the video decode function is being used in `sudo intel_top_gpu`

## vaapi GPU renderng with Chrome
not working afaik D:

## Powertop 
    sudo apt install powertop
    sudo systemctl enable powertop

Status of power saving functions visable in `sudo powertop`

## Hibernate
**[untested]** Not supported by default for pop os, but guide exists.
https://support.system76.com/articles/enable-hibernation/

## Suspend
Deep sleep (`s2idle[deep]`) is working in pop!_os. 

Using only usb-c cards I've recorded a suspend power draw of 0.8 watts.

### Disk
- pop!_os appears to enable `noatime` on disks by default

- `sudo kernelstub -a "nvme.noacpi=1"` can be used to prevent the NVME_QUIRK_SIMPLE_SUSPEND flag from being set. The quirk exists to cause the kernel to do pci link power management of the nvme device in some circumstances instead of allowing the nvme device to got into sleep states by itself. My testing with a SN850 showed no change in suspend power consumption. 

- TODO: ssd firmware update

### USB
- TODO make sure webcam power saving is properly enabling on toggling it with hardware switch
- TODO hdmi card has power suspend feature?
- TODO displayport card has a power suspend firmware update?

# TLP
## DO NOT USE WITH SYSTEM76-POWER ENABLED
TLP conflicts with the installed by default system76-power.
In theory TLP provides more customization since system76-power is tailored towards system76 laptops. system76-power seems to do a fine job by itself though.

- TODO: make a good tlp config, leverage usb suspend functions for the hdmi, displayport, and usb-a cards.

# Audio

## EasyEffects
```
flatpak install com.github.wwmm.easyeffects
```
Default speaker and mic profiles are included in the easyeffects folder. 

Speaker profile from here: 

If you copy the entire config folder, it will should cuase the configs to only enable for the internal speakers and microphone, loading a empty profile for other audio or devices or headphones. 

place the `easyeffects` folder in 

`~/.var/app/com.github.wwmm.easyeffects/config/`

Make sure to enable easyeffects on system startup in its preferences. 

## Analog Audio Jack
NOTE: The alsa mixer fix for the audio jack microphone is **not** needed on 12th gen Framework with pop!_os 22.04. The headphone and mic jack works correctly without configuration on my device. 

    echo "options snd-hda-intel model=dell-headset-multi" | sudo tee -a /etc/modprobe.d/alsa-base.conf

# Display Settings
## Settings
- use 100% scaling to avoid screen tearing in X11
- disable hidpi service
- set font to large
- set mouse to medium

# Fix Backlight Brightness Keyboard Shortcuts
some sort of conflict in the bindings, fix by disabling this kernel module. 

```
sudo kernelstub -a "module_blacklist=hid_sensor_hub"
```

# Personal Preferences
## Firefox

enable *real* smooth scrolling!
```
echo export MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/firefox_xinput2.sh
```
personal scrolling perferences, will conflict with external click wheel mice 

```
about:config
general.autoScroll true
general.smoothScroll false
mousewheel.default.delta_multiplier_y 40 
```

## Gnome Shell Extensions
[Gnome Shell Extension Installer for Firefox](https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/)

Extensions:
- [Vitals](https://extensions.gnome.org/extension/1460/vitals/) - cpu, temperature, etc.
- [Sound Input & Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/) - easy switching from top bar dropdown
- [Impatience](https://extensions.gnome.org/extension/277/impatience/) - the animations are toooo slow, make them faster 

## DisplayCal Notes
- https://github.com/eoyilmaz/displaycal-py3
- install argyliccm linux binaries
- set color temp to 6500k
- set backlight to wled rgb

My color calibration is included here. Generally the framework displays seem to tint redish green according to the color correction. 

## Posy Cursor
i think this is neat

[Original Posy Cursor](http://www.michieldb.nl/other/cursors/)

[Posy Cursor Linux](https://github.com/simtrami/posy-improved-cursor-linux)

## dock.sh
personal script for enabling or disabling text scaling when using an external monitor, also does scroll wheel and wifi device management for my dock.