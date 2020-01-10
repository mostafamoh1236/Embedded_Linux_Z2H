#!/bin/bash

cd /etc

if [ ! -f phonebookDB.txt ]
	then
	 echo "You don't have a database, lets create one for you"
	 sudo touch phonebookDB.txt
else
	echo "The file exist and here are the contacts logged in it"
	echo 
	sudo cat phonebookDB.txt
	echo
fi

case $1 in

"-i")
	 read -p "Please enter the name: " name
	 read -p "please enter the telephone number: " tel_number
	 re='^[0-9]+$'
	 if ! [[ $tel_number =~ $re ]] ; then
	 echo "error: you didn't enter a number"; 
	 else 
	 echo "$name-$tel_number" | sudo tee -a  phonebookDB.txt 1>/dev/null
	 fi;;

"-v")
	echo "Here are all the contacts in the phonebook: "
	echo
	sudo cat phonebookDB.txt
	echo;;

"-s")
	echo "Please enter the contact name you want to search for: "
	read contact_name
	sudo grep "${contact_name}" phonebookDB.txt;;

"-e")
	echo "you are deleting all the contacts now"
	sudo sed -i "$!d" "phonebookDB.txt"
	sudo sed -i "$d"  "phonebookDB.txt";;

"-d")
	read -p "Enter the contact name to be deleted: " delete_name
	sudo grep -n $delete_name phonebookDB.txt

	read -p "Please the number assigned to the contact name to delete: " num
	sudo sed -i "$num d" "phonebookDB.txt" ;;

*)
	echo "you didn't enter a correct argument"
esac
