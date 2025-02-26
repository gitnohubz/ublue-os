#!/bin/bash

set -ouex pipefail

/sh/repo.sh
/sh/pkg.sh
/sh/services.sh