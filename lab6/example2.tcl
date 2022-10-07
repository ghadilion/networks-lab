set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

for {set i 0} {$i < 10} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 9} {incr i} {
	$ns duplex-link $n($i) $n(9) 1Mb 10ms DropTail
	$ns queue-limit $n($i) $n(9) 10
	set tcp($i) [new Agent/TCP]
	$ns attach-agent $n($i) $tcp($i)
	set ftp($i) [new Application/FTP]
	$ftp($i) attach-agent $tcp($i)
	set TCPsink($i) [new Agent/TCPSink]
	$ns attach-agent $n(9) $TCPsink($i)
	$ns connect $tcp($i) $TCPsink($i)
}

for {set i 0} {$i < 9} {incr i} {
	$ns at 0+($i)/10 "$ftp($i) start"
	$ns at 1+($i)/10 "$ftp($i) stop"
}

$ns at 2.0 "finish"

$ns run
