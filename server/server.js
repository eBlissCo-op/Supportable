const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from web directory
app.use(express.static(path.join(__dirname, '../web')));

// Example API endpoint
app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from Supportable server!' });
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
