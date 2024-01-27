import express from 'express'
import cors from 'cors';
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()
const port = 3000

import spentCategoryController from './controllers/spent_category_controller'
import spentStatusController from './controllers/spent_status_controller'
import spentController from './controllers/spent_controller'

app.use(express.json());

app.use(cors());

app.use(spentController);
app.use(spentCategoryController);
app.use(spentStatusController);

app.get('/', (req, res) => res.json("Working!"));

app.listen(port, () => {
    console.log(`App listening on port ${port}`)
})