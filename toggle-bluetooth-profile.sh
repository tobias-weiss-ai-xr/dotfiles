#!/bin/bash
# Toggle Bluetooth Profiles with Pulseaudio
#
# Mode A:
#  - Set bluetooth profile to headset
#  - Moves all outputs to the new audio sink
#  - Enables the headset microphone per default
#  - Moves all inputs to the new audio source
#
# Mode B:
#  - Set bluetooth profile to HQ audio
#  - Moves all outputs to the new audio sink
#
# Also sends you a desktop notification.
#
# Installation:
#  Change the MAC address in the script under bluetooth_mac=
#  cp toggle-bluetooth-profile.sh ~/bin/toggle-bluetooth-profile
#  chmod +x ~/bin/toggle-bluetooth-profile
#
# You should also can add a keybinding for the script.
#
# Copyright (c) 2020 Markus Frosch <markus@lazyfrosch.de>
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the University nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

# Configure your MAC here
bluetooth_mac=CC_98_8B_D1_BD_D2

# internals
cache_data=/tmp/pa-profile-toogle-"$(id -u)"
pa_card=bluez_card."$bluetooth_mac"
pa_sink=bluez_sink."$bluetooth_mac"
pa_source=bluez_source."$bluetooth_mac"

set_profile() {
  local profile="$1"

  pacmd set-card-profile "$pa_card" "$profile"
  echo "$profile" > "$cache_data"

  # Moving inputs to new sink
  inputs=0
  while read -r index
  do
    pacmd move-sink-input "$index" "$pa_sink.$profile"
    ((inputs++))
  done < <(pacmd list-sink-inputs | grep index: | awk '{print $2}')

  outputs=0
  if [[ "$profile" = headset_head_unit ]]
  then
    # Switch to microphone as default
    pacmd set-default-source "$pa_source.$profile"

    # Move all outputs to new source
    while read -r index
    do
      pacmd move-source-output "$index" "$pa_source.$profile"
      ((outputs++))
    done < <(pacmd list-source-outputs | grep index: | awk '{print $2}')
  fi

  notify-send -t 500 -u low --hint int:transient:1 "Bluetooth profile set to $profile" "moved $inputs inputs $outputs outputs"
}

if grep -q headset_head_unit "$cache_data" 2>/dev/null
then
  set_profile a2dp_sink
else
  set_profile headset_head_unit
fi

# vi: expandtab ts=2 sw=2 :
