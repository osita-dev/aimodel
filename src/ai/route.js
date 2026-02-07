import express from "express";
import { handleQuery } from "./controller.js";

const router = express.Router();

// POST /api/ai/query
router.post("/query", handleQuery);

export default router;
