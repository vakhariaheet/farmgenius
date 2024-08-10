import dotenv from 'dotenv';
import express from 'express';
import cors from 'cors';
import cloudinary from 'cloudinary';

// Cloudinary Config
cloudinary.v2.config({
    cloud_name: 'fanfic2book',
    api_key: '254927581387386',
    api_secret: process.env.CLOUDINARY_SECRET,
    secure: true,
  });

// Routes
import AuthRoute from './Routes/Auth';
import AIRoute from './Routes/Ai'

import Logger from './Middlewares/Logger';
import { sendResponse } from './Lib/Response';
dotenv.config();


const app = express();
app.use(express.json());
app.use(cors({
    credentials: true,
    methods: [ 'GET', 'POST', 'PUT', 'DELETE' ],
    origin:'*'
}));
app.use(express.urlencoded({ extended: true }));

app.use(Logger);

app.get('/ping', (req,res) => {
    sendResponse({
        status: 200,
        res,
        message: 'Hello World',
        
    })
})

app.use('/auth', AuthRoute);
app.use('/ai',AIRoute)
const PORT = process.env.PORT || 3005;
app.listen(PORT, () => {
    console.log(`Server started at ${PORT} 🔥 🔥 `);
})

