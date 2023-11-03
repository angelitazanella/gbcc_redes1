ipv4:
	./ipv4.py $n
	./ipv4_2moodle.py -i ipv4.yaml -o ipv4.xml -t gapfill.j2

ipv6:
	./ipv6.py $n
	./ipv4_2moodle.py -i ipv6.yaml -o ipv6.xml -t gapfill.j2	
	./ipv4_2moodle.py -i ipv6-2.yaml -o ipv6-2.xml -t gapfill.j2	


# all: 
# 	./ipv4.py $n
# 	./ipv4_2moodle.py -i ipv4.yaml -o ipv4.xml -t gapfill.j2