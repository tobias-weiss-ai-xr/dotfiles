#!/bin/bash
# Toggle Bluetooth Profiles with Pulseaudio

# Configure your MAC here
bluetooth_mac=CC_98_8B_D1_BD_D2

# internals
cache_data=/tmp/pa-profile-toogle-"$(id -u)"
pa_card=bluez_card."$bluetooth_mac"
pa_sink=bluez_sink."$bluetooth_mac"
pa_source=bluez_source."$bluetooth_mac"

toggle_sony_state() {
  if [[ -z $(pacmd list-cards | grep $pa_card) ]]
  then
    sudo systemctl restart bluetooth && sleep 1 && bluetoothctl power on && bluetoothctl connect CC:98:8B:D1:BD:D2
    #bluetoothctl power on && bluetoothctl connect CC:98:8B:D1:BD:D2
  else
    bluetoothctl power off
  fi
}

toggle_sony_profile() {

  if grep -q handsfree_head_unit "$cache_data" 2>/dev/null
  then
    local profile="a2dp_sink"
  else
    local profile="handsfree_head_unit"
  fi

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
  if [[ "$profile" = handsfree_head_unit ]]
  then
    # Switch to microphone as default
    pacmd set-default-source "$pa_source.$profile"

    # Move all outputs to new source
    #while read -r index
    #do
    #  pacmd move-source-output "$index" "$pa_source.$profile"
    #  ((outputs++))
    #done < <(pacmd list-source-outputs | grep index: | awk '{print $2}')
  fi

  notify-send -t 500 -u low --hint int:transient:1 "Bluetooth profile set to $profile" "moved $inputs inputs $outputs outputs"
}

# vi: expandtab ts=2 sw=2 :
