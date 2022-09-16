set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec ../nam out.nam &
    exit 0
}

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link-op $n0 $n3 orient right-down
$ns queue-limit $n0 $n3 10

$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link-op $n1 $n3 orient right-up
$ns queue-limit $n1 $n3 10

$ns duplex-link $n2 $n3 1Mb 10ms DropTail 
$ns duplex-link-op $n2 $n3 orient right
$ns queue-limit $n2 $n3 10

set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n0 $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n1 $tcp1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set tcp2 [new Agent/TCP]
$tcp2 set class_ 3
$ns attach-agent $n2 $tcp2

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set TCPsink1 [new Agent/TCPSink]
$ns attach-agent $n3 $TCPsink1

set TCPsink2 [new Agent/TCPSink]
$ns attach-agent $n3 $TCPsink2

set TCPsink3 [new Agent/TCPSink]
$ns attach-agent $n3 $TCPsink3

$ns connect $tcp0 $TCPsink1
$ns connect $tcp1 $TCPsink2
$ns connect $tcp2 $TCPsink3

$ns at 1.0 "$ftp0 start"
$ns at 4.0 "$ftp0 stop"
$ns at 1.0 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"
$ns at 1.0 "$ftp2 start"
$ns at 4.0 "$ftp2 stop"

$ns at 5.0 "finish"

$ns run
