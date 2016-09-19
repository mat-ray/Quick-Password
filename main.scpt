-- Script relies on installing Mac Homebrew, and sf-pwgen
-- https://bitbucket.org/anders/sf-pwgen
-- Get them first, else the script will NOT work!
-- Also, check where Brew installs sf-pwgen*, and update the variable 'brewPath' below accordingly
-- * do this by opening terminal and typing "brew list sf-pwgen"
-- One suggestion: take this script and save it as an app.  Then create an Automator SERVICE Workflow which takes no input and save it with a "friendly" name. Restrict to Safari or Chrome if you like.  Then go into System Prefs--Keyboard--Shortcuts and create a keyboard shortcut to invoke the app (take care to use the exact text that appears in the service menu) via the service and voila! You can trigger a password anytime you need from the keyboard!
-- WARNING: It should be fine, but I offer no warranties on the use of this script.  Use at your own risk, entirely.  Don't use it for highly sensitive passwords, just to be safe! 

tell application "Safari"
	
	-- Added section to randomly pick a dictionary language for the memorable words from those supported
	set brewPath to "/usr/local/Cellar/sf-pwgen/1.3/bin/"
	set languages to {"en", "de", "es", "fr", "it", "nl", "pt", "jp"}
	set numberOfLanguages to count of languages
	set chosenLanguage to item (random number from 1 to numberOfLanguages) of languages
	set myPassword to {do shell script brewPath & "sf-pwgen -c1 -l20 -L " & chosenLanguage} as text
	
	-- You can skip this block if you like.  It simply forces the first character of the passwords suggested to be uppercase.  SO many websites insist on at least one character always being upper case. Sigh...
	set UpperFirstCharString to do shell script "echo " & character 1 of myPassword & " | tr [:lower:] [:upper:]"
	set myPassword to UpperFirstCharString & characters 2 through -1 of myPassword as text
	-- Put password onto clipboard ready for user
	set the clipboard to myPassword
	tell application "System Events" to keystroke "v" using command down
	
end tell
