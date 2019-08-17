#! /bin/sh -eu

if [ "$ARIA2_SSL" = "true" ]; then
echo "Start aria2 with secure config"

/usr/bin/aria2c --conf-path="/app/aria2/conf/aria2.conf" \
--enable-rpc --rpc-listen-all \
--rpc-certificate=/app/aria2/conf/key/aria2.crt \
--rpc-private-key=/app/aria2/conf/key/aria2.key \
--rpc-secure

else

echo "Start aria2 with standard mode"
/usr/bin/aria2c --conf-path="/app/aria2/conf/aria2.conf" --enable-rpc --rpc-listen-all

fi
