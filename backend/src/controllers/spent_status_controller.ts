import { Router } from "express";
import { PrismaClient } from '@prisma/client'

const endpoints = Router();
const prisma = new PrismaClient()

endpoints.get('/spentstatus', async (req, res) => {
    try {
        const categories = await prisma.spentstatus.findMany({
            where: { Active: true },
        });

        res.json(categories)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.get('/spentstatus/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const categories = await prisma.spentstatus.findFirst({
            where: { Active: true, IdSpentStatus: Number(id) },
        });

        res.json(categories)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})


endpoints.post('/spentstatus', async (req, res) => {
    try {
        const { description } = req.body

        const status = await prisma.spentstatus.create({
            data: {
                Description: description,
                RegisterDate: new Date().toISOString(),
                Active: true
            },
        });

        res.json(status)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.put('/spentstatus', async (req, res) => {
    try {
        const { idSpentStatus, description } = req.body

        const status = await prisma.spentstatus.update({
            where: { IdSpentStatus: idSpentStatus },
            data: {
                Description: description
            },
        });

        res.json(status)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.delete('/spentstatus/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const status = await prisma.spentstatus.update({
            where: { IdSpentStatus: Number(id) },
            data: {
                Active: false
            },
        });

        res.json(status)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

export default endpoints;