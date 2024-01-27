import express from "express";
import SpentRouter from "./spent_router";
import SpentCategoryRouter from "./spent_category_router";
import SpentStatusRouter from "./spent_status_router";

const router = express.Router();

SpentRouter.configure(router);
SpentCategoryRouter.configure(router);
SpentStatusRouter.configure(router);

export default router;