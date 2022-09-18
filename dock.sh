#/bin/sh

if [ "$1" == "enable" ]; then
	echo "Enabling dock mode"

	echo "Starting imwheel scroll wheel multiplier..."
	# g502 default scroll distance is somehow tiny 
	killall imwheel
	imwheel

	echo "Setting font to small..."
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.0

	echo "Setting cursor to medium..."
	gsettings set org.gnome.desktop.interface cursor-size 32

	# echo "Disabling internal wifi..."
	# i have a external wifi antenna for the office because the router is WEAK
	# this is a lie the walls are just too thick
	# sudo ifconfig wlp166s0 down

	echo "Done."
elif [ "$1" == "disable" ]; then
	echo "Disabling dock mode"

	echo "Killing imwheel scroll wheel multiplier..."
	# internal touchpad is affected by this, make sure to kill it
	killall imwheel

	echo "Setting font to large"
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.25

	echo "Setting cursor to large"
	gsettings set org.gnome.desktop.interface cursor-size 48

	# echo "Enabling internal wifi..."
	# bring back the internal wifi since its the only wifi device now
	# sudo ifconfig wlp166s0 up

	echo "Done."
else
	echo "Usage: dock.sh enable|disable"
fi
