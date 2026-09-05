/ feedhandler.q
//Users/shreyaverma/.kx/bin/q feedhandler.q -genTables trades -limit 30 -pubTo localhost:5001

/ --- PHASE 1: CONFIGURATION & COMMAND-LINE PARSING ---
config:.Q.opt .z.x;

/ Extract parameters directly. Use default fallbacks if flags are missing.
pubTo: $[count config`pubTo; first config`pubTo; "localhost:5001"];
genTables: $[count config`genTables; first config`genTables; "orders,trades"];

tableList: (),`$"," vs genTables;
maxLimit: $[count config`limit; "J"$first config`limit; 1000j];
pubTarget: `$":", pubTo;

/ Tracking volumes and constants
batchSize:10j;
c:0j;

/ --- PHASE 2: MODULE LOADING ---
\l schema.q
\l orders.generateData.q
\l trades.generateData.q

show "--- Feedhandler Configured ---";
show "Target Tables:   "; show tableList;
show "Record Max Cap: "; show maxLimit;
show "Loaded Schemas:  "; show tables[];

/ --- PHASE 3: IPC NETWORK CONNECTION ---
/ This will now receive `:localhost:5001 cleanly and connect instantly!
pubHandle:hopen pubTarget;
show ">>> Connected to Tickerplant successfully.";

/ --- PHASE 4: ROUTING ENGINE ---
generateDataForTab:{[tbl]
    $[tbl=`orders; .orders.gen batchSize;
      tbl=`trades; .orders.gen batchSize;
      [show "Unknown table target: "; show tbl; ()]
     ]
 };

/ --- PHASE 5: TIMER & LIFECYCLE MANAGEMENT ---
.z.ts:{
    {
        data:generateDataForTab[x];
        if[count data;
           pubHandle (`upd; x; data);
          ];
    } each tableList;

    c :: c + batchSize;
    show ">>> Cumulative records published: ", string c;

    if[c >= maxLimit;
       show "--- Limit Reached. Closing connection and exiting cleanly. ---";
       hclose pubHandle;
       exit 0;
      ];
 };

/ Activate your background timer loop to tick every 1 second
system "t 1000";