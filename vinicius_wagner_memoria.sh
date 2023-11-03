#!/bin/bash
# Nomes: Vinícius Bernardes dos Santos e Wagner Ribas Lopes

EXPIRE_TIME=300
DELAY=20
elapsedTime=0

while [ $elapsedTime -le $EXPIRE_TIME ]; do
    curDate=$(date '+%Y%m%d')
    curUser=$USER
    hostName=`hostname`
    totalMem=`vmstat -s | sed -n 1p | awk '{print $1}'`
    totalUsedMem=`vmstat -s | sed -n 2p | awk '{print $1}'`
    totalSwap=`vmstat -s | sed -n 8p | awk '{print $1}'`
    totalUsedSwap=`vmstat -s | sed -n 9p | awk '{print $1}'`
    totalUsrProc=`ps -U $curUser --no-headers | wc -l`
    usrProcMemory=`ps -U $curUser --no-headers -o rss | awk '{rss += $1} END {print rss}'`
    pageFaults=`ps -eo min_flt,maj_flt --no-headers | awk '{pf += $1 + $2} END {print pf}'`


    newLineContent="$curDate,$curUser,$hostName,$totalMem,$totalUsedMem,$totalSwap,$totalUsedSwap,$totalUsrProc,$usrProcMemory,$pageFaults"

    header="data,usu. corrente,hostname,mem. disponivel(K),mem. em uso(K),mem. swap(K),mem. swap em uso(K),proc. usuario,mem. usuario(K),page-faults"
    fileName="vinicius_wagner_$curDate"_memoria_"$curUser.csv"

    if test -e "./$fileName"
    then
        echo $newLineContent >> ./$fileName
    else
        echo $header > ./$fileName
        echo $newLineContent >> ./$fileName
    fi
    
    sleep $DELAY
    elapsedTime=$(( $elapsedTime + $DELAY ))
done