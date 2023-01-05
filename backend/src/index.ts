

import { app } from "./app";
import { AppDataSource } from "./data-source";

const port = 3000;

const main = async () => {
  AppDataSource.initialize();

  // サーバ起動
  app.listen(port, () => console.info("app running!!"));
};
main();