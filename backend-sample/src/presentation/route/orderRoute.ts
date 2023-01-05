import express, { Request, Response } from 'express';
import { OrderUsecase } from "../../usecase/orderUsecase";
import { OrderCreateParams } from '../type/order';

const router = express.Router();

const orderUsecase = new OrderUsecase();

router.get('/', async (_req: Request, res: Response) => {
  try {
    const orders = await orderUsecase.findOrders();
    return res.status(200).send(orders);
  } catch (err) {
    console.error(err);
    return res.status(500).send;
  }
});

router.post('/', async (req: Request, res: Response) => {
  try {
    const body = req.body as OrderCreateParams;
    const orders = await orderUsecase.create(body);
    return res.status(200).send(orders);
  } catch (err) {
    console.error(err);
    return res.status(500).send;
  }
});

export default router;