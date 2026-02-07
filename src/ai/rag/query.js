import { ChromaClient } from "chromadb";

const client = new ChromaClient();
const collection = client.collection("knowledge");

export const runRAGQuery = async (question, subject) => {
  const results = await collection.query({
    queryTexts: [question],
    nResults: 3,
    where: subject ? { subject } : {}
  });

  // Flatten documents
  return results.results[0].documents || [];
};
