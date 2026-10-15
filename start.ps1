# Run from the signbridge-ai folder:  .\start.ps1
Start-Process cmd -ArgumentList '/k "cd backend && npm install && npm start"' ; Start-Process cmd -ArgumentList '/k "cd frontend && npm install --legacy-peer-deps && npm run dev"'
