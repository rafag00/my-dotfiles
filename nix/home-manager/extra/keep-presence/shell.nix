# Run the nix-shell to set up the environment for keep-presence
# Then execure with `nix-shell --run "keep-presence -s time"`

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    packages = with pkgs; [
    python312Full
    linuxHeaders
  ];

  C_INCLUDE_PATH = "${pkgs.linuxHeaders}/include";

  shellHook = ''
    export VENV_DIR=$HOME/.local/share/python-envs/keep-presence
    if [ ! -d "$VENV_DIR" ]; then
      python -m venv "$VENV_DIR"
      source "$VENV_DIR/bin/activate"
      pip install keep_presence
    else
      source "$VENV_DIR/bin/activate"
    fi
  '';

  #nix-shell --run "command argument1 argument2 ..."
}
