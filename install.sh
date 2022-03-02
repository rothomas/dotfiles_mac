#!/bin/sh

. `dirname $0`/.helpers/prereq_functions

if ! installed chezmoi; then
  chezmoi_script=`download chezmoi.io/get`
  sh -c "${chezmoi_script}" -- init --verbose --apply rothomas
fi
