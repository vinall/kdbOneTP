/ -1 "Enter No of records you want to upsert: "
/no:"J"$read0 0;
/`orders insert (
/                  .z.p +1 * til no;
/                  no?`APPL`GOOGL`MSFT`AMZN;
/                  no?100 200 300 400 500;
/                  no?500 1000 3000 4000;
/                  no?`COMPLTED `REJECTED `PENDING `CANCELLED
/                  );
/-1 string [no]," record added to above table.";
.orders.gen:{[n]
    ([]
        time: n # .z.p;
        stock: n ? `AAPL`MSFT`GOOG`BARC;
        quantity: 100 * (1 + n ? 10);
        price: n ? 1000.0;
        status:n ?`COMPLETED`PENDING`CANCELLED
    )
 };

