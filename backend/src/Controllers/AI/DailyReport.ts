import type { Request, Response } from 'express';
import { CROP_DAILY_REPORT } from '@/constants/prompts';
import { sendResponse } from '@/Lib/Response';
import { getChatGPTResponse, ImageUpload } from '@/Services/OpenAi';

const CropDailyReport = async (req: Request, res: Response) => {
    const { files } = req;
    if (!files) {
        return res.status(400).send('No file uploaded.');
    }
    if (files instanceof Array) { 
        const resp = await getChatGPTResponse(CROP_DAILY_REPORT.replaceAll('[CROP_NAME]','potato'), await Promise.all(files.map((file) => ImageUpload(file))));
        return sendResponse({
            res,
            data: {
                resp
            },
            status: 200,
            message: 'Crop daily report generated',
        });
    }
   
    return sendResponse({
        res,
        status: 400,
     
    })
};

export default CropDailyReport;