cd ~/Documents/nixos-config   

git add . 

sudo nix flake update 
sudo nixos-rebuild switch --flake 