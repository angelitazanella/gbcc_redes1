set ns [new Simulator]

#Define cores
$ns color 2 Red
#Cria arquivo trace
set nf [open estrela.nam w]
$ns namtrace-all $nf

#Define procecimentos finais
proc finish {} {
        global ns nf
        $ns flush-trace
        #Fecha arquivo trace
        close $nf
        #executa simulação NAM
        exec nam estrela.nam &
        exit 0
}

#Cria nós
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Cria enlaces entre os nós
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 2Mb 10ms DropTail
$ns duplex-link $n4 $n2 2Mb 10ms DropTail
$ns duplex-link $n5 $n2 2Mb 10ms DropTail

#Cria conexão UDP
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
$udp set fid_ 2

#Cria gerador de fluxo CBR sobre a conexão UDP
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

#Informações sobre o fluxo CBR
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"



#Agenda eventos
$ns at 0.1 "$cbr start"
$ns at 4.5 "$cbr stop"

#Termina a simulação
$ns at 5.0 "finish"

#Roda a simulação
$ns run

