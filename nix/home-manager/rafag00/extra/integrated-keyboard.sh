#!/bin/bash

## Syntax
# To enable the integrated keyboard use './integrated-keyboard.sh enable'
# To disable the integrated keyboard use './integrated-keyboard.sh disable'

## Check User
if [[ "$USER" != "root" ]]; then
  echo "Script must be run by root or via sudo, exiting."
  exit 1
fi

## Check parameters
if [[ $# -gt 1 ]]; then
  echo "Too many arguments, exiting."
  echo "Syntax: ./integrated-keyboard.sh ( enable | disable )"
  exit 2
elif [[ $# -lt 1 ]]; then
  echo "No Arguments given, exiting."
  echo "Syntax: ./integrated-keyboard.sh ( enable | disable )"
  exit 3
elif [[ "$1" != "enable" && "$1" != "disable" ]]; then
  echo "Wrong arguments given, exiting."
  echo "Syntax: ./integrated-keyboard.sh ( enable | disable )"
  exit 4
fi

## Variables
sys_devices_platform_basepath="/sys/devices/platform"
platform="/i8042"
input_keyboard="/serio0/input/input0"
keyboard_fullpath="$sys_devices_platform_basepath$platform$input_keyboard/inhibited"
# decide if enable or disable
if [[ "$1" == "disable" ]]; then
  #echo "# Disabling the laptop keyboard #"
  #echo "inhibiting integrated keyboard via $keyboard_fullpath"
  echo 1 > $keyboard_fullpath
  #echo "# Laptop keyboard disabled #"
  cat <<\EOF
  _  __         _                      _      _ _          _    _        _ 
 │ │╱ ╱___ _  _│ │__  ___  __ _ _ _ __│ │  __│ (_)___ __ _│ │__│ │___ __│ │
 │ ' <╱ ─_) ││ │ '_ ╲╱ _ ╲╱ _` │ '_╱ _` │ ╱ _` │ (_─<╱ _` │ '_ ╲ ╱ ─_) _` │
 │_│╲_╲___│╲_, │_.__╱╲___╱╲__,_│_│ ╲__,_│ ╲__,_│_╱__╱╲__,_│_.__╱_╲___╲__,_│
           │__╱                                                            
EOF
  exit 0
elif [[ "$1" == "enable" ]]; then
  #echo "# Enabling the laptop keyboard #"
  #echo "un-inhibiting integrated keyboard via $keyboard_fullpath"
  echo 0 > $keyboard_fullpath
  #echo "# Laptop keyboard enabled #"
  cat <<\EOF
  _  __         _                      _                 _    _        _ 
 │ │╱ ╱___ _  _│ │__  ___  __ _ _ _ __│ │  ___ _ _  __ _│ │__│ │___ __│ │
 │ ' <╱ ─_) ││ │ '_ ╲╱ _ ╲╱ _` │ '_╱ _` │ ╱ ─_) ' ╲╱ _` │ '_ ╲ ╱ ─_) _` │
 │_│╲_╲___│╲_, │_.__╱╲___╱╲__,_│_│ ╲__,_│ ╲___│_││_╲__,_│_.__╱_╲___╲__,_│
           │__╱                                                                                                                      
EOF
  exit 0
fi
