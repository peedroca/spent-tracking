import { PrismaClient } from '@prisma/client'
import { Controller, Get, Post, Delete, Put, Route, Body, Tags } from "tsoa";
import { CreateSpentStatus, UpdateSpentStatus } from '../models/spent_status';

const prisma = new PrismaClient()

@Route("/spentstatus")
@Tags('Spent Status')
export default class SpentStatusController extends Controller{
    @Get("/")
    public async list() {
        try {
            const data = await prisma.spentstatus.findMany({
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
            const data = await prisma.spentstatus.findFirst({
                where: { Active: true, IdSpentStatus: Number(id) },
            });
    
            return data
        } catch (error) {
            console.error(error)
        } finally {
            await prisma.$disconnect()
        }
    }

    @Post("/")
    public async create(@Body() requestBody: CreateSpentStatus) {
        try {
            const { description } = requestBody
    
            const data = await prisma.spentstatus.create({
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
    public async update(@Body() requestBody: UpdateSpentStatus) {
        try {
            const { idSpentStatus, description } = requestBody

            const data = await prisma.spentstatus.update({
                where: { IdSpentStatus: idSpentStatus },
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
            const data = await prisma.spentstatus.update({
                where: { Active: true, IdSpentStatus: Number(id) },
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