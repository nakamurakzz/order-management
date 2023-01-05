import express, { Request, Response } from 'express';
import { ItemUsecase } from "../../usecase/itemUsecase";

const router = express.Router();

const itemUsecase = new ItemUsecase();

router.get('/', async (_req: Request, res: Response) => {
  const items = await itemUsecase.findItems();
  return res.status(200).send(items);
});

export default router;