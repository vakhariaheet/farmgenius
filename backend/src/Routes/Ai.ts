import express from "express"
import TranslateReport from "@/Controllers/AI/TranslateReport";
import multer from "multer";
import CropDailyReport from "@/Controllers/AI/DailyReport";
const router = express.Router();

const upload = multer({ dest: 'uploads/' });

router.post('/report',upload.single('report'), TranslateReport);
router.post('/daily-report',upload.array('images', 10), CropDailyReport);


export default router;