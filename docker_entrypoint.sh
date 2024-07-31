#!/bin/bash
#exec /bin/start.sh &
#exec /bin/launch-edgestore.sh &
DAOS=$(uname -s | tr '[:upper:]' '[:lower:]')
# echo $DAOS
if [ "$DAOS" == "linux" ]; then
  echo "Running on Linux"
  FNOS="linux"
else
  echo "Running on Mac"
  FNOS="darwin"
fi

DAARCH=$(uname -p | tr '[:upper:]' '[:lower:]')
# echo $DAARCH
if [ "$DAARCH" == "x86_64" ]; then
  echo "Running on x86_64"
  FNARCH="amd64"
else
  echo "Running on ARM"
  FNARCH="arm64"
fi
# echo $FNOS
# echo $FNARCH

FNVER="v0.18.1-beta"

echo APP_PASSWORD = $APP_PASSWORD

GOTTY_CREDS=admin:$APP_PASSWORD

echo GOTTY_CREDS = $GOTTY_CREDS

LNDFN="lnd-$FNOS-$FNARCH-$FNVER.tar.gz"
echo "Getting: "$LNDFN


#wget -O /tmp/lnd.tar.gz https://github.com/lightningnetwork/lnd/releases/download/$FNVER/$LNDFN
#tar xzf /tmp/lnd.tar.gz -C /tmp
#cp /tmp/lnd-$FNOS-$FNARCH-$FNVER/BTCCLI /usr/local/bin

mkdir -p /data/bin
echo 'export PATH=/data/bin:$PATH' >> /root/.bashrc

exec /usr/bin/gotty --port 8080 -c $GOTTY_CREDS --permit-write --reconnect /bin/bash