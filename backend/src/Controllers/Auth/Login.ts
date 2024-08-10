import type { Request, Response } from "express"
import { sendResponse } from "../../Lib/Response";

const Login = (req: Request, res: Response) => {
    return sendResponse({
        res,
        data: {
            message: 'Hello World'
        },
        status: 200,
    });

};


export default Login;