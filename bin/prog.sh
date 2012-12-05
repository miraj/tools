
prog ()
{
    count=$1
    move=$2
    for f in `seq 1 $count`
    do
        for c in '\' '|' '/' '-'
        do
            echo -n $c
            sleep .1
            if [[ $move == 'move' && $c == '-' && `expr $f % 2` == 0 ]] 
            then
               echo -n 
            else
                echo -n ''
            fi
        done

    done

}


