#Simulação Barramento
set ns [new Simulator]

#define color for data flows
$ns color 1 Blue
$ns color 2 Red

#arquivos trace
set tracefile1 [open barramento.tr w]
set winfile [open winfile w]
$ns trace-all $tracefile1

#arquivos nam
set namfile [open barramento.nam w]
$ns namtrace-all $namfile

#procemento final
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	exec nam barramento.nam &
	exit 0
} 

#Cria os nós
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
$n1 color Red
$n5 color Blue

#Cria enlace entre os nós
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
set lan [$ns newLan "$n1 $n2 $n3 $n4 $n5 $n6 $n7" 1Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]

#Fornece posição dos nós
$ns simplex-link-op $n0 $n2 orient right
$ns simplex-link-op $n2 $n0 orient left 


#Cria conexao UDP
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 2

#Cria gerador de tráfego CBR sobre UDP
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 0.05Mb
$cbr set random_ false

#Agenda de eventos
$ns at 0.1 "$cbr start"
$ns at 25.0 "$cbr stop"

$ns at 25.5 "finish"
$ns run
