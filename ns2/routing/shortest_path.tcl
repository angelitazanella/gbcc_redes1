set ns [new Simulator]


# Create six nodes
set x [$ns node]
set y [$ns node]
set z [$ns node]
set w [$ns node]
set r1 [$ns node]
set r2 [$ns node]
set r3 [$ns node]
set r4 [$ns node]
set a [$ns node]
set b [$ns node]
set c [$ns node]
set d [$ns node]

# Define NAM node colors
$x color green
$y color red
$z color purple
$w color white
$r1 shape box
$r2 shape box
$r3 shape box
$r4 shape box
$a color green
$b color red
$c color purple
$d color white

# Links
$ns duplex-link $r1 $x  10Mb 1ms  DropTail
$ns duplex-link $r1 $c  10Mb 1ms  DropTail
$ns duplex-link $r1 $r2 2Mb  20ms DropTail

$ns duplex-link $r2 $y  10Mb 1ms  DropTail
$ns duplex-link $r2 $d  10Mb 1ms  DropTail
$ns duplex-link $r2 $r3 10Mb 40ms DropTail

$ns duplex-link $r3 $z  10Mb 1ms  DropTail
$ns duplex-link $r3 $a  10Mb 1ms  DropTail
$ns duplex-link $r3 $r4 2Mb  20ms DropTail

$ns duplex-link $r4 $w  10Mb 1ms  DropTail
$ns duplex-link $r4 $b  10Mb 1ms  DropTail
$ns duplex-link $r4 $r1 10Mb 40ms DropTail

# Orientation (NAM)
$ns duplex-link-op $r1 $x orient up
$ns duplex-link-op $r1 $c orient left
$ns duplex-link-op $r1 $r2 orient right

$ns duplex-link-op $r2 $y orient right
$ns duplex-link-op $r2 $d orient up
$ns duplex-link-op $r2 $r3 orient down

$ns duplex-link-op $r3 $z orient right
$ns duplex-link-op $r3 $a orient down
$ns duplex-link-op $r3 $r4 orient left

$ns duplex-link-op $r4 $w orient left
$ns duplex-link-op $r4 $b orient down
$ns duplex-link-op $r4 $r1 orient up


# Returns the local link that leads to
# the next hop node with the passed
# node address parameter. If no link to
# the given node exists, the procedure
# returns -1.
Node instproc nexthop2link { nexthop } {
	#$self instvar link_
	set ns_ [Simulator instance]
	foreach {index link} [$ns_ array get link_] {
		set L [split $index :]
		set src [lindex $L 0]
		if {$src == [$self id]} {
			set dst [lindex $L 1]
			if {$dst == $nexthop} {	
				# Cost Debug
				#puts "Src:$src Dst:$dst Link:$link"
				#puts "[$link info class]"
				# End Cost Debug
				return $link
			}
		}
	}
	return -1
}

#
# This procedure is used to add explicitly
# routes to a node, overriding the routing
# policy used (e.g. shortest path routing).
# Tested currently with static ns2 routing.
# Essentially, it is used to add policy-routing
# entries in realistic network topologies.
#
# Parameters:
#
#	node: the ns2 node, to which the route
#	      entry is added to. This parameter
#	      is of type Node.
#	dst: the destination, to which the route
#	     entry refers to. This parameter
#	      is of type Node.
#	via: the next hope node, that the local node
#	     will use to access the destination node.
#	     This parameter is of type Node.
#
##########################################################
proc addExplicitRoute {node dst via } {
	set link2via [$node nexthop2link [$via node-addr]]
	if {$link2via != -1} {
		$node add-route [$dst node-addr] [$link2via head]
	} else {
		puts "Warning: No link exists between node [$node
node-addr] and [$via node-addr]. Explicit route not
added."
	}
}

# Now the Routing Table
$ns at 0 "addExplicitRoute $r1 $z $r4"
$ns at 0 "addExplicitRoute $r1 $a $r2"
$ns at 0 "addExplicitRoute $r1 $w $r4"

$ns at 0 "addExplicitRoute $r2 $w $r1"
$ns at 0 "addExplicitRoute $r2 $b $r3"
$ns at 0 "addExplicitRoute $r2 $x $r1"

$ns at 0 "addExplicitRoute $r3 $x $r2"
$ns at 0 "addExplicitRoute $r3 $c $r4"
$ns at 0 "addExplicitRoute $r3 $y $r2"

$ns at 0 "addExplicitRoute $r4 $y $r3"
$ns at 0 "addExplicitRoute $r4 $d $r1"
$ns at 0 "addExplicitRoute $r4 $z $r3"
