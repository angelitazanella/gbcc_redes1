# Criação da instância do simulador ns2
set ns [new Simulator]

$ns color 1 Red

# Configurações do NAM (Network Animator)
set nf [open malha.nam w]
$ns namtrace-all $nf

# Criação dos nós
set num_nodes 7
for {set i 0} {$i < $num_nodes} {incr i} {
    set node($i) [$ns node]
}

$node(1) color Red
$node(5) color Blue

# Criação do enlace com fio entre os nós em uma topologia de malha
for {set i 0} {$i < $num_nodes} {incr i} {
    for {set j [expr {$i+1}]} {$j < $num_nodes} {incr j} {
        $ns duplex-link $node($i) $node($j) 1Mb 10ms DropTail
    }
}

# Agente TCP para enviar dados
set udp [new Agent/UDP]
$ns attach-agent $node(1) $udp

# Agente Null para receber dados
set null [new Agent/Null]
$ns attach-agent $node(5) $null

# Conectar o agente UDP ao agente Null
$ns connect $udp $null
$udp set fid_ 2

# Tráfego CBR (Constant Bit Rate) para enviar dados do nó 1 para o nó 5
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 10000
$cbr set rate_ 0.05MB
$cbr set random_ false

# Início da simulação
$ns at 0.1 "$cbr start"
$ns at 5.0 "$cbr stop"
$ns at 5.1 "finish"


proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam malha.nam &
    exit 0
}

# Tempo total da simulação
#set simulation_time 20
#$ns at $simulation_time "finish"

# Executar a simulação
$ns run

