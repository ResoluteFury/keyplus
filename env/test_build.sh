#!/bin/bash

# on error, cause the script to exit
set -e

# load version number into __version__ as a bash variable
source ./host-software/keyplus/version.py

# get the current git hash
keyplus_git_hash=$(git rev-parse --short=7 HEAD)

# print build and git hash of current
echo
echo -e "#########################################"
echo -e "# Starting Test build ${__version__}-${keyplus_git_hash}\t#"
echo -e "#########################################"
echo

cd ports/xmega
echo "###########"
echo "#  xmega  #"
echo "###########"
make MCU=atxmega32a4u ID=0 BOARD=keyplus_mini
make MCU=atxmega128a4u ID=14 BOARD=alpha_split
make MCU=atxmega64c3 LAYOUT_FILE=../../layouts/spectre.yaml BOARD=plain
cd ../..

cd ports/atmega32u4
echo "################"
echo "#  atmega32u4  #"
echo "################"
make MCU=atmega32u4 BOARD=default LAYOUT_FILE=../../layouts/1key.yaml
make MCU=atmega32u4 BOARD=atmel-dfu LAYOUT_FILE=../../layouts/32u4_test.yaml
cd ../..

cd ports/nrf24lu1
  echo
  echo "##############"
  echo "#  nrf24LU1  #"
  echo "##############"
  echo
  make BOARD=512_bootloader ID=48 LAYOUT_FILE=../../layouts/basic_split_test.yaml
  make BOARD=unirecv ID=48 LAYOUT_FILE=../../layouts/basic_split_test.yaml
cd ../..

cd ports/efm8
  echo
  echo "##########"
  echo "#  efm8  #"
  echo "##########"
  echo
  make BOARD=default
  make BOARD=efm8ub30_qfn20
cd ../..
