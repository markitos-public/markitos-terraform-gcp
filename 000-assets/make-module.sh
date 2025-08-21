#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <nuevo_nombre>"
    exit 1
fi

cp -r 001-welcome "$1"