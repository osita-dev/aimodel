import { runRAGQuery } from "./rag/query.js";
import { generateResponse } from "./service/aiService.js";

export const handleQuery = async (req, res) => {
  try {
    const { question, subject } = req.body;
    if (!question) return res.status(400).json({ error: "No question provided" });

    // Run RAG search first
    const context = await runRAGQuery(question, subject);

    // Generate model response
    const answer = await generateResponse(question, context);

    res.json({ answer });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
};
