Before starting you'll need to install Raspbian Buster operating system to your microSD card.

1. Head on over to the official Raspberry Pi download page and download  “Raspbian Buster with Desktop and recommended software”
2. Download Balena Etcher — software for flashing memory cards. It works on every major OS
3. Unzip .img file from downloaded .zip
4. Use Etcher to flash .img to your memory card (min 16GB recommended)
5. Do necessary changes to initial configuration, make sure to expand filesystem via raspi-config
6. Open terminal, enter:
```
cd ~
wget https://raw.githubusercontent.com/TCPozitron/OpenCV/master/install-opencv.sh
chmod +x install-opencv.sh
./install-opencv.sh

```
IMPORTANT
I tested a script with Raspberry Pi 3B + and it worked
You need to do following changes in lines 100-102 - instead of:
```
    -D BUILD_EXAMPLES=ON ..

make -j$(nproc)
```
use:
```
    -D BUILD_EXAMPLES=OFF ..

make
```
Be patient, could take 3-4 hours to complete it.
