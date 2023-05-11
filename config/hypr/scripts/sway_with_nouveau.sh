#!/bin/bash

# Unload the NVIDIA kernel modules
sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

# Load the Nouveau driver
sudo modprobe nouveau

# Start Sway
sway

# After Sway exits, unload the Nouveau driver
sudo modprobe -r nouveau

# Load the NVIDIA kernel modules
sudo modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia
