import { Router } from "express";
import SpentStatusController from "../controllers/spent_status_controller";

export default class SpentStatusRouter {
    public static configure(router: Router) {
        router.get('/spentstatus', async (req, res) => {
            const controller = new SpentStatusController();
            const response = await controller.list();
            res.json(response);
        });

        router.get('/spentstatus/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentStatusController();
            const response = await controller.getById(id);
            res.json(response);
        });

        router.post('/spentstatus', async (req, res) => {
            const controller = new SpentStatusController();
            const response = await controller.create(req.body);
            res.json(response);
        });

        router.put('/spentstatus', async (req, res) => {
            const controller = new SpentStatusController();
            const response = await controller.update(req.body);
            res.json(response);
        });

        router.delete('/spentstatus/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentStatusController();
            const response = await controller.delete(id);
            res.json(response);
        });
    }
}