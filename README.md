# nixos

## Example Configuration

```bash
/etc/nixos/
├── configuration.nix -> /home/kraust/git/nixos/configuration.nix
├── desktop.nix -> /home/kraust/git/nixos/hyprland.nix
├── hardware-configuration.nix
├── local-configuration.nix -> /home/kraust/git/nixos/tiny-stars.nix
└── nvidia.nix -> /home/kraust/git/nixos/nvidia.nix
```

```bash
git clone git@github.com:Kraust/nixos.git
sudo ln -sf ~/git/nixos/configuration.nix /etc/nixos/
sudo ln -sf ~/git/nixos/machines/tiny-stars.nix /etc/nixos/local-configuration.nix
sudo ln -sf ~/git/nixos/desktop/hyprland.nix /etc/nixos/desktop.nix
sudo ln -sf ~/git/nixos/software/nvidia.nix /etc/nixos/nvidia.nix
```

# Trigger Upgrades
```bash
sudo ~/git/nixos/update.sh
```
