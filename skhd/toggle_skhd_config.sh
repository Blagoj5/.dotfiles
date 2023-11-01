#!/bin/bash

CONFIG_TYPE=$(cat ./skhd_profile)

# Switch between "mac" and "kinesis"
if [ -z "$CONFIG_TYPE" ]; then
    CONFIG_TYPE="mac"
    echo "mac" > ./skhd_profile
elif [ "$CONFIG_TYPE" == "mac" ]; then
    CONFIG_TYPE="kinesis"
    echo "kinesis" > ./skhd_profile
elif [ "$CONFIG_TYPE" == "kinesis" ]; then
    CONFIG_TYPE="mac"
    echo "mac" > ./skhd_profile
fi

# Clean up the existing .skhdrc file
if [ -e .skhdrc ]; then
    rm .skhdrc
fi

# Copy the appropriate .skhdrc based on the CONFIG_TYPE
case "$CONFIG_TYPE" in
    "mac")
        cp .skhdrc_mac .skhdrc
        ;;
    "kinesis")
        cp .skhdrc_kinesis .skhdrc
        ;;
esac

echo "Script copied for CONFIG_TYPE: $CONFIG_TYPE"
