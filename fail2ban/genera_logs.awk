BEGIN {
FS=" "
numIP=0
}

{

if ($7 == "Ban"){
    numIP+=1
    print $NF"|"$1"|"$2"|Ban" > "full.log"
    print $NF"|"$1"|"$2 > "banned.log"
}
if ($7 == "Unban"){
    numIP-=1
    print $NF"|"$1"|"$2"|Unban" > "full.log"
    print $NF"|"$1"|"$2"|Unban" > "unban.log"

}
}

END {

}