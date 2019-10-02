#! /bin/bash

#MD5 HASH & HASH LIST GENERATOR

# Reset
Reset='\033[0m'       # Text Reset
Red="\033[0;31m"          # Red
Green='\033[0;32m'        # Green
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan      


DIR="$PWD"
HASHLIST="NEWHASHFILE"

gen_ranhash_list() {

	LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w ${1:-10} | head -n 1 | md5 2>&1 | tee -a "$HASHLIST"
}

md5_hash_string() {

	md5 -s $STRING > nullfile.txt | awk -F "= " '{print $2}' nullfile.txt 2>&1 | tee -a "$HASHLIST"
		rm -f nullfile.txt

}
print_menu() {
	printf '

 | || | | | / _ \ /  ___| | | | | ___ \  _  |
/ __) |_| |/ /_\ \\ `--.|  |_| | | |_/ /\ V / 
\__ \  _  ||  _  | `--. \  _  | |    / / _ \ 
(   / | | || | | |/\__/ / | | |_| |\ \| |_| |
 |_|\_| |_/\_| |_/\____/\_| |_(_)_| \_\_____/
                                             
	 '
                                             
	echo -e "\n\n${Purple}MD5 HASH GENERATOR"

	echo -e "ENTER [F] TO SET OR CHANGE THE FILE TO SAVE HASHES TO"
	echo -e "ENTER [1] TO GENERATE HASH OF A GIVEN STRING"
	echo -e "ENTER [2] TO GENERATE RANDOM HASHES"
	echo -e "ENTER [0] TO EXIT"
	read INP
	echo

}
print_menu
while [ "$INP" != "0" ]
do
		if [[ "$INP" == "F" ]]; then
			echo -e "ENTER THE FILE NAME FOR YOUR NEW HASHLIST\n\n
		ALL HASHES GENERATED WILL BE SENT TO THIS FILE UNTIL A NEW FILE IS INPUT" 
			read HASHLIST
			if [[ ! -f $HASHLIST ]]; then
				touch "$HASHLIST"
			fi
			echo -e "${Cyan}HASHLIST FILE NAME SET TO $HASHLIST
			RETURNING TO THE MAIN MENU"
		fi
		if [[ "$INP" == "1" ]]; then
			while [ "$INP" == "1" ]
			do
				echo -e "ENTER THE STRING THAT YOU WOULD LIKE TO CONVERT TO AN MD5 HASH"
				echo -e "${Red}OR ENTER 0 TO RETURN TO THE MENU"
				read STRING
					md5_hash_string
					if [[ "$STRING" == "0" ]]; then
						break
					fi				
			done
		fi
		if [[ "$INP" == "2" ]]; then
			echo -e "${Cyan}READY TO GENERATE RANDOM MD5 HASHES!"
			echo -e "HASH FILE IS CURRENTLY SET TO ${Green}${HASHLIST}"
			echo -e "${Cyan}DEFAULT IS SET TO GENERATE A LIST OF 100 HASHES"
			echo -e "${Cyan}GENERATING RANDOM HASH LIST..."
				#Starts loop and sets the amount of time to run the gen_ranhash_list function
				#Default is set to 100, if you want more or less random hashes change the 100 to desired number
				for run in {1..100}
				do
					gen_ranhash_list
				done

		fi

	print_menu
done




