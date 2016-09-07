#!/bin/bash
#
# LNet router monitor script
# looks for configured routs in the "down" state, then sends an email if it finds any in the down state
#
# Written by: Kurt J. Strosahl (strosahl@jlab.org)
#

# Variable declarations

EMAIL="strosahl@jlab.org"
LCTL="/usr/sbin/lctl"

send_email ()
{
/usr/bin/mutt -s "$1" $EMAIL<< EOF
$2
EOF
}

ROUTEDATA=`$LCTL route_list`

if [ ROUTEDATA == "" ]
then
	send_email "no routes configured on $HOSTNAME" "" 
	exit 1
fi

DOWNDATA=`echo "$ROUTEDATA" | grep up`

if [ DOWNDATA != "" ]
then 
	send_email "Down route found by $HOSTNAME" "$DOWNDATA" 
fi

exit 0

