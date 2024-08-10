import { RequestFile } from '@/types';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { GoogleAIFileManager, UploadFileResponse } from "@google/generative-ai/server";

import fs from 'fs';
import { writeFile } from 'fs/promises';

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY as string);
const fileManager = new GoogleAIFileManager(process.env.GEMINI_API_KEY as string);

export function fileToGenerativePart(file: RequestFile) {
    return {
      inlineData: {
        data: Buffer.from(fs.readFileSync(file.path)).toString("base64"),
        mimeType:file.mimetype,
      },
    };
  }
export const getAIResponse = async (
	prompt: string,
	attactments:{
        inlineData: {
            data: string;
            mimeType: string;
        };
    }[],
) => {
    
    const model = genAI.getGenerativeModel({ model:'gemini-1.5-pro', });
    const {response} = await model.generateContent([ prompt, ...attactments ]);
    if (typeof response === "string") return response;
    const json = JSON.parse(response.candidates?.[ 0 ].content.parts[ 0 ].text?.split('```json')[1].split('```')[0] || '{}');
    console.log(json);
    writeFile('response.json', JSON.stringify(response, null, 2));
    return json;
};
