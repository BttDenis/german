import { Router } from "express";
import { generateCardParts } from "../services/openai";
import { pool } from "../db";

const router = Router();

router.post("/", async (req, res) => {
  const { german_word } = req.body;
  const parts = await generateCardParts(german_word);
  const { rows } = await pool.query(
    `INSERT INTO cards (german_word, english_translation, usage_example, image_base64, audio_base64)
     VALUES ($1,$2,$3,$4,$5) RETURNING *`,
    [german_word, parts.translation, parts.usage, parts.imageBase64, parts.audioBase64]
  );
  res.json(rows[0]);
});

router.get("/", async (_req, res) => {
  const { rows } = await pool.query("SELECT * FROM cards ORDER BY created_at DESC");
  res.json(rows);
});

export default router;
