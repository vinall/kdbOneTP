
generateData:{[n]
    show n;
    ([]
        time: n # .z.p;
        stock: n ? `AAPL`MSFT`GOOG`BARC;
        quantity: 100 * (1 + n ? 10);
        price: n ? 1000.0;
        status:n ?`COMPLETED`PENDING`CANCELLED
    )
 };