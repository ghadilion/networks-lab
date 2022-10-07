set terminal png
set output '2_loss.png'
set autoscale xfix
# set xrange [0.0:5.0]
set xlabel "Time(in seconds)"
set autoscale
# set yrange [0:0.4]
set ylabel "Throughput(in Kbps)"
set grid
set style data linespoints
plot "ringLoss" using 1:2 title "ringPacketLoss" lt rgb "blue"
