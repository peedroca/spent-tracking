import { Router } from "express";
import SpentCategoryController from "../controllers/spent_category_controller";

export default class SpentCategoryRouter {
    public static configure(router: Router) {
        router.get('/spentcategory', async (req, res) => {
            const controller = new SpentCategoryController();
            const response = await controller.list();
            res.json(response);
        });

        router.get('/spentcategory/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentCategoryController();
            const response = await controller.getById(id);
            res.json(response);
        });

        router.post('/spentcategory', async (req, res) => {
            const controller = new SpentCategoryController();
            const response = await controller.create(req.body);
            res.json(response);
        });

        router.put('/spentcategory', async (req, res) => {
            const controller = new SpentCategoryController();
            const response = await controller.update(req.body);
            res.json(response);
        });

        router.delete('/spentcategory/:id', async (req, res) => {
            const { id } = req.params;
            const controller = new SpentCategoryController();
            const response = await controller.delete(id);
            res.json(response);
        });
    }
}