import { Routes, Route, useNavigate } from "react-router-dom";
import Callback from "./Callback";
import Profile from "./components/Profile";
import { Authenticator } from "./auth/Authenticator";
import React from "react";

const authenticator = new Authenticator(); // ✅ Move outside to avoid re-instantiation

const Login = () => {
  const navigate = useNavigate();
  const [email, setEmail] = React.useState("");

  const handleLogin = () => {
    const authUrl = authenticator.getAuthUrl(email);
    window.location.href = authUrl;
  };

  return (
    <div>
      <h1>Login</h1>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      <button onClick={() => handleLogin()}>Login</button>
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
