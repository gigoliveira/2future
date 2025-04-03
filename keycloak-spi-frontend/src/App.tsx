import { Routes, Route, useNavigate } from "react-router-dom";
import Callback from "./Callback"; // Make sure Callback.tsx exists
import Profile from "./components/Profile"; // Make sure Callback.tsx exists

import CONFIG from "./config/config";
import React from "react";

const Login = () => {
  const navigate = useNavigate();

  const [email, setEmail] = React.useState("");

  const login = (email: string) => {
    // Construct the Keycloak authorization URL
    const authUrl = new URL("http://localhost:8080/realms/test/protocol/openid-connect/auth");
    
    // Add required OAuth2 parameters
    authUrl.searchParams.append("client_id", "konneqt-client");
    authUrl.searchParams.append("redirect_uri", "http://localhost:5173/callback");
    authUrl.searchParams.append("response_type", "code");
    authUrl.searchParams.append("scope", "openid");
    
    // Add custom token
    authUrl.searchParams.append("konneqt_token", `${email}`);
    
    // Redirect to Keycloak
    window.location.href = authUrl.toString();

    localStorage.setItem("access_token", "");

  };

  return (
    <div>
      <h1>Welcome</h1>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      <button onClick={() => login(email)}>Login</button>
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

