#!/usr/bin/osascript

tell application "Finder"
  set desktopSize to bounds of window of desktop
end tell

tell application "QuickTime Player"
  reopen
  activate
  set MindBlow to (POSIX path of (container of (path to me) as alias)) & "mindBlow.mp4"
  set bounds of window 1 to desktopSize
  play the front document
  set the looping of MindBlow to true
end tell
