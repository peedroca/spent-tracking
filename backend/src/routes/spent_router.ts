import { Router } from "express";
import SpentController from "../controllers/spent_controller";

export default class SpentRouter {
    public static configure(router: Router) {
        router.get('/spent', async (req, res) => {
            const controller = new SpentController();
            const response = await controller.list();
            res.json(response);
        });

        router.get('/spent/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentController();
            const response = await controller.getById(id);
            res.json(response);
        });

        router.post('/spent', async (req, res) => {
            const controller = new SpentController();
            const response = await controller.create(req.body);
            res.json(response);
        });

        router.put('/spent', async (req, res) => {
            const controller = new SpentController();
            const response = await controller.update(req.body);
            res.json(response);
        });

        router.put('/spent/topending', async (req, res) => {
            const controller = new SpentController();
            const response = await controller.updateAllToPending();
            res.json(response);
        });

        router.delete('/spent/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentController();
            const response = await controller.delete(id);
            res.json(response);
        });
    }
}