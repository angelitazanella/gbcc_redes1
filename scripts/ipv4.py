#!/usr/bin/python3
from random import randint
import ipaddress 
import yaml
import sys


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

def create_quiz(quiz):
    questions = {
        'questions': []
    }
    for i in quiz['question']:
        q = f'Cálculo de endereço da rede {i["ip"]}/{i["prefix"]}' 
        description = f'Considere o endereço/prefixo de um host: <strong>{i["ip"]}/{i["prefix"]}</strong>.<br><br>\nIndique os seguintes valores:\n'
        description += f'<ul><li>Endereço de rede: [{i["network"]}]</li>\n'
        description += f'<li>Endereço de broadcast: [{i["broadcast"]}]</li>\n'
        description += f'<li>Espaço de endereçamento de hosts: [{i["firsthost"]}] - [{i["lasthost"]}]</li>\n'
        description += f'<li>Máscara de rede: [{i["mask"]}]</li></ul><br>'
        feedback = 'O endereço de rede é o primeiro endereço da sub-rede, e o endereço de broadcast é o último endereço da sub-rede. O espaço de endereçamento de hosts é o conjunto de endereços IP que podem ser usados por hosts na sub-rede. A máscara de rede é um número binário que indica quantos bits do endereço IP são usados para identificar a rede e quantos bits são usados para identificar o host.'
        answers = [
            {'answer': i['network']},
            {'answer': i['broadcast']},
            {'answer': i['firsthost']},
            {'answer': i['lasthost']},
            {'answer': i['mask']},
        ]
        question = {
            "question": {
                "title": q,
                "description": description,
                "feedback": feedback,
                "answers": answers
            }
        }

        questions['questions'].append(question)

    with open('ipv4.yaml', 'w', encoding='utf-8') as file:
         yaml.dump(questions, file, default_flow_style=False, allow_unicode=True)

def main(questions):   
    quiz = {}
    quiz['question'] = list()
    for i in range(int(questions)):
        ip = generate_random_ip()
        prefix = generate_random_prefix()
        network = ipaddress.IPv4Network(u'/'.join((str(ip), str(prefix))),False)
        q = dict()
        q['ip'] = ip
        q['prefix'] = prefix
        q['network'] = str(network)
        q['prefix'] = prefix
        q['broadcast'] = str(network.broadcast_address)
        q['firsthost'] = str(network[1])
        q['lasthost'] = str(network[-2])
        q['mask'] = str(network.netmask)
        quiz['question'].append(q)

    # print(f"Endereço IP: {ip}/{prefix}")
    # print(f"Endereço de rede: [{network.network_address}]")
    # print(f"Endereço de broadcast: [{network.broadcast_address}]")
    # print(f"Espaço de endereçamento de hosts: [{network[1]}] - [{network[-2]}]")
    # print(f"Máscara de rede: [{network.netmask}]")
    create_quiz(quiz)
    


if __name__ == '__main__':
    questions = 1
    if len(sys.argv) > 1:
        if sys.argv[1].isdigit():
            questions =  sys.argv[1]        
    main(questions)
