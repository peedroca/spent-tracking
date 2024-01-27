import { PrismaClient } from '@prisma/client'
import { Controller, Get, Post, Delete, Put, Route, Body, Tags } from "tsoa";
import { CreateSpent, UpdateSpent } from "../models/spent";

const prisma = new PrismaClient()

@Route("/spent")
@Tags('Spent')
export default class SpentController extends Controller{
    @Get("/")
    public async list() {
        try {
            const spents = await prisma.spent.findMany({
                where: { Active: true },
                include: { spentstatus: true, spentcategory: true },
            });

            const transformedSpents = spents.map(spent => ({
                Active: spent.Active,
                RegisterDate: spent.RegisterDate,
                Amount: spent.Amount,
                Description: spent.Description,
                Status: spent.spentstatus?.Description,
                Category: spent.spentcategory?.Description,
                IdSpent: spent.IdSpent
            }));
    
            return transformedSpents
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Get("/:id")
    public async getById(id: any) {
        try {
            const spents = await prisma.spent.findFirst({
                where: { Active: true, IdSpent: Number(id) },
                include: { spentstatus: true, spentcategory: true },
            });
    
            return spents
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Post("/")
    public async create(@Body() requestBody: CreateSpent) {
        try {
            const { category, status, description, amount } = requestBody
    
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
    
            return spents
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Put("/")
    public async update(@Body() requestBody: UpdateSpent) {
        try {
            const { idSpent, category, status, description, amount } = requestBody
    
            const categoryFounded = await prisma.spentcategory.findFirst({
                where: { Active: true, Description: category },
            });
    
            const statusFounded = await prisma.spentstatus.findFirst({
                where: { Active: true, Description: status },
            });
    
            const spents = await prisma.spent.update({
                where: { Active: true, IdSpent: idSpent },
                data: {
                    IdSpentCategory: categoryFounded?.IdSpentCategory,
                    IdSpentStatus: statusFounded?.IdSpentStatus,
                    Description: description,
                    Amount: amount
                },
            });
    
            return spents
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Delete("/:id")
    public async delete(id: any) {
        try {
            const spents = await prisma.spent.update({
                where: { Active: true, IdSpent: Number(id) },
                data: { Active: false, },
            });
    
            return spents
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }
}