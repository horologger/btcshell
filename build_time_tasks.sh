#!/bin/bash

echo "Start Build Time Tasks..."
echo "$TARGETOS : $TARGETARCH : $TARGETVARIANT"

DAOS=$TARGETOS
# echo $DAOS
if [ "$DAOS" == "linux" ]; then
  echo "Running on Linux"
  FNOS="linux"
else
  echo "Running on Mac"
  FNOS="darwin"
fi

DAARCH=$TARGETARCH
# echo $DAARCH
if [ "$DAARCH" == "amd64" ]; then
  echo "Running on x86_64"
  FNARCH="x86_64"
  FNSUFFIX="gnu"
elif [ "$DAARCH" == "arm64" ]; then
  echo "Running on aarch64"
  FNARCH="aarch64"
  FNSUFFIX="gnu"
else
  echo "Running on Raspberry???"
  FNARCH="arm"
  FNSUFFIX="gnueabihf"
fi

FNVER="28.1"

BTCFN="bitcoin-$FNVER-$FNARCH-linux-$FNSUFFIX.tar.gz"
BTCURL="https://bitcoincore.org/bin/bitcoin-core-$FNVER/$BTCFN"
echo "Getting: "$BTCURL

#https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-28.1-x86_64-linux-gnu.tar.gz
#https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-arm-linux-gnueabihf.tar.gz

wget -O /tmp/bitcoin.tar.gz $BTCURL
tar xzf /tmp/bitcoin.tar.gz -C /tmp
cp /tmp/bitcoin-$FNVER/bin/bitcoin-cli /usr/local/bin
rm -rf /tmp/bitcoin-$FNVER
rm -f /tmp/bitcoin.tar.gz

echo "End Build Time Tasks..."
sleep 3