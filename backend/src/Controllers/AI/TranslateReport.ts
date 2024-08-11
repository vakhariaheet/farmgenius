import { TRANSLATE_REPORT } from "@/constants/prompts";
import { sendResponse } from "@/Lib/Response";
import { fileToGenerativePart, getAIResponse } from "@/Services/Gemini";
import  { getChatGPTResponse, ImageUpload } from "@/Services/OpenAi";
import { Request, Response } from "express"


const TranslateReport = async (req: Request, res: Response) => { 
    const report = req.file;
    if (!report) {
        return res.status(400).send('No file uploaded.');
    }
    const resp = await getChatGPTResponse(TRANSLATE_REPORT, [ await ImageUpload(report) ]);
    
    return sendResponse({
        res,
        data: {resp},
        status: 200,
        message: 'Report translated'
    })
}

export default TranslateReport;