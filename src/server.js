import express from "express";
import cors from "cors";
import aiRoutes from "./ai/routes.js";

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/ai", aiRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`AI microservice running on port ${PORT}`));
