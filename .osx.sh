defaults write com.apple.sound.beep.sound -string "/System/Library/Sounds/Funk.aiff"

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 45 pixels
defaults write com.apple.dock tilesize -int 51

defaults write com.apple.dock largesize -int 86

defaults write com.apple.dock magnification -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Only use UTF-8 in Terminal.app
#defaults write com.apple.terminal StringEncodings -array 4

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

defaults write com.apple.finder NewWindowTarget -string "PfHm"

defaults write com.apple.finder NewWindowTargetPath -string "file://~"

defaults write com.apple.screensaver askForPasswordDelay -int 0

defaults write com.apple.menuextra.battery ShowPercent -string "YES"

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Enable ssh for admin (doesn't work)
# systemsetup -setremotelogin on
# dseditgroup -o create -q com.apple.access_ssh
# dseditgroup -o edit -a admin -t group com.apple.access_ssh

# add a crontab to always had my ip address available
crontab cron.txt

# Use a modified version of the Solarized Dark theme by default in Terminal.app (Need to be checked)
osascript <<EOD
tell application "Terminal"
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Solarized Dark xterm-256color"
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window
	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open './" & themeName & ".terminal'"
	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName
	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window
	repeat with windowID in allOpenedWindows
		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)
		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if
	end repeat
end tell
EOD
