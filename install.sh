#!/bin/sh
#
# This script is based on an original implementation from the Deno authors,
# licensed under the MIT license. The original script can be found here:
# https://github.com/denoland/deno_install/blob/master/install.sh

set -e

if ! command -v unzip >/dev/null; then
    echo "Error: unzip is required to install Elementary." 1>&2
    exit 1
fi

TARGET="linux-x86_64"
ELEM_INSTALL_DIR="${ELEM_INSTALL:-$HOME/.elementary}"
ELEM_VERSION="${ELEM_VERSION:-latest}"
ELEM_BIN_DIR="$ELEM_INSTALL_DIR/bin"

if [ "$OS" = "Windows_NT" ]; then
    TARGET="windows-x86_64"
else
    case $(uname -sm) in
        "Darwin x86_64")
            TARGET="macos-x86_64" ;;
        "Darwin arm64")
            # TODO: Need to double check arm64, but I think this works
            TARGET="macos-x86_64" ;;
    esac
fi

ELEM_DOWNLOAD_URI="https://github.com/nick-thompson/elementary/releases/latest/download/elementarycli-${TARGET}.zip"

if [ "$ELEM_VERSION" != "latest" ]; then
    ELEM_DOWNLOAD_URI="https://github.com/nick-thompson/elementary/releases/download/${ELEM_VERSION}/elementarycli-${TARGET}.zip"
fi

if [ ! -d "$ELEM_BIN_DIR" ]; then
    mkdir -p "$ELEM_BIN_DIR"
fi

if [ ! -d "$ELEM_INSTALL_DIR/$ELEM_VERSION" ]; then
    mkdir -p "$ELEM_INSTALL_DIR/$ELEM_VERSION"
fi

echo "Downloading $ELEM_VERSION..."
curl --fail --location --progress-bar --output "$ELEM_INSTALL_DIR/elem.zip" "$ELEM_DOWNLOAD_URI"
echo "Extracting..."
unzip -q -d "$ELEM_INSTALL_DIR/$ELEM_VERSION" -o "$ELEM_INSTALL_DIR/elem.zip"

if [ "$TARGET" = "linux-x86_64" ]; then
    chmod +x $ELEM_INSTALL_DIR/$ELEM_VERSION/elementary-*-Linux-x86_64
    ln -fs $ELEM_INSTALL_DIR/$ELEM_VERSION/elementary-*-Linux-x86_64 "$ELEM_BIN_DIR/elementary"
fi

if [ "$TARGET" = "macos-x86_64" ]; then
    chmod +x $ELEM_INSTALL_DIR/$ELEM_VERSION/elementary-*-Darwin-x86_64.app/Contents/MacOS/elementary-*-Darwin-x86_64
    ln -fs $ELEM_INSTALL_DIR/$ELEM_VERSION/elementary-*-Darwin-x86_64.app/Contents/MacOS/elementary-*-Darwin-x86_64 "$ELEM_BIN_DIR/elementary"
fi

rm "$ELEM_INSTALL_DIR/elem.zip"

echo "Elementary $ELEM_VERSION was installed successfully to $ELEM_INSTALL_DIR"

if command -v elementary >/dev/null; then
    echo "Run 'elementary --help' to get started"
else
    case $SHELL in
        /bin/zsh) SHELL_PROFILE=".zshrc" ;;
        *) SHELL_PROFILE=".bash_profile" ;;
    esac

    echo "Manually add the directory to your \$HOME/$SHELL_PROFILE (or similar)"
    echo "  export ELEM_INSTALL=\"$ELEM_INSTALL\""
    echo "  export PATH=\"\$ELEM_INSTALL/bin:\$PATH\""
    echo "Then Run 'elementary --help' to get started (you may need to restart your shell session to reload your profile configuration"
fi
