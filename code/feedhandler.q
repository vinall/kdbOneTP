\l ../feedhandler/schema.q
/show .z.X --> to show all the command line parameter
/.Q.opt to take the command line parameters and parse into dictionary
cmdline:.Q.opt[.z.X]


PubTo:first "S"$cmdline `pubTo;
show PubTo
Limit:first "I"$cmdline `limit
show Limit
getTablesToData:"S"$"," vs first cmdline `getTables
show getTablesToData