#!/bin/bash
# déploiement de la version xxx svn vers le rep zord (par défaut)
LOCALPATH=/home/zorddev
DATE=$(date "+%d_%m_%Y.%H")
if [ $# -ge 2 ] # si nb d'arguments >= 2
then
	if [ $1 = $2 ]
	then
		echo origine et source identique
	else
		case "$1" in
		"cvs")
		SRC=$LOCALPATH/  ;;
		"userver")
		SRC=/var/www/zordania/ ;;
		"zordania")
		SRC=zordania@www.zordania.com:/home/zordania/v2/ ;;
		"zorddev")
		SRC=/home/zorddev/ ;;
		*)
		SRC="" ;;
		esac
		case "$2" in
		"cvs") 
		DEST=$LOCALPATH ;;
		"userver")
		DEST=/var/www/zordania ;;
		"zordania")
		DEST=zordania@www.zordania.com:/home/zordania/v2 ;;
		"zorddev")
		DEST=/home/zorddev ;;
		*)
		DEST="" ;;
		esac

		if [ "$SRC" = "" -o "$DEST" = "" ]
		then
			echo usage: $0 TO FROM [force]
			echo valeurs possibles:
			echo "- cvs (local)"
			echo "- userver (dev)"
			echo "- zordania (prod)"
			echo "- zorddev (dev)"
		elif [ $# = 3 ]
		then
			if [ $3 = force ]
			then
				rsync -rtvzC $SRC $DEST --exclude-from='exclude.rsync' > $LOCALPATH/logs/mep/$1_to_$2_$DATE.log
			else
				echo "3e argument = force (ou vide)"
			fi
		else # 2 arguments seulement: simulation -n
			rsync -rtvzCn $SRC $DEST --exclude-from='exclude.rsync' > $LOCALPATH/logs/mep/simul_$1_to_$2_$DATE.log
			cat $LOCALPATH/logs/mep/simul_$1_to_$2_$DATE.log
		fi
	fi
else
	echo usage: $0 TO FROM [force]
	echo valeurs possibles:
	echo "- cvs (local)"
	echo "- userver (dev)"
	echo "- zordania (prod)"
	echo "- zorddev (dev)"
fi

