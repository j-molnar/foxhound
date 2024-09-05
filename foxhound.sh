#!/bin/bash

# FOXHOUND - SYMLINK HACK DETECTION

# Global variable declarations and init

	# hostname - server hostname
	hostname=`hostname`

	# ips - server IP addresses
	ips=`hostname -I`

	# msg - message string for email alerts
	msg="$hostname\n$ips\n"
        
	# now - current datetime
        now=`date +%F_%R`

	# runpath - current run data dir
	runpath="/home/temp/foxhound/run.$now"

	# mailto - where to send email reports
	mailto="mailaddress"

	# count_ac - count of current symlinks
	count_ac=""

	# count_wc - count of working symlinks
	count_wc=""
	
	# count_ap - count of all symlinks in previous run
	count_ap=""
	
	# detection - bool, change to true if possible symlink hack is detected and alert needs to be sent
	sendmail=FALSE

main () {

	# Create the results directory
	mkdir -p $runpath

        # check if a previous foxhound run may still be in progress
        if [ -e /home/temp/foxhound/lock ]

                then
		sendmail=TRUE
                msg+="Previous foxhound run possibly still in progress or did not complete correctly. Please review the /home/temp/foxhound directory and check for previosly started foxhound processes."        
		mail

        else
		# Create lock file
                touch /home/temp/foxhound/lock
				
		# Perform symlink scan
		scan

		# Load previous results dir path if exists
		if [ -e /home/temp/foxhound/latest ]

			then
			previous="/home/temp/foxhound/latest"
			
			# If previous scan results already exist, run the compare function to check if the number of symlinks has increased
			compare

		else
			# Otherwise, check if the number of symlinks greatly exceeds an estimated "normal" number of symlinks to check for symlink hacks that predate the foxhound install. Triggers only once. 

		        if (( $count_ac > (( $count_accts * 10 )) ))

				then
                		sendmail=TRUE
                		msg+="Possible symlink attack detected. Scan detected an unusual number of symlinks relative to the number of cPanel accounts!\n    Total symlink count: $count_ac \n    Possible working symlinks: $count_wc \n    Number of cPanel accounts: $count_accts"
			fi

		fi

		# Unlink latest
        	unlink $previous 2>/dev/null;

		# Create new link to current run as latest
        	ln -s $runpath /home/temp/foxhound/latest
        
		# Remove lock file
		rm -f /home/temp/foxhound/lock
        fi

        if [ $sendmail = TRUE ]
                then echo -e $msg | mail -s "$hostname - foxhound alert" $mailto
        fi

}

scan () {

	# Search for symlinks in site docroots
	for docroot in `cut -d= -f9 /etc/userdatadomains`; do
		find $docroot -type l;
	done > $runpath/all-sym.txt

	# Test for working symlinks, print to separate file

	for symlink in `cat $runpath/all-sym.txt`; do
		if [ -e $symlink ]; then
			echo $symlink >> $runpath/working-sym.txt;
		fi;
	done;

	count_ac=`wc -l < $runpath/all-sym.txt`
        count_wc=`wc -l < $runpath/working-sym.txt`
        count_accts=`wc -l < /etc/trueuserdomains`

}

compare () {

	count_ap=`wc -l < $previous/all-sym.txt`

	if (( $count_ac > (( $count_ap + $count_accts )) ))

		then
		sendmail=TRUE
		msg+="Possible symlink attack detected. Number of symlinks increased significantly since previous scan!\n    Current symlink count: $count_ac \n    Previous symlink count: $count_ap \n    Possible working symlinks: $count_wc \n    Number of cPanel accounts: $count_accts"
	
	fi	

}

main;
