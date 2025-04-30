#!/bin/bash
#$Revision:001$
#variable declaration 

BASE=/home/sapi/project
DAYS=10
DEPTH=1
RUN=0


#check dir present or not 

if [ ! -d $BASE ]
then     

   echo "directory does not exist: $BASE"
        exit 1
fi

#create archive folder if not present

if [ ! -d $BASE/archive ]
        then
                mkdir $BASE/archive
fi


#find the list of files larger than 20MB

for i in `find $BASE -maxdepth $DEPTH -type f -size +20M`
do
        if [ $RUN -eq 0  ]
        then
        gzip $i || exit 1
        mv $i.gz  $BASE/archive || exit 3
        echo "Archive file created successfully in $BASE/archive "      
        fi
done



for i in `find $BASE -maxdepth $DEPTH -type f -size +20M`
do
    if [ $RUN -eq 0 ]
    then
        gzip "$i" || exit 1
        filename=$(basename "$i")
        datetime=$(date +"%Y%m%d_%H%M%S")
        mv "$i.gz" "$BASE/archive/${filename}_${datetime}.gz" || exit 3
        echo "Archive file ${filename}_${datetime}.gz created successfully in $BASE/archive"
    fi
done
