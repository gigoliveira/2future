import { Routes, Route, useNavigate } from "react-router-dom";
import Callback from "./Callback"; // Make sure Callback.tsx exists
import Profile from "./components/Profile"; // Make sure Callback.tsx exists
import { Authenticator } from "./auth/authenticator";

import CONFIG from "./config/config";
import React from "react";

const Login = () => {
  const navigate = useNavigate();

  const [email, setEmail] = React.useState("");
    const authenticator = new Authenticator();

  const handleLogin = () => {
    const authUrl = authenticator.getAuthUrl(email);
    window.location.href = authUrl;
  };

  return (
    <div>
      <h1>Welcome</h1>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      <button onClick={() => handleLogin ()}>Login</button>
    </div>
  );
};

const App = () => {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/callback" element={<Callback />} />
      <Route path="/profile" element={<Profile />} />

    </Routes>
  );
};

export default App;

