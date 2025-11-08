#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name:    firefox-esr-installer.sh
# Description:    Installs Firefox stable edition for local user.
# Author:         @tazihad
# Website:        https://zihad.com.bd
# License:        MIT License
# -----------------------------------------------------------------------------

# MIT License
#
# Copyright (c) 2024 @tazihad
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# -----------------------------------------------------------------------------

INSTALLATION_DIRECTORY="$HOME/.var/opt/firefox-esr"
TEMP_DIRECTORY="/tmp/$(date +%s%N)_temp"
DOWNLOAD_URL="https://download.mozilla.org/?product=firefox-esr-latest&os=linux64&lang=en-US"
DESKTOP_FILE="$HOME/.local/share/applications/firefox-esr.desktop"

echo "--> Creating temp folder"
mkdir -p "$TEMP_DIRECTORY"

echo "--> Firefox ESR browser will be installed at $INSTALLATION_DIRECTORY"
mkdir -p "$INSTALLATION_DIRECTORY"

echo "--> Searching and downloading latest ESR Firefox Browser"
curl -L -o "$TEMP_DIRECTORY/firefox-esr.tar.xz" "$DOWNLOAD_URL"

echo "--> Extracting Firefox to $INSTALLATION_DIRECTORY"
tar -xJf "$TEMP_DIRECTORY/firefox-esr.tar.xz" --strip-components=1 -C "$INSTALLATION_DIRECTORY"

cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=Firefox ESR
Comment=Web Browser
Exec=$INSTALLATION_DIRECTORY/firefox %u
Terminal=false
Type=Application
Icon=$INSTALLATION_DIRECTORY/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=firefox-esr
Actions=Private;profile-manager-window;

[Desktop Action Private]
Exec=$INSTALLATION_DIRECTORY/firefox --private-window %u
Name=Open in private mode

[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=$INSTALLATION_DIRECTORY/firefox --ProfileManager
EOL

echo "--> Firefox desktop entry created at $DESKTOP_FILE"

echo "--> Done! Firefox installed at $INSTALLATION_DIRECTORY"











