function main()
{
  # brew install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle
  # nvim install
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  # nix install
  sh <(curl -L https://nixos.org/nix/install)
  # nix channels
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-shell '<home-manager>' -A install
}

main "$@"
