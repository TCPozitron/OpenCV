##Branch for Raspberry Pi 3

Before starting you'll need to install Raspbian Buster operating system to your microSD card.

1. Head on over to the official Raspberry Pi download page and download  “Raspbian Buster with Desktop and recommended software”
2. Download Balena Etcher — software for flashing memory cards. It works on every major OS
3. Unzip .img file from downloaded .zip
4. Use Etcher to flash .img to your memory card (min 16GB recommended)
5. Do necessary changes to initial configuration, make sure to expand filesystem via raspi-config
6. Open terminal, enter:
```
cd ~
wget https://raw.githubusercontent.com/z-hex/OpenCV/master/install-opencv.sh
chmod +x install-opencv.sh
./install-opencv.sh

```
Be patient, could take 3-4 hours to complete it.
