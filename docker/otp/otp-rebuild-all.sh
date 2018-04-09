#!/bin/sh
cd ./data/graphs/
for i in *; do
  echo "./otp-rebuild.sh $i"
  ../../otp-rebuild.sh $i
done
