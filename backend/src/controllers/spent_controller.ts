import { Router } from "express";
import { PrismaClient } from '@prisma/client'

const endpoints = Router();
const prisma = new PrismaClient()

endpoints.get('/spent', async (req, res) => {
    try {
        const spents = await prisma.spent.findMany({
            where: { Active: true },
        });

        res.json(spents)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

endpoints.get('/spent/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const spents = await prisma.spent.findFirst({
            where: { Active: true, IdSpent: Number(id) },
            include: { spentstatus: true, spentcategory: true },
        });

        res.json(spents)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})


endpoints.post('/spent', async (req, res) => {
    try {
        const { category, status, description, amount } = req.body

        const categoryFounded = await prisma.spentcategory.findFirst({
            where: { Active: true, Description: category },
        });

        const statusFounded = await prisma.spentstatus.findFirst({
            where: { Active: true, Description: status },
        });

        const spents = await prisma.spent.create({
            data: {
                IdSpentCategory: categoryFounded?.IdSpentCategory,
                IdSpentStatus: statusFounded?.IdSpentStatus,
                Description: description,
                Amount: amount,
                RegisterDate: new Date().toISOString(),
                Active: true
            },
        });

        res.json(spents)
    } catch (error) {
        console.error(error)
    } finally {
        await prisma.$disconnect()
    }
})

// endpoints.put('/spent/category', async (req, res) => {
//     const prisma = new PrismaClient()

//     try {
//         const { idSpentCategory, description } = req.body

//         const category = await prisma.spentcategory.update({
//             where: { IdSpentCategory: idSpentCategory },
//             data: {
//                 Description: description
//             },
//         });

//         res.json(category)
//     } catch (error) {
//         console.error(error)
//     } finally {
//         await prisma.$disconnect()
//     }
// })

// endpoints.delete('/spent/category/:id', async (req, res) => {
//     const prisma = new PrismaClient()

//     try {
//         const { id } = req.params;

//         const category = await prisma.spentcategory.update({
//             where: { IdSpentCategory: Number(id) },
//             data: {
//                 Active: false
//             },
//         });

//         res.json(category)
//     } catch (error) {
//         console.error(error)
//     } finally {
//         await prisma.$disconnect()
//     }
// })

export default endpoints;