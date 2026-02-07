import { ChromaClient } from "chromadb";

const client = new ChromaClient();

export const runRAGQuery = async (question, subject = null) => {
  const collection = await client.getOrCreateCollection({ name: "knowledge" });

  const results = await collection.query({
    queryTexts: [question],
    nResults: 3,
    ...(subject && { where: { subject } })
  });

  // Combine retrieved docs into a single context string
  const context = results.results[0].documents.join("\n");
  return context;
};
