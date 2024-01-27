import { Router } from "express";
import { PrismaClient } from '@prisma/client'

const endpoints = Router();
const prisma = new PrismaClient()

endpoints.get('/spentcategory', async (req, res) => {
    try {
        const categories = await prisma.spentcategory.findMany({
            where: { Active: true },
        });

        res.json(categories)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.get('/spentcategory/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const categories = await prisma.spentcategory.findFirst({
            where: { Active: true, IdSpentCategory: Number(id) },
        });

        res.json(categories)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})


endpoints.post('/spentcategory', async (req, res) => {
    try {
        const { description } = req.body

        const category = await prisma.spentcategory.create({
            data: {
                Description: description,
                RegisterDate: new Date().toISOString(),
                Active: true
            },
        });

        res.json(category)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.put('/spentcategory', async (req, res) => {
    try {
        const { idSpentCategory, description } = req.body

        const category = await prisma.spentcategory.update({
            where: { IdSpentCategory: idSpentCategory },
            data: {
                Description: description
            },
        });

        res.json(category)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.delete('/spentcategory/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const category = await prisma.spentcategory.update({
            where: { IdSpentCategory: Number(id) },
            data: {
                Active: false
            },
        });

        res.json(category)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

export default endpoints;