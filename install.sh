#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


chmod +x scripts/*.sh
sh scripts/000-preinstall.sh
sh scripts/001-install.sh
sh scripts/100-configure.sh