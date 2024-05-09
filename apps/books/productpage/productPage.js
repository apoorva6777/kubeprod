// productpage.js

const express = require("express");
const axios = require("axios");

const app = express();
const port = 3000;

app.get("/", async (req, res) => {
  try {
    console.log('hello from productpage')
    const detailsResponse = await axios.get("http://details-service:3001/");
    const detailsData = detailsResponse.data;

    const ratingsResponse = await axios.get("http://ratings-service:3002/");
    const ratingsData = ratingsResponse.data;

    const productPageData = {
      message: "Product Page",
      details: detailsData,
      ratings: ratingsData 
    };
    res.json(productPageData);
  } catch (error) {
    console.error("Error fetching data:", error);
    res.status(500).send("Internal Server Error");
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});


// const express = require("express");
// const axios = require("axios");

// const app = express();
// const port = 3000;

// // Route to return a simple greeting message
// app.get("/", (req, res) => {
//   res.send("Hello from Product Page");
// });

// // Route to handle product details and ratings
// app.get("/product", async (req, res) => {
//   try {
//     // const detailsResponse = await axios.get("http://details-service:3001/");
//     const detailsResponse = await axios.get("http://localhost:3001/");
//     const detailsData = detailsResponse.data;

//     const ratingsResponse = await axios.get("http://localhost:3002/");
//     const ratingsData = ratingsResponse.data;

//     const productPageData = {
//       message: "Product Page",
//       details: detailsData,
//       ratings: ratingsData 
//     };
//     res.json(productPageData);
//   } catch (error) {
//     console.error("Error fetching data:", error);
//     res.status(500).send("Internal Server Error");
//   }
// });

// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });
