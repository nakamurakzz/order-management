import express from 'express';
import type { Application } from 'express';
import { AppDataSource } from "./data-source";

import itemRoute from "./presentation/route/itemRoute";


export const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

AppDataSource.initialize();

// expressの設定
app.use("/items", itemRoute);