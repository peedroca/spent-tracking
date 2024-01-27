import express from 'express'
import cors from 'cors';
import swaggerUi from "swagger-ui-express";

const app = express()
const port = 3000

import Router from './routes';

app.use(express.json());
app.use(express.static("public"));
app.use(cors());

app.use(
    "/docs",
    swaggerUi.serve,
    swaggerUi.setup(undefined, {
        swaggerOptions: {
            url: "/swagger.json",
        },
    })
);

app.use(Router);

app.get('/', (req, res) => res.json("Working!"));

app.listen(port, () => {
    console.log(`App listening on port ${port}`)
})