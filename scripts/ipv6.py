#!/usr/bin/python3
import random
import sys
import ipaddress
import yaml

def generate_custom_ipv6():
    # Prefixo IPv6 global unicast
    prefix = "2001:db8::/32"

    # Converte o prefixo em um objeto ipaddress.IPv6Network
    network = ipaddress.IPv6Network(prefix, strict=False)

    # Gera um endereço IPv6 aleatório dentro da rede especificada
    random_ip = ipaddress.IPv6Address(random.randint(int(network.network_address), int(network.broadcast_address)))

    # Transforma o endereço em uma representação com zeros à esquerda
    padded_ip = ":".join(format(int(part, 16), '04x') for part in str(random_ip).split(":"))

    # Especifica as partes do endereço que devem ter zeros à esquerda
    zero_padded_parts = [3, 4, 5, 6]

    # Adiciona zeros à esquerda nas partes especificadas
    for index in zero_padded_parts:
        padded_ip = ":".join(padded_ip.split(":")[:index] + [format(int(padded_ip.split(":")[index], 16), '04x')] + padded_ip.split(":")[index+1:])

    # Escolhe aleatoriamente uma posição para inserir uma sequência de zeros
    start_index_1 = random.randint(2, len(padded_ip.split(":")) - 2)

    # Insere uma ou duas sequências de zeros
    zeros_sequence_1 = ":".join(['0000'] * random.randint(2, 3))  # Sequência de 2 a 4 zeros
    padded_ip = ":".join(padded_ip.split(":")[:start_index_1] + [zeros_sequence_1] + padded_ip.split(":")[start_index_1:])

    # Decide aleatoriamente se incluir uma segunda sequência de zeros
    if random.choice([True, False]):
        start_index_2 = random.randint(2, len(padded_ip.split(":")) - 2)
        zeros_sequence_2 = ":".join(['0000'])  # Sequência de 2 a 4 zeros
        padded_ip = ":".join(padded_ip.split(":")[:start_index_2] + [zeros_sequence_2] + padded_ip.split(":")[start_index_2:])

    # Limita o número máximo de conjuntos numéricos a 8
    padded_ip = ":".join(padded_ip.split(":")[:8])

    return padded_ip


def create_quiz(quiz):
    questions = {
        'questions': []
    }
    for i in quiz['question']:
        q = f'Representação de Endereços IPv6: {i["ip"]}' 
        description = f'Considere o seguinte endereço IPv6: <strong>{i["ip"]}</strong>.<br><br>\n\n'
        description += f'Apresente a representação compactada desse endereço: [{i["compactado"]}]\n'
        feedback = ''
        answers = [
            {'answer': i['compactado']},
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

    with open('ipv6.yaml', 'w', encoding='utf-8') as file:
         yaml.dump(questions, file, default_flow_style=False, allow_unicode=True)


def create_quiz2(quiz):
    questions = {
        'questions': []
    }
    for i in quiz['question']:
        q = f'Representação Compactada de Endereços IPv6: {i["compactado"]}' 
        description = f'Considere o seguinte endereço IPv6 apresentado no formato compactado: <strong>{i["compactado"]}</strong>.<br><br>\n\n'
        description += f'Apresente a representação completa desse endereço: [{i["ip"]}]\n'
        feedback = ''
        answers = [
            {'answer': i['ip']},
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

    with open('ipv6-2.yaml', 'w', encoding='utf-8') as file:
         yaml.dump(questions, file, default_flow_style=False, allow_unicode=True)

def main(questions):   
    quiz = {}
    quiz['question'] = list()
    for i in range(int(questions)):
        ipv6 = generate_custom_ipv6()
        compactado = str(ipaddress.IPv6Address(ipv6))
        q = dict()
        q['ip'] = ipv6
        q['compactado'] = compactado
        quiz['question'].append(q)
    create_quiz(quiz)

    quiz2 = {}
    quiz2['question'] = list()
    for i in range(int(questions)):
        ipv6 = generate_custom_ipv6()
        compactado = str(ipaddress.IPv6Address(ipv6))
        q = dict()
        q['ip'] = ipv6
        q['compactado'] = compactado
        quiz2['question'].append(q)
    create_quiz2(quiz2)
    

if __name__ == "__main__":
    questions = 1
    if len(sys.argv) > 1:
        if sys.argv[1].isdigit():
            questions =  sys.argv[1]        
    main(questions)