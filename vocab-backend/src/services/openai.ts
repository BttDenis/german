import OpenAI from "openai";
import dotenv from "dotenv";

dotenv.config();

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY! });

export async function generateCardParts(word: string) {
  const gpt = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: "You are a translator." },
      { role: "user", content: `Word: ${word}` },
    ],
  });
  const [translation, usage] = gpt.choices[0].message.content!.split("\n");

  const img = await openai.images.generate({
    model: "gpt-image-1",
    prompt: `Illustration of '${word}'`,
    size: "512x512",
  });

  const audio = await openai.audio.speech.create({
    model: "gpt-4o-mini-tts",
    voice: "alloy",
    input: word,
  });

  return {
    translation,
    usage,
    imageBase64: img.data[0].b64_json,
    audioBase64: audio.data[0].b64_json,
  };
}
