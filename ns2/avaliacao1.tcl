set ns [new Simulator]

#Cria arquivo trace
set nf [open atraso.nam w]
$ns namtrace-all $nf

#Define procecimentos finais
proc finish {} {
        global ns nf
        $ns flush-trace
        #Fecha arquivo trace
        close $nf
        #executa simulação NAM
        exec nam atraso.nam &
        exit 0
}

#Cria nós
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n2 shape square

$n1 color Red
$n5 color Blue
$n3 color Green

#define color for data flows
$ns color 1 Blue
$ns color 2 Red


#Cria enlaces entre os nós
#atraso do enlace: 10ms
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n3 $n2 2Mb 500ms DropTail
$ns duplex-link $n4 $n2 2Mb 10ms DropTail 
$ns duplex-link $n5 $n2 2Mb 10ms DropTail

$ns queue-limit $n3 $n2 5

#Cria conexão UDP
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set udp2 [new Agent/UDP]
$ns attach-agent $n4 $udp2

set null [new Agent/Null]
$ns attach-agent $n3 $null

set null2 [new Agent/Null]
$ns attach-agent $n5 $null2

$ns connect $udp $null
$ns connect $udp2 $null2
$udp  set fid_ 2
$udp2 set fid_ 1

#Cria gerador de fluxo CBR sobre a conexão UDP
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp
$cbr1 set type_ CBR
$cbr1 set packet_size_ 1000
$cbr1 set interval_ 0.1s
$cbr1 set rate_ 2mb
$cbr1 set random_ false

#Cria gerador de fluxo CBR sobre a conexão UDP
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set type_ CBR
$cbr2 set packet_size_ 1000
$cbr2 set interval_ 0.1
$cbr2 set rate_ 1mb
$cbr2 set random_ false


#Agenda eventos
$ns at 0.1 "$cbr1 start"
$ns at 4.5 "$cbr1 stop"

$ns at 0.1 "$cbr2 start"
$ns at 4.5 "$cbr2 stop"

#Termina a simulação
$ns at 5.0 "finish"

#Roda a simulação
$ns run

