# Criando um simulador
set ns [new Simulator]

# A linha acima define a geração de uma instância do objeto simulador o associa a um objeto chamado ns.
# Esse procedimento inicializa o formato dos pacotes;
# Cria um escalonador de eventos;
# Seleciona o formato padrão de endereçamento;

#Abre arquivo para análise posterior
set nf [open larguradebanda.nam w]
$ns namtrace-all $nf

# A primeira linha cria/abre um arquivo com a extensão nam. 
# O arquivo será lido pelo Network Animator (NAM), uma
# aplicação responsável por gerar animações gráficas das simulações. 
# A  segunda linha diz ao simulador para gravar os passos da
# simulação no formato de entrada do NAM no larguradebanda.nam 


#Cria os nós 
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
# O parâmetro [$ns node] define a criação de um nó para
# o objeto simulador 'ns' criado no início da simulação.

# Cria os enlaces entre os nós
$ns duplex-link $n0 $n2 4Mb 50ms DropTail
$ns duplex-link $n1 $n2 1Mb 50ms DropTail
$ns duplex-link $n3 $n2 1Mb 50ms DropTail
# Cria enlaces full-duplex, com capacidade 1Mb e atraso de 50 ms.
# O último parâmetro define o tipo de fila utilizado, onde 
# DropTail representa o algoritmo FIFO

# Organiza as posições dos nós
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right


# Monitora a fila para os enlace entre os nós 2 e 3
$ns duplex-link-op $n2 $n3 queuePos 0.5

#Cria agentes da camada de transporte e conexão com os nós
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
# A primeira linha cria um agente UDP 
# A última linha anexa o agente ao nó 0

# Cria o agente receptor Null, que irá receber os pacotes
# enviados a ele
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

# Estabelece um canal de comunicação (sessão) entre o 
# emissor e o receptor, a nível de transporte
$ns connect $udp0 $null0  


# Cria os geradores de tráfego e conexão com os
# agentes da camada de transporte
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
# No código acima é criado um tráfego CBR(Constant Bit Rate) [primeira linha]
# que geralmente é usado para stramming de áudio/vídeo.
# A segunda linha define o tamanho do pacote (em bytes)
# A terceira linha define o intervalo de transmissão
# Na quarta linha a aplicação é anexada a um agente de camada de transporte.


# Programa os eventos da simulação
$ns at 0.2 "$cbr0 start"
$ns at 4.7 "$cbr0 stop"
# A aplicação CBR é iniciada no tempo 0.2s e finalizada em 4.7s

$ns at 5.0 "finish"
#No tempo 5.0s é chamado o procedimento finish, que encerra a simulação 


# Define o procedimento de conclusão da simulação
proc finish {} {
        global ns nf
        $ns flush-trace
	# Limpa os arquivos de trace
        close $nf
	#Fecha os arquivos de simulação 

	#Executa a simulação e inicia o escalonador de eventos
        exec nam larguradebanda.nam &
        exit 0
}

#Run the simulation
$ns run
