set terminal png size 1920,1080
set title "Atacs per pais"
set xlabel "Paises"
set ylabel "Ataques"
set style fill solid
set boxwidth 0.5
set xtics rotate by -90 offset 0,-.2
set bmargin 5
set key off
set datafile separator '|'
set output 'Ataques_pais.png'
plot 'paises.log' using 1:xtic(2) with boxes lt rgb "#007bc0"
