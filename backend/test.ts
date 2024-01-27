import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
    try {
      const category = await prisma.spentcategory.create({
          data: {
              Description: 'test',
              RegisterDate: new Date().toISOString(),
              Active: true
          },
      });
      console.log(category)
    } catch (error) {
      console.error("Error creating category:", error);
    }
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })