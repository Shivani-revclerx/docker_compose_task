// console.log("Hi I am doing this task with Jenkins + Docker!");




// // this is just as index.json file

const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Docker!');
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
