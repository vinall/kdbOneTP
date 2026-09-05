/sample command  q feedhandler.q -getTables "order,trade" -pubTo "DESKTOP-NF7RUD1:2122" -limit 1000
\l ../feedhandler/schema.q
/show .z.X --> to show all the command line parameter
/.Q.opt to take the command line parameters and parse into dictionary
cmdline:.Q.opt[.z.X]


/PubTo:"S"$first cmdline `pubTo;
PubTo:(`localhost:5000)^"S"$first cmdline`pubTo;
show PubTo
/Limit:first "I"$first cmdline `limit;
Limit:(5000)^"J"$first cmdline`limit;
show Limit
/getTablesToData1:"S"$"," vs first cmdline `getTables
getTablesToData:$[(`$first "," vs first cmdline `getTables )~ `; tables[] ; `$"," vs first cmdline `getTables ]
show getTablesToData

