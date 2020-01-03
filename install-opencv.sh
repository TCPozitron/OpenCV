#!/bin/bash -i

############## OpenCV installation on Rasoberry Pi 4  #############

echo "OpenCV Installation Script for Raspberry Pi 4 / Raspbian Buster"
echo "by Zeljko Krnjajic"

echo "Removing Wolfram & LibreOffice..."
sudo apt-get -y purge wolfram-engine
sudo apt-get -y purge libreoffice*
sudo apt-get -y clean
sudo apt-get -y autoremove

# Step 0: Select version
cvVersion="4.1.1"

# Step 1: Update packages
echo "Update & Upgrade....."
sudo apt-get -y update
sudo apt-get -y upgrade
echo "----- Done -----"

# Step 2: Install libraries
echo "Installing libraries....."
sudo apt-get -y install build-essential cmake pkg-config
sudo apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libfontconfig1-dev libcairo2-dev
sudo apt-get -y install libgdk-pixbuf2.0-dev libpango1.0-dev
sudo apt-get -y install libgtk2.0-dev libgtk-3-dev
sudo apt-get -y install libcanberra-gtk*
sudo apt-get -y install libatlas-base-dev gfortran
sudo apt-get -y install libhdf5-dev libhdf5-serial-dev libhdf5-103
sudo apt-get -y install libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
sudo apt-get -y install python3-dev
sudo apt-get -y install python3-testresources
echo "----- Done -----"

# Step 3: Install pip, virtualenv and virtualenvwrapper
echo "Installing Python pip, virtualenv and virtualenvwrapper....."
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo python3 get-pip.py
sudo rm -rf ~/.cache/pip
sudo pip install virtualenv 
sudo pip install virtualenvwrapper

# Install virtual environment
echo "Creating Python environment....."
echo "# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
cd ~

source ~/.bashrc

mkvirtualenv cv -p python3
pip install "picamera[array]"
#pip install opencv-contrib-python==4.1.0.25
pip install numpy
pip install dlib
pip install face_recognition
pip install imutils
echo "----- Done -----"

# Step 4: Download opencv and opencv_contrib
echo "Downloading opencv and opencv_contrib....."
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/$cvVersion.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$cvVersion.zip
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-$cvVersion opencv
mv opencv_contrib-$cvVersion opencv_contrib
echo "----- Done -----"
echo "Changing SWAPSIZE to 2048...."
############ Change SWAPSIZE ############
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
echo "----- Done -----"

# Step 5: Compile and install OpenCV with contrib modules
echo "Compiling and installing OpenCV with contrib modules....."
cd ~/opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
    -D BUILD_EXAMPLES=ON ..

make -j$(nproc)
sudo make install
sudo ldconfig
cd /usr/local/lib/python3.7/site-packages/cv2/python-3.7
sudo mv cv2.cpython-37m-arm-linux-gnueabihf.so cv2.so
cd ~/.virtualenvs/cv/lib/python3.7/site-packages/
ln -s /usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.so cv2.so
echo "----- Done -----"

cd ~
echo "Changing SWAPSIZE back to 100...."
############ Change SWAPSIZE ############
sudo sed -i 's/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
echo "----- Done -----"
echo "----- Installation completed! -----"
