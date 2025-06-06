#!/bin/bash

# platform = multi_platform_sle,multi_platform_ubuntu
# variables = var_accounts_tmout=700

TEST_FILE=/etc/profile.d/tmout.sh

sed -i "/.*TMOUT.*/d" /etc/profile

test -f $TEST_FILE || touch $TEST_FILE

if grep -q "TMOUT" $TEST_FILE; then
	sed -i "s/.*TMOUT.*/TMOUT=700\nreadonly TMOUT\nexport TMOUT/" $TEST_FILE
else
	echo -e "TMOUT=700\nreadonly TMOUT\nexport TMOUT" >> $TEST_FILE
fi
