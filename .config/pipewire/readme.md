# Pipewire noise canceling source from copr

- link : <https://hackernoon.com/enabling-instant-noise-cancellation-on-linux>
- link copr : <https://copr.fedorainfracloud.org/coprs/uriesk/noise-suppression-for-voice>
- link copr new 2026 : <https://copr.fedorainfracloud.org/coprs/lkiesow/noise-suppression-for-voice> 
<!--
```bash
sudo dnf install ladspa-noise-suppression-for-voice
```-->

## enable copr

```bash
sudo dnf copr enable lkiesow/noise-suppression-for-voice
```

### install

```bash
sudo dnf install noise-suppression-for-voice
```

## config pipewire

```bash
mkdir ~/.config/pipewire/pipewire.conf.d
```

creating file name 99-input-denoising.conf

### config

```conf
context.modules = [
{
    name = libpipewire-module-filter-chain
    args = {
        node.description = "Noise Canceling source"
        media.name = "Noise Canceling source"

        filter.graph = {
            nodes = [
                {
                    type = ladspa
                    name = rnnoise
                    plugin = /usr/lib64/ladspa/librnnoise_ladspa.so
                    label = noise_suppressor_mono
                    control = {
                        "VAD Threshold (%)" = 60.0
                    }
                }
            ]
        }

        capture.props = {
            node.name = "capture.rnnoise_source"
            node.passive = false
        }

        playback.props = {
            node.name = "rnnoise_source"
            media.class = Audio/Source
        }
    }
}
]
```

<!--```conf
context.modules = [
{   name = libpipewire-module-filter-chain
    args = {
        node.description =  "Noise Canceling source"
        media.name =  "Noise Canceling source"
        filter.graph = {
            nodes = [
                {
                    type = ladspa
                    name = rnnoise
                    plugin = /usr/lib64/ladspa/librnnoise_ladspa.so
                    label = noise_suppressor_mono
                    control = {
                        "VAD Threshold (%)" = 60.0
                        "VAD Grace Period (ms)" = 200
                        "Retroactive VAD Grace (ms)" = 0
                    }
                }
            ]
        }
        capture.props = {
            node.name =  "capture.rnnoise_source"
            node.passive = true
            audio.rate = 48000
        }
        playback.props = {
            node.name =  "rnnoise_source"
            media.class = Audio/Source
            audio.rate = 48000
        }
    }
}
]

```-->

### restarting pipewire
```bash
systemctl --user restart pipewire pipewire-pulse
```
