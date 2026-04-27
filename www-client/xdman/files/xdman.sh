#!/bin/sh

# Check if the script is being run as root
if [ "$(id -u)" -eq 0 ]; then
  echo "It's not recommended to run XDM as root, as it can cause problems"
fi

# Source the configuration file if it exists
if [ -f "$HOME/.xdmanrc" ]; then
  . "$HOME/.xdmanrc"
fi

# Run the Java application
exec java -Dsun.java2d.xrender=false -jar /opt/xdman/xdman.jar "$@"
