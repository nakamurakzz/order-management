import express, { Request, Response } from 'express';
import { ItemUsecase } from "../../usecase/itemUsecase";
import { ItemCreateParams } from '../type/item';
import { logger } from '../../logger';

const router = express.Router();

const itemUsecase = new ItemUsecase();

router.get('/', async (_req: Request, res: Response) => {
  try {
    const items = await itemUsecase.findItems();
    return res.status(200).send(items);
  } catch (err) {
    logger.error(err);
    return res.status(500).send;
  }
});

router.post('/', async (req: Request, res: Response) => {
  try {
    const body = req.body as ItemCreateParams;
    const items = await itemUsecase.create(body);
    return res.status(200).send(items);
  } catch (err) {
    logger.error(err);
    return res.status(500).send;
  }
});

export default router;