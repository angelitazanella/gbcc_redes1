#!/usr/bin/python3
from random import randint
import ipaddress 


def generate_random_ip():    
    op = randint(1,3)
    if op == 1:
        octeto_1 = 10
        octeto_2 = randint(0, 255)
        octeto_3 = randint(0, 255)
        octeto_4 = randint(0, 255)
    elif op == 2:
        octeto_1 = 172
        octeto_2 = randint(16, 31)
        octeto_3 = randint(0, 255)
        octeto_4 = randint(0, 255)
    elif op == 3:
        octeto_1 = 192
        octeto_2 = randint(168, 223)
        octeto_3 = randint(0, 255)
        octeto_4 = randint(0, 255)
    return f"{octeto_1}.{octeto_2}.{octeto_3}.{octeto_4}"

def generate_random_prefix():
    return str(randint(8, 30))

def main():
    ip = generate_random_ip()
    prefix = generate_random_prefix()
    network = ipaddress.IPv4Network(u'/'.join((str(ip), str(prefix))),False)
    print(f"Endereço IP: {ip}/{prefix}")
    print(f"Endereço de rede: [{network.network_address}]")
    print(f"Endereço de broadcast: [{network.broadcast_address}]")
    print(f"Espaço de endereçamento de hosts: [{network[1]}] - [{network[-2]}]")
    print(f"Máscara de rede: [{network.netmask}]")
    


if __name__ == '__main__':
    main()
