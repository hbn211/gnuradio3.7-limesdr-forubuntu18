#/bin/bash

GnuRadio(){
    echo '|>||>||> GNURADIO <||<||<|'
    echo '>>>>> Dependencies <<<<<' 
    sudo apt install cmake git g++ libboost-all-dev python-dev python-mako \
    python-numpy python-wxgtk3.0 python-sphinx python-cheetah swig libzmq3-dev \
    libfftw3-dev libgsl-dev libcppunit-dev doxygen libcomedi-dev libqt4-opengl-dev \
    python-qt4 libqwt-dev libsdl1.2-dev libusb-1.0-0-dev python-gtk2 python-lxml \
    pkg-config python3-cheetah python-sip-dev -y
    
    read -p "Before GIT CLONE, Check and Press [Enter] to continue..."
    echo '>>>>> GIT CLONE <<<<<'
    git clone --recursive https://github.com/gnuradio/gnuradio.git
    cd gnuradio
    echo '>>>>> CHECKOUT 3.7.14.0<<<<' #13.5 <<<<<'
    git checkout be173d6
		# c6c5753
    git submodule init
    git submodule update
    echo '>>>>> MKDIR BUILD <<<<<'
    mkdir build
    echo '>>>>> BUILD FOLDER <<<<<'
    cd build

    read -p "Before CMAKE, Check and Press [Enter] to continue..."
    echo '>>>>> CMAKE <<<<<'
    cmake ../

    read -p "Before MAKE, Check and Press [Enter] to continue..."
    echo '>>>>> MAKE <<<<<'
    make

    read -p "Before MAKE TEST, Check and Press [Enter] to continue..."
    echo '>>>>> MAKE TEST <<<<<'
    make test

    read -p "Before MAKE INSTALL, Check and Press [Enter] to continue..."
    echo '>>>>> MAKE INSTALL <<<<<'
    sudo make install

    sudo ldconfig
    cd ..

}

gr-limesdr(){
    echo '|>||>||> LIMESDR <||<||<|'
    echo '>>>>> Dependencies <<<<<'
    sudo apt install liblimesuite-dev -y

    read -p "Before GIT CLONE, Check and Press [Enter] to continue..."
    echo '>>>>> GIT CLONE <<<<<'
    git clone https://github.com/myriadrf/gr-limesdr.git
    cd gr-limesdr

    git checkout 83006c6
    
    # echo 'CHECKING #define BOARD_PARAM_DAC 0'
    # if ! cat lib/common/*.* | grep '#define BOARD_PARAM_DAC 0'
    # then
    #     echo 'Inserting #define BOARD_PARAM_DAC 0 in device_handler.h'
    #     sed 's/#include <vector>/#include <vector>\n\n#define BOARD_PARAM_DAC 0/' lib/common/device_handler.h > lib/common/device_handler.h.tmp
    #     mv lib/common/device_handler.h.tmp lib/common/device_handler.h
    #     chmod 755 lib/common/device_handler.h
    #     echo 'DONE'
    # fi

    echo '>>>>> MKDIR BUILD <<<<<'
    mkdir build
    echo '>>>>> BUILD FOLDER <<<<<'
    cd build
    read -p "Before CMAKE, Check and Press [Enter] to continue..."
    echo '>>>>> CMAKE <<<<<'
    cmake ..
    read -p "Before MAKE, Check and Press [Enter] to continue..."
    echo '>>>>> MAKE <<<<<'
    make
    read -p "Before MAKE INSTALL, Check and Press [Enter] to continue..."
    echo '>>>>> MAKE INSTALL <<<<<'
    sudo make install

    sudo ldconfig
    cd ..
}

script(){
    GnuRadio;
    gr-limesdr;

    echo 'Moving shortcut to the /usr/share/applications/'


    cp GNURADIO.desktop /usr/share/applications/

    echo "You have to open the GNURADIO.desktop and select Trust and Launch at the first time"
    echo "ENJOY!"
}

script;
