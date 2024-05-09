// details.js

const express = require("express");
const app = express();
const port = 3001;

const bookDetails = {
  title: "My Life Story",
  author: "F. Scott Fitzgerald",
  year: 1925,
  genre: "Fiction",
  summary: "The story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.",
};


app.get("/", (req, res) => {
  console.log('hello from details page')
  res.json(bookDetails);
});

app.listen(port, () => {
  console.log(`Details microservice is running on port ${port}`);
});
