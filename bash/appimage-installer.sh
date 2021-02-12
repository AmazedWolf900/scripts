#!/bin/sh

program() {
	echo 'Enter the name you want the application to have in the application list.'
	read app_name
	echo 'Enter AppImage and Png file name.'
	read file_name

	#copy program and icon files to the /usr/bin directory
	mkdir /usr/bin/$file_name
	cp $file_name.png /usr/bin/$file_name/$file_name.png
	cp $file_name.AppImage /usr/bin/$file_name/$file_name.AppImage
	chmod +x /usr/bin/$file_name/$file_name.AppImage

	#create desktop entry in /usr/share/applications
	touch /usr/share/applications/$file_name.desktop

	echo "[Desktop Entry]" >> /usr/share/applications/$file_name.desktop
	echo "Encoding=UTF-8" >> /usr/share/applications/$file_name.desktop
	echo "Version=1.0" >> /usr/share/applications/$file_name.desktop
	echo "Type=Application" >> /usr/share/applications/$file_name.desktop
	echo "Terminal=false" >> /usr/share/applications/$file_name.desktop
	echo "Exec=/usr/bin/$file_name/$file_name.AppImage" >> /usr/share/applications/$file_name.desktop
	echo "Name=$app_name" >> /usr/share/applications/$file_name.desktop
	echo "Icon=/usr/bin/$file_name/$file_name.png" >> /usr/share/applications/$file_name.desktop

}

if sudo -nv 2>/dev/null && sudo -v ; then
	program
else
	echo 'You have to start this script with root privileges.'
fi
