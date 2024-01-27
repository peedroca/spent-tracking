import { PrismaClient } from '@prisma/client'
import { Controller, Get, Post, Delete, Put, Route, Body, Tags } from "tsoa";
import { CreateSpentCategory, UpdateSpentCategory } from '../models/spent_category';

const prisma = new PrismaClient()

@Route("/spentcategory")
@Tags('Spent Category')
export default class SpentCategoryController extends Controller{
    @Get("/")
    public async list() {
        try {
            const data = await prisma.spentcategory.findMany({
                where: { Active: true },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Get("/:id")
    public async getById(id: any) {
        try {
            const data = await prisma.spentcategory.findFirst({
                where: { Active: true, IdSpentCategory: Number(id) },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Post("/")
    public async create(@Body() requestBody: CreateSpentCategory) {
        try {
            const { description } = requestBody
    
            const data = await prisma.spentcategory.create({
                data: {
                    Description: description,
                    RegisterDate: new Date().toISOString(),
                    Active: true
                },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Put("/")
    public async update(@Body() requestBody: UpdateSpentCategory) {
        try {
            const { idSpentCategory, description } = requestBody

            const data = await prisma.spentcategory.update({
                where: { IdSpentCategory: idSpentCategory },
                data: {
                    Description: description
                },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Delete("/:id")
    public async delete(id: any) {
        try {
            const data = await prisma.spentcategory.update({
                where: { Active: true, IdSpentCategory: Number(id) },
                data: { Active: false, },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }
}