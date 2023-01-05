

import { app } from "./app";
import { AppDataSource } from "./data-source";
import { logger } from "./logger";

const port = 3000;

const main = async () => {
  AppDataSource.initialize();

  // サーバ起動
  app.listen(port, () => logger.info("app running!!"));
};
main();