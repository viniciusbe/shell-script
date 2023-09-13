# TODO verificar qtd de args
E_BADARGS=66
E_NOSUCHPROCESS=67

# $1: first arg
if test -z "$1"; then # checking if first arg is empty
    echo "Usage: `basename $0` Process_to_get_state"
    exit $E_BADARGS
fi

pids=`pgrep $1` 

# $?: exit status of last command
# exit status '0' mean successfull
if test "$?" != "0"; then # checking if process exists
    echo "processo não encontrado"
    exit $E_NOSUCHPROCESS
fi

for pid in $pids; do
    state=`cat /proc/$pid/status | grep State`
    echo "Pid:$pid -> $state"
done