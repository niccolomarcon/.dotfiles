#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Removing Chromes's apps
rm -rf ~/Applications/Chrome\ Canary\ Apps.localized
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ apdfllckaahabafndbhieahigkjlhalf.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ coobgpohoikkiipiblmjeljniedjpjpf.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ fahmaaghhglfmonjliepjlchgpgfmobi.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Default\ pjkljhegncpnkpknbcohdijeoejaedia.app/
rm -rf ~/Applications/Chrome\ Apps.localized/Icon^M
rm -rf ~/Applications/Chrome\ Apps.localized/app_list.app/
