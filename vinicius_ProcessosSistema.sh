#!/bin/bash
# Nome: Vinícius Bernardes dos Santos

E_NOSUCHUSERNAME=66

user=$1
if test -z "$1"; then
    user=$USER
else
    if ! id "$1" >/dev/null 2>&1; then
        echo "usuario nao existe"
        exit $E_NOSUCHUSERNAME
    fi
fi

allP=`ps -e --no-headers | wc -l`
userP=`ps -U $user --no-headers | wc -l`
userT=`ps -U $user -T --no-headers | wc -l`
oldestP=`pgrep -U $user -o`
curUsrName=$USER
allRunningPExceptCurUsr=`ps r -e --no-headers -o user | grep -v $curUsrName | wc -l`
rootP=`ps r -U root --no-headers | wc -l`

newLineContent="$allP,$userP,$userT,$oldestP,$curUsrName,$allRunningPExceptCurUsr,$rootP"

header="processos,proc. usuario,threads usuario,proc. mais antigo,usuario corrente,proc. exec. menos usuario corrente,proc. exec. root"
date=$(date '+%Y%m%d')
fileName="$date"_Processos_"$user.csv"

if test -e "./$fileName"
then
    echo $newLineContent >> ./$fileName
else
    echo $header > ./$fileName
    echo $newLineContent >> ./$fileName
fi