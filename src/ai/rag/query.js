import { ChromaClient } from "chromadb"; // make sure this matches your installed package

// Initialize client
const client = new ChromaClient();

// Get or create collection
const collection = await client.getOrCreateCollection({
  name: "knowledge"
});

// Example query function
export const queryKnowledge = async (queryText) => {
  const results = await collection.query({
    queryTexts: [queryText],
    nResults: 3
  });

  return results;
};
