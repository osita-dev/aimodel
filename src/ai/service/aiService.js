import { Llama } from "node-llama-cpp";
import { buildPrompt } from "./promptBuilder.js";
import path from "path";

// Path to tinyllama
const MODEL_PATH = path.resolve("src/ai/model/tinyllama.gguf");

const llama = new Llama({
  model: MODEL_PATH,
  n_ctx: 512,
  n_threads: 4
});

export const generateResponse = async (question, context) => {
  const prompt = buildPrompt(question, context);

  const response = await llama.complete({
    prompt,
    max_tokens: 200
  });

  return response.text;
};
