# SignBridge AI
Real-Time Sign Language to Text and Voice Communication using Computer Vision and Deep Learning.

## What it does
1. Opens your webcam in the browser (video never leaves your computer).
2. **MediaPipe Hand Landmarker** (computer vision) finds 21 hand landmarks per frame.
3. Recognition: **built-in rules** for 11 common signs work immediately, and a **neural network (TensorFlow.js)** that you train on your own signs takes priority when it is confident.
4. A sign is added only after it is held steady for about 0.4 s (temporal filtering, so passing motions are ignored).
5. Words build a sentence; **Speech Synthesis** speaks it. Sentences can be saved to history with statistics.

Ideas reused from the SmartDrive project document: multi-step temporal analysis, a confidence indicator, privacy-first processing (only text/landmark numbers are stored, never video), session history with statistics, and an MVP-first scope.

## Step by step (Windows 11)

**Step 1 - Install the tools (once).** Node.js 20 or newer (https://nodejs.org), Google Chrome or Edge, and VS Code (optional).

**Step 2 - Unzip** `signbridge-ai.zip`, so you have a folder with `backend`, `frontend` and `README.md`.

**Step 3 - Open PowerShell inside that folder** (in VS Code: Terminal > New Terminal, after File > Open Folder).

**Step 4 - Start everything with one command:**
```powershell
Start-Process cmd -ArgumentList '/k "cd backend && npm install && npm start"' ; Start-Process cmd -ArgumentList '/k "cd frontend && npm install --legacy-peer-deps && npm run dev"'
```
Two command windows open. Wait until the backend prints `SignBridge API running on http://localhost:5000` and the frontend prints `Local: http://localhost:5173`. The first install takes a few minutes.

**Step 5 - Open http://localhost:5173** in Chrome or Edge and click **Allow** when asked for camera access. An internet connection is needed the first time because the hand-tracking model loads from a CDN.

**Step 6 - Translate.** Go to *Live translator*, show your whole hand to the camera and make a sign (table below). Hold it until the amber bar fills; the word is added and spoken. Lower your hand or change signs to repeat a word. Use Speak, Undo word, Clear, Save.

**Step 7 - Log in (optional).** Demo account: `demo@signbridge.ai` / `password123`, or create your own. Logging in enables Save and the *History* page with stats.

**Step 8 - Train your own signs.** Go to *Train signs*: type a word, press Record 60 and hold the sign while moving your hand slightly. Record at least 2 signs, press **Train model** (about 10-30 seconds). The *Live translator* then uses your model.

Run manually instead (two terminals): `cd backend; npm install; npm start` and `cd frontend; npm install --legacy-peer-deps; npm run dev`.

## Built-in signs
Hello (open palm) - Yes (fist) - Good (thumb up) - I (index up) - Peace (index+middle) - Water (index+middle+ring) - Stop (four fingers, thumb tucked) - Call me (thumb+little) - I love you (thumb+index+little) - Rock (index+little) - Okay (thumb-index circle, others up).

## Project structure
```
backend/   Express API: auth (JWT), translations, stats, gesture-dataset sync. JSON file storage in backend/data, no database install.
frontend/  React + Vite + Tailwind. lib/classifier.js = recognition engine, components/HandCam.jsx = camera + MediaPipe.
```
API: `POST /api/auth/register|login`, `GET|POST /api/translations`, `DELETE /api/translations/:id`, `GET /api/stats`, `GET|PUT /api/gestures`, `GET /health`.

## Troubleshooting
- **Camera error:** allow camera access in the browser address bar; close other apps using the camera.
- **"Loading hand model" never ends:** check your internet connection (CDN download) and reload.
- **Port in use:** change `PORT` in `backend/.env` and set `VITE_API=http://localhost:<port>/api` in a `frontend/.env` file.
- **npm peer-dependency errors:** keep the `--legacy-peer-deps` flag.
- **Wrong word detected:** use good light, keep the palm facing the camera, or train your own sample of that sign.

## Limitations and future scope
Recognizes single-hand static signs, not full sentence grammar. Fingerspelling alphabets, two-hand and moving signs (needs sequence models such as LSTM), multiple languages and mobile support are natural next steps. This is a prototype, not a certified accessibility product.
