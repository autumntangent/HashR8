#! /bin/bash

#MD5 HASH & HASH LIST GENERATOR

Red="\033[0;31m"          
Green='\033[0;32m'        
Blue='\033[0;34m'         
Purple='\033[0;35m'      
Cyan='\033[0;36m'           

#VARIABLES

DIR="$PWD"
HASHLIST=""
MENU="\nENTER [8] TO SET OR CHANGE THE FILE TO SAVE HASHES TO\nENTER [1] TO GENERATE HASH OF A GIVEN STRING\nENTER [2] TO GENERATE RANDOM HASHES\nENTER [0] TO EXIT\n "

#Function that will generate random hashes
gen_ranhash_list() {

	LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w ${1:-10} | head -n 1 | md5 2>&1 | tee -a "$HASHLIST"
}

md5_hash_string() {

	touch nullfile.txt
	md5 -s $STRING > nullfile.txt | awk -F "= " '{print $2}' nullfile.txt >> "$HASHLIST" | tee -a "$HASHLIST"
		rm -f nullfile.txt

}
banner() {
	echo -e ${Purple} '

 | || | | | / _ \ /  ___| | | | | ___ \  _  |
/ __) |_| |/ /_\ \\ `--.|  |_| | | |_/ /\ V / 
\__ \  _  ||  _  | `--. \  _  | |    / / _ \ 
(   / | | || | | |/\__/ / | | |_| |\ \| |_| |
 |_|\_| |_/\_| |_/\____/\_| |_(_)_| \_\_____/
                                             
	 '    
	 read -n 1 -s -p "PRESS ANY KEY TO CONTINUE..." 
	 echo
	 echo
}
print_menu() {
	echo -e "\n\n${Purple}MD5 HASH GENERATOR\n"
	if [[ -n "$HASHLIST" ]]; then
		echo -e ${Green}"HASH LIST FILE NAME SET AS: ${HASHLIST}"
		echo -e "${Cyan}${MENU}"
		read INP
	elif [[ -z "$HASHLIST" ]]; then
		echo -e "${Red}NO HASH FILE SET!!!\PLEASE ENTER NAME OF HASHLIST FILE TO APPEND HASHES TO"
		read HASHLIST
		echo -e "${Green}HASH FILE SET AS: ${HASHLIST}"
		echo -e "${Cyan}${MENU}"
		read INP
	fi
}

init_list() {
		echo -e "${Green}HASHLIST FILE SET AS : ${HASHLIST}"
		if [[ ! -f $HASHLIST ]]; then
			echo -e "${Red}FILE DOES NOT EXIST. CREATING HASH FILE SET AS ${HASHLIST} NOW..."
				touch $HASHLIST && chmod 755 $HASHLIST | echo "GENERATEDHASHES" >> $HASHLIST
				echo -e "${Green}HASH FILE CREATED & SET"
		elif [[ -e "$HASHLIST" ]]; then
			echo -e "${Green}HASHLIST FILE IS SET TO ${HASHLIST}"
			echo -e "To change the FILE NAME that is set to recieve generated hashes,
${Blue}enter 1 to set it now OR"
			echo -e "${Purple}to RETURN to the MAIN MENU, ENTER 0"
			read H
			if [[ "$H" == "1" ]]; then
				echo -e "ENTER NAME FOR NEW HASHLIST"
				read HASHLIST
			else
				return 1			
			fi
		fi
}

banner
print_menu
while [ "$INP" != "0" ];
do
	if [[ "$INP" == "8" ]]; then
		init_list
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




