const app = require('./app');
const axios = require('axios');

// Agregar rutas de jokes
app.use('/api/jokes', require('./routes/jokes.routes'));

// Ruta pública para jokes (sin autenticación)
app.get('/api/public/joke/random', async (req, res) => {
  try {
    const response = await axios.get('https://v2.jokeapi.dev/joke/Any', { timeout: 5000 });
    res.json({
      success: true,
      data: response.data
    });
  } catch (error) {
    res.status(500).json({ 
      error: 'Failed to fetch joke',
      message: error.message 
    });
  }
});

module.exports = app;
