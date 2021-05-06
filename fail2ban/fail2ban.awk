BEGIN {
print " _______________________________________________"
print "|\t\t\t\t\t\t|"
print "| IP \033[91m Banneadas\033[39m y \033[92mDesbaneadas\033[39m\t\t\t|"
print "|_______________________________________________|"
print "|\t\t\t\t\t\t|"
print "|   Date\t    Hora\t     IP \t|"
print "|_______________________________________________|"
print "|\t\t\t\t\t\t|"
FS=" "
numIP=0
}

{

if ($7 == "Ban"){
    numIP+=1
    print "| \033[91m" $1 "\t" $2 "\t" $NF "\033[39m\t|"
    print $NF"|"$1"|"$2 > "banned.log"
}
if ($7 == "Unban"){
    numIP-=1
    print "| \033[92m" $1 "\t" $2 "\t"  $NF "\033[39m\t|" 
}
}

END {
print "|_______________________________________________|\n"
print " Actually banned IPs --> " numIP " IPs"
print "Total="numIP > "banned.log"

}