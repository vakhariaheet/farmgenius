import express from "express"
import TranslateReport from "@/Controllers/AI/TranslateReport";
import multer from "multer";
const router = express.Router();

const upload = multer({ dest: 'uploads/' });

router.post('/report',upload.single('report'), TranslateReport);



export default router;