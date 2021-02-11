#!/bin/sh

program() {
	echo 'Enter the name you want the application to have in the application list.'
	echo 'Program file and icon file must have the same name as the entered one.'
	read app_name

	#copy program and icon files to the /usr/bin directory
	mkdir /usr/bin/$app_name
	cp $app_name.png /usr/bin/$app_name/$app_name.png
	cp $app_name.AppImage /usr/bin/$app_name/$app_name.AppImage
	chmod +x /usr/bin/$app_name/$app_name.AppImage

	#create desktop entry in /usr/share/applications
	touch /usr/share/applications/$app_name.desktop

	echo "[Desktop Entry]" >> /usr/share/applications/$app_name.desktop
	echo "Encoding=UTF-8" >> /usr/share/applications/$app_name.desktop
	echo "Version=1.0" >> /usr/share/applications/$app_name.desktop
	echo "Type=Application" >> /usr/share/applications/$app_name.desktop
	echo "Terminal=false" >> /usr/share/applications/$app_name.desktop
	echo "Exec=/usr/bin/$app_name/$app_name.AppImage" >> /usr/share/applications/$app_name.desktop
	echo "Name=$app_name" >> /usr/share/applications/$app_name.desktop
	echo "Icon=/usr/bin/$app_name/$app_name.png" >> /usr/share/applications/$app_name.desktop

}

if sudo -nv 2>/dev/null && sudo -v ; then
	program
else
	echo 'You have to start this script with root privileges.'
fi
