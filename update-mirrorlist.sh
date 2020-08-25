
#!/bin/bash

# use "sudo su" before executing, needs sudo permissions
echo "Downloading updated mirrorlist"
if curl -L "https://www.archlinux.org/mirrorlist/?country=DK&country=FI&country=DE&country=LV&country=LT&country=NO&country=PL&country=SE&protocol=http&protocol=https&ip_version=4" --output mirrorlist --silent; then
	sed -i "s/#Server/Server/g" mirrorlist
	echo "Creating mirrorlist backup"
	TIMESTAMP=$(date +%s)
	cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-$TIMESTAMP.bak
	mv mirrorlist /etc/pacman.d/mirrorlist
	echo "Mirrorlist updated successfully, running pacman -Syy"
	pacman -Syy
else
	echo "Failed to download new mirrorlist :("
fi
echo "Done!"
