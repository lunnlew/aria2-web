#! /bin/sh -eu

sessionfile='/appdata/aria2.session'

if [ ! -f ${sessionfile} ];then
	touch ${sessionfile}
fi

list=`wget -qO- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best_ip.txt|awk NF|sed ":a;N;s/\n/,/g;ta"`

if [ -z "`grep "bt-tracker" /app/aria2/conf/aria2.conf`" ]; then
    sed -i '$a bt-tracker='${list} /app/aria2/conf/aria2.conf
    echo "add bt-tracker"
else
    sed -i "s@bt-tracker.*@bt-tracker=$list@g" /app/aria2/conf/aria2.conf
    echo "update bt-tracker"
fi


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
