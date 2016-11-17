typeset -a hamming=(1)
function nextHamming {
    typeset -Sa q2 q3 q5
    integer h=${hamming[${#hamming[@]}-1]}
    q2+=( $(( h*2 )) )
    q3+=( $(( h*3 )) )
    q5+=( $(( h*5 )) )
    h=$( min3 ${q2[0]} ${q3[0]} ${q5[0]} )
    (( ${q2[0]} == h )) && ashift q2 >/dev/null
    (( ${q3[0]} == h )) && ashift q3 >/dev/null
    (( ${q5[0]} == h )) && ashift q5 >/dev/null
    hamming+=($h)
}
 
function ashift {
    nameref ary=$1
    print -- "${ary[0]}"
    ary=( "${ary[@]:1}" )
}
 
function min3 {
    if (( $1 < $2 )); then
        (( $1 < $3 )) && print -- $1 || print -- $3
    else
        (( $2 < $3 )) && print -- $2 || print -- $3
    fi
}
 
for ((i=1; i<=20; i++)); do
    nextHamming
    printf "%d\t%d\n" $i ${hamming[i-1]}
done
for ((; i<=1690; i++)); do nextHamming; done
nextHamming
printf "%d\t%d\n" $i ${hamming[i-1]}
print "elapsed: $SECONDS"
