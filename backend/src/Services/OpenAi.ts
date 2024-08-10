import { TRANSLATE_REPORT } from '@/constants/prompts';
import { RequestFile } from '@/types';
import cloudinary from 'cloudinary';
import OpenAi from 'openai';
const openai = new OpenAi();

export const ImageUpload = async (file: RequestFile) => {
	const data = await cloudinary.v2.uploader.upload(file.path, {
		folder: 'reports',
		use_filename: true,
		unique_filename: false,
	});

	return data;
};

export const getChatGPTResponse = async (
	prompt: string,
	attachments: cloudinary.UploadApiResponse[],
) => {
    try {
        const response = await openai.chat.completions.create({
            model: 'gpt-4o-mini',
            messages: [
                {
                    role: 'user',
                    content: [
                        { type: 'text', text: TRANSLATE_REPORT },
                        {
                            type: 'image_url',
                            image_url: {
                                url: attachments[ 0 ].url,
                                detail:'auto'
                            }
                        }
                    ],
                },
            ],
        });
        
        
        console.log(response.choices[ 0 ]);
        
        return response.choices[ 0 ].message.content?.split('```json')[1].split('```')[0];
    }
    catch (e) {
        console.log(e);
    }
};

