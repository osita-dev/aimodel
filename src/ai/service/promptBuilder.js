export const buildPrompt = (question, context) => {
  let basePrompt = "You are a helpful tutor. Answer questions clearly.\n";
  if (context) {
    basePrompt += `Context:\n${context.join("\n")}\n`;
  }
  basePrompt += `Question: ${question}\nAnswer:`;
  return basePrompt;
};
