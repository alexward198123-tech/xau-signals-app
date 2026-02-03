const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({
      status: "OK",
          service: "XAU Signals API",
              time: new Date().toISOString()
                });
                });

                app.get("/signal", (req, res) => {
                  res.json({
                      symbol: "XAUUSD",
                          bias: "BUY",
                              timeframe: "M5",
                                  entry: 2345.0,
                                      stopLoss: 2338.0,
                                          takeProfit: 2360.0,
                                              confidence: 0.72
                                                });
                                                });

                                                const PORT = process.env.PORT || 3000;
                                                app.listen(PORT, () => {
                                                  console.log(`Server running on port ${PORT}`);
                                                  });