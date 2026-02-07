import { ChromaClient } from "chromadb";
import fs from "fs";
import path from "path";

const client = new ChromaClient();

export const ingestKnowledge = async () => {
  // Create or get collection
  const collection = await client.getOrCreateCollection({
    name: "knowledge"
  });

  const basePath = path.resolve("knowledge");
  const subjects = fs.readdirSync(basePath);

  for (let subject of subjects) {
    const files = fs.readdirSync(path.join(basePath, subject));
    for (let file of files) {
      const content = fs.readFileSync(path.join(basePath, subject, file), "utf-8");
      await collection.add({
        ids: [`${subject}-${file}`],
        metadatas: [{ subject }],
        documents: [content]
      });
    }
  }

  console.log("Knowledge ingested into Chroma.");
};
