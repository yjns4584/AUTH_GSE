import express from 'express'
import path from 'path'
import fetch from 'node-fetch'
import { fileURLToPath } from 'url';

const app = express();

const port = 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(express.json())

app.use(express.static(path.join(__dirname, './')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'PDF-417.html'))
})

    app.post('/api/sendResult', async (req, res) => {
        const parsedResult =req.body
        console.log('ola?', parsedResult)

    if(!parsedResult) {
       return res.status(400).json({ error: 'Datos invalidos' })
    }

})
app.listen(port, () => {
    console.log(`SERVIDOR ACTIVO EN EL PUERTO ${port}`)
})