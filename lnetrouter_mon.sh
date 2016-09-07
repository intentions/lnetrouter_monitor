#!/bin/bash
#
# LNet router monitor script
# looks for configured routs in the "down" state, then sends an email if it finds any in the down state
#
# Written by: Kurt J. Strosahl (strosahl@jlab.org)
#

# Variable declarations

EMAIL="test@test.org"
LCTL="/usr/sbin/lctl"

send_email ()                                                                                                  
{                                                                                                              
/usr/bin/mutt -s $1 $EMAIL<< EOF                                              
"$2"                                                                                                           
EOF                                                                                                            
}

ROUTEDATA=`$LCTL route_list`

if [ ROUTEDATA == "" ]
then
	send_email "no routes configured on $HOSTNAME" ""
fi


