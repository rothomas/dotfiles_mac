#!/bin/sh


. `dirname $0`/.helpers/prereq_functions

require curl

if ! installed chezmoi; then
  chezmoi_script=`curl -fsLS chezmoi.io/get`
  sh -c "${chezmoi_script}"
fi

chezmoi init rothomas

