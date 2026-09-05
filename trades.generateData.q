.trades.gen:{[n]
    ([]
        updateTime: n # .z.p;
        date: n # .z.d;
        tradeID: n ? `8;
        orderID: n ? `8;
        sym: n ? `AAPL`MSFT`GOOG`BARC;
        side: n ? `BUY`SELL;
        price: n ? 1000.0;
        size: 100 * (1 + n ? 10)
    )
 };