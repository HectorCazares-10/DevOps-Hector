const express = require('express');
const cors = require('cors');
const app = express();

const db = require('./queries');

const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ status: 'Backend running OK' });
});

/* Health check para ALB */
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

/* Rutas */
app.get('/users', db.getUsers);
app.get('/users/:id', db.getUserById);
app.post('/users', db.createUser);
app.put('/users/:id', db.updateUser);
app.delete('/users/:id', db.deleteUser);

/* IMPORTANTE */
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend listening on port ${PORT}`);
});




