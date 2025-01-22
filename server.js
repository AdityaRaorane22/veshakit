const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const bcrypt = require("bcrypt");

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const dbURI = "mongodb://localhost:27017/parkio";

mongoose
  .connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Connected to MongoDB successfully!");
  })
  .catch((err) => {
    console.error("Error connecting to MongoDB:", err.message);
  });

// User Schema
const userSchema = new mongoose.Schema({
  name: String,
  gender: String,
  dob: Date,
  mobile: String,
  address: String,
  email: String,
  username: String,
  password: String,
});

const User = mongoose.model("User", userSchema);

// API to handle signup
app.post("/signup", async (req, res) => {
  try {
    const { name, gender, dob, mobile, address, email, username, password } = req.body;

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new user
    const newUser = new User({
      name,
      gender,
      dob,
      mobile,
      address,
      email,
      username,
      password: hashedPassword,
    });

    // Save to database
    await newUser.save();
    res.status(201).json({ message: "User registered successfully!" });
  } catch (error) {
    console.error("Error during user registration:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

// API to handle login
app.post("/login", async (req, res) => {
    try {
      const { username, password } = req.body;
  
      // Find user in the database
      const user = await User.findOne({ username });
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
  
      // Compare passwords
      const isPasswordValid = await bcrypt.compare(password, user.password);
      if (!isPasswordValid) {
        return res.status(401).json({ message: "Invalid credentials" });
      }
  
      // Login successful
      res.status(200).json({ message: "Login successful", user });
    } catch (error) {
      console.error("Error during login:", error);
      res.status(500).json({ message: "Internal Server Error" });
    }
  });

  // API to fetch user details by username
app.get("/user/:username", async (req, res) => {
    try {
      const { username } = req.params;
  
      // Find user in the database
      const user = await User.findOne({ username });
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
  
      // Return user details (excluding password)
      const { password, ...userDetails } = user.toObject();
      res.status(200).json(userDetails);
    } catch (error) {
      console.error("Error fetching user details:", error);
      res.status(500).json({ message: "Internal Server Error" });
    }
  });
  

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server is running on ${PORT}`);
});
