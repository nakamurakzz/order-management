import "reflect-metadata";
import { DataSource } from "typeorm";
import { Item } from "./infra/entity/Item";

export const AppDataSource = new DataSource({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "admin",
    password: "admin",
    database: "order-management",
    synchronize: true,
    logging: false,
    entities: [Item],
    migrations: [],
    subscribers: [],
});
