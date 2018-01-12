# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    testprintf.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fbertoia <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/01/11 10:31:02 by fbertoia          #+#    #+#              #
#    Updated: 2018/01/11 10:31:04 by fbertoia         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#==============Colors
COLOR_NC='\e[0m' # No Color
COLOR_WHITE='\e[37;1m'
COLOR_BLACK='\e[30;1m'
COLOR_BLUE='\e[34;1m'
COLOR_LIGHT_BLUE='\e[34;1m'
COLOR_GREEN='\e[32;1m'
COLOR_LIGHT_GREEN='\e[32;1m'
COLOR_CYAN='\e[36;1m'
COLOR_LIGHT_CYAN='\e[36;1m'
COLOR_RED="\e[31;1m"
COLOR_LIGHT_RED='\e[31;1m'
COLOR_PURPLE='\e[35;1m'
COLOR_LIGHT_PURPLE='\e[35;1m'
COLOR_BROWN='\e[33;1m'
COLOR_YELLOW='\e[33;1m'
COLOR_GRAY='\e[30;1m'
COLOR_LIGHT_GRAY='\e[37;1m'

#==============Files to include
NAME_MYPRINTF=myprintf
NAME_ORIGINAL_PRINTF=originalprintf
NAME_BUFFER_TEST=maintestbuffer
PATH_HEADER=.
LIBFT_NAME=`find .. -type f | grep -e libft\\.a$ | head -n 1`
MAKEFILE_FILE=`find .. -name Makefile | head -n 1`
MAKEFILE=`dirname $MAKEFILE_FILE`
LIBFTPRINTF=$LIBFT_NAME #`find .. -type f | grep -e printf\\.a$ | head -n 1`
INCLUDE_FILE=`find .. -type f | grep -e printf\\.h$`
INCLUDE=`dirname $INCLUDE_FILE`
AUTHOR=`find .. \( -name auteur -o -name author \) | head -n 1`
CFLAGS="-Wall -Wextra -Werror"
SRC_MYPRINTF=B.mainyour.c
SRC_ORIGINAL_PRINTF=B.main_original_printf.c
SRC_BUFFER_TEST=B.maintestbuffer.c
TESTS_FILE=B.tests_file

#==== Test a effectuer =====
let "VALGRIND_INSTALL = 0"
let "LEAKS = 0"
let "TEST_FORM = 0"
let "UNDEFINED_BEHAVIOUR = 1"
let "DISPLAY = 1"
let "BUFFER_TEST = 1"
let "PRINTF_TEST = 0"
let "FSANITIZE = 0"
CYCLE=0
SLEEP="0s"


#==============Install Valgrin
if [ $VALGRIND_INSTALL -eq 1 ]; then
	brew update
	brew install VALGRIND_INSTALL
	alias valgrind="~/.brew/bin/valgrind"
	source ~/.bashrc
fi

#============== Lancement des tests ==============
#..................Tests de forme.................
clear
if [ $TEST_FORM -eq 1 ]; then
	printf "${COLOR_GREEN}====Norminette====\n${COLOR_NC}"
	norminette | grep Error
	sleep 2s ; make -C $MAKEFILE
	printf "${COLOR_GREEN}write \nread\nmalloc\nfree\nexit\n${COLOR_NC}"
	printf "${COLOR_GREEN}====checker====\n${COLOR_NC}"
	nm -u ./$NAME_MYPRINTF
	printf "${COLOR_YELLOW}Fichier auteur : `cat $AUTHOR` ${COLOR_NC}"
	sleep 10s
else
	clear && make re -C $MAKEFILE
fi

#============== Tests  ===================

if [ $LEAKS -eq 1 ]; then
	LEAKS="valgrind"
else
	LEAKS=""
fi

if [ $UNDEFINED_BEHAVIOUR -eq 1 ]; then
	CFLAGS=""
fi

echo "" > tmp_error
echo "" > error_compilation
let "i = 0"
LINES=`wc -l $TESTS_FILE | sed "s/[^0-9]*//g"`

#============Verification du buffer==============

if [ $BUFFER_TEST -eq 1 ]; then
	printf "${COLOR_YELLOW}==== Test du buffer =====${COLOR_NC}\n"
	if [ $DISPLAY -eq 1 ]; then echo "gcc $CFLAGS $SRC_BUFFER_TEST $LIBFTPRINTF -I$INCLUDE -o $NAME_BUFFER_TEST"; fi;
	gcc $CFLAGS $SRC_BUFFER_TEST $LIBFTPRINTF -I$INCLUDE -o $NAME_BUFFER_TEST
	./$NAME_BUFFER_TEST
fi

#============Verification des sorties memoires=============

if [ $FSANITIZE -eq 1 ]; then
	sed -i bak "s/-Wall -Wextra -Werror/-Wall -Wextra -Werror -fsanitize=address/" `find .. -name "Makefile"` 
	make re -C $MAKEFILE
	if [ $DISPLAY -eq 1 ]; then echo "gcc $CFLAGS $SRC_BUFFER_TEST $LIBFTPRINTF -I$INCLUDE -o $NAME_BUFFER_TEST"; fi;
	gcc $CFLAGS $SRC_BUFFER_TEST $LIBFTPRINTF -I$INCLUDE -o $NAME_BUFFER_TEST
	sed -i bak "s/-Wall -Wextra -Werror -fsanitize=address/-Wall -Wextra -Werror/" `find .. -name "Makefile"`
	make re -C $MAKEFILE
fi

#============Verification du printf==============
if [ $PRINTF_TEST -eq 1 ]; then
	printf "${COLOR_YELLOW}==== Test du printf || Nombre de tests : %d =====${COLOR_NC}\n" $LINES
	cat $TESTS_FILE | while read LINE_TEST; do
		if [ ` bc <<< "$i % 100" | cut -d "." -f2 ` -eq 0 ]; then printf "\n${COLOR_YELLOW}Test %d - `bc <<< "$i + 100"\
		| cut -d "." -f2`${COLOR_NC}\n" $i; fi;
		let "i++"
		if [ $DISPLAY -eq 1 ]; then printf "\n${COLOR_YELLOW}Test %d: %s${COLOR_NC}\n" $i "$LINE_TEST"; fi;
		if [ $DISPLAY -eq 1 ]; then echo "gcc $CFLAGS -DTEST_PRINTF=\"$LINE_TEST\" $SRC_MYPRINTF $LIBFTPRINTF -I$INCLUDE -o $NAME_MYPRINTF"; fi;
		if [ $DISPLAY -eq 1 ]; then echo "gcc $CFLAGS -DTEST_PRINTF=\"$LINE_TEST\" $SRC_ORIGINAL_PRINTF $LIBFTPRINTF -I$INCLUDE -o $NAME_ORIGINAL_PRINTF"; fi;
		gcc $CFLAGS -DTEST_PRINTF="$LINE_TEST" $SRC_MYPRINTF $LIBFTPRINTF -I$INCLUDE -o $NAME_MYPRINTF 2>> myprintf_error_compilation
		gcc $CFLAGS -DTEST_PRINTF="$LINE_TEST" $SRC_ORIGINAL_PRINTF $LIBFTPRINTF -I$INCLUDE -o $NAME_ORIGINAL_PRINTF 2>> error_compilation
		
		if [ $? -eq 0 ] || [ $UNDEFINED_BEHAVIOUR -eq 1 ]; then
			TMP_M=`./$NAME_MYPRINTF 2>> tmp_error`
			if [ $DISPLAY -eq 1 ]; then echo "|$TMP_M|"; fi;
			TMP_O=`./$NAME_ORIGINAL_PRINTF 2>>tmp_error`
			if [ $DISPLAY -eq 1 ]; then echo "$LEAKS ./$NAME_MYPRINTF"; fi;
			if [ "$LEAKS" == "valgrind" ]
			then 
				TMP_LEAK=`$LEAKS ./$NAME_MYPRINTF 2>&1 | grep -E "definitely lost|indirectly lost" | grep -E "==[1-9]*==[a-zA-Z :]*[1-9]"`
			else
				TMP_LEAK=""
			fi
			if [ $DISPLAY -eq 1 ]; then echo "|$TMP_O|"; fi;
			if [ "$TMP_M" == "$TMP_O" ] && [ "$TMP_LEAK" = "" ]; then
				printf "\033[0;32m▓\033[0;0m"
			else
				echo "\n\nLigne testee $i : { $LINE_TEST }" >> tmp_error
				echo "\nYour printf :    |`echo "|$TMP_M|"`|" | tr -d '\n' >> tmp_error
				echo "\nThe real printf :|`echo "|$TMP_O|"`|" >> tmp_error
				printf "\033[0;31m▓\033[0;0m"
			fi
			sleep $SLEEP
			if [ $DISPLAY -eq 1 ]; then clear; fi;
		fi
	done
	printf "\n${COLOR_YELLOW}========Affichage des erreurs=======${COLOR_NC}\n" "$LINE_TEST"
	cat tmp_error
fi
