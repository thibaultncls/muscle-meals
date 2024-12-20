# Flutter & Node.js Project with MongoDB

This project is a mobile application developed with **Flutter** for the frontend and a backend built with **Node.js** and **MongoDB** for data management for sharing healthy recipies with community.

## Prerequisites

Make sure you have the following tools installed on your machine before getting started:

- **Flutter SDK**: [Official Documentation](https://flutter.dev/docs/get-started/install)
- **Node.js** (version 14 or higher): [Download Node.js](https://nodejs.org/)
- **MongoDB**: [Download MongoDB](https://www.mongodb.com/try/download/community)

---

## Installation



### 1. Flutter Frontend Installation

1. Clone the repository and navigate to the folder.
```
# Clonez le dépôt
git clone https://github.com/thibaultncls/muscle-meals.git
cd muscle-meals/frontend
```

2. Install the Flutter dependencies.
```
flutter pub get
```

3. Verify that Flutter is properly installed and configured.
```
flutter doctor
```

4. Run the Flutter application.
```
flutter run
```

---

### 2. Node.js Backend Installation

1. Navigate to the `backend` folder.
```
cd ../backend
```

2. Install the backend dependencies.
```
npm install
```

3. Configure the environment variables:
   - An **`.env.example`** file is provided. Copy it to create your own `.env` file.
   - Detailed explanations for each environment variable are included as comments in the **`.env.example`** file.

4. Start the backend server.
```
npm run dev
```

---

## Project Structure
```
flutter-nodejs-mongodb/
├── frontend/      # Application mobile Flutter
├── backend/       # API backend avec Node.js
├── README.md      # Documentation
```


---

## Key Points

- **Environment Variables**:
  - Ensure the `.env` file is properly configured based on `.env.example`.
  - Refer to the comments in **`.env.example`** for detailed explanations of each field.

- **MongoDB**:
  - Make sure your MongoDB instance is running, and the connection details (URL, database name, etc.) are correctly configured in the `.env` file.

---

## Technologies Used

- **Frontend**:
  - Flutter
  - Dart

- **Backend**:
  - Node.js
  - Express.js
  - MongoDB

---

## Author

Developed by **Thibault Nicolas** and the team. 💻🚀
