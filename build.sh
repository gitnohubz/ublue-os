#!/bin/bash

set -ouex pipefail

/tmp/sh/repo.sh
/tmp/sh/pkg.sh
/tmp/sh/services.sh