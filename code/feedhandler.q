/sample command  q feedhandler.q -getTables "order,trade" -pubTo "DESKTOP-NF7RUD1:2122" -limit 1000
\l schema.q

/show .z.x --> to show all the command line parameter
/.Q.opt to take the command line parameters and parse into dictionary
cmdline:.Q.opt[.z.x]
PubTo:`$("localhost:1212"^first cmdline`pubTo); /having error if cmdnline is blank need to handle in if condition
show PubTo;
Limit:5000^"J"$first cmdline`limit;
show Limit;
getTablesToData:$[(`$first "," vs first cmdline `getTables )~ `; tables[] ; `$"," vs first cmdline `getTables ];
show getTablesToData;

TP_Connect:@[hopen;hsym PubTo;{x}];
if[10h=type TP_Connect;exit 1 ];
-1 string[TP_Connect] ,"sucessfully conected";
 show "Sucessfull connected with hanlde :", string [TP_Connect];

generateDataForTab:{[tbl]
    system "l ",string [tbl],".generateData.q";
    generateData[5]
   }
.z.ts:{[]
    {[tbl] neg[TP_Connect] (`upd;tbl;generateDataForTab tbl ) } each tables[];
 }

