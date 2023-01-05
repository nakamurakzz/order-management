import express from 'express';
import type { Application } from 'express';
import { AppDataSource } from "./data-source";

import itemRoute from "./presentation/route/itemRoute";
import orderRoute from "./presentation/route/orderRoute";
import { logger } from './logger';


export const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

AppDataSource.initialize();

app.use((req, _, next) => {
  logger.log(req.method, req.path);
  logger.log(JSON.stringify({ body: req.body, query: req.query, params: req.params }));
  next();
});

// expressの設定
app.use("/items", itemRoute);
app.use("/orders", orderRoute);