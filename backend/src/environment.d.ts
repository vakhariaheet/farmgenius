import { RequestFile } from "./types";

declare module NodeJS {
	declare namespace Express {
		export interface Request {
			file?: RequestFile;
		}
  }
	interface Global {
		__basedir: string;
	}
	interface ProcessEnv {
		NODE_ENV: 'development' | 'production';
		PORT: string;
		MONGO_URI: string;
		JWT_SECRET: string;
		SENDGRID_API_KEY:string
	}

}


