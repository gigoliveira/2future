import { Routes, Route } from "react-router-dom";
import Callback from "./Callback";
import Profile from "./components/Profile";
import { Authenticator } from "./auth/Authenticator";
import React from "react";

const authenticator = new Authenticator(); // Move outside to avoid re-instantiation

const Login = () => {
  const [email, setEmail] = React.useState("");

  const handleLogin = () => {
    const authUrl = authenticator.getAuthUrl(email);
    window.location.href = authUrl;
  };

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-4">
          <h1 className="text-center">Login</h1>
          <div className="mb-3">
            <label htmlFor="email" className="form-label">Email address</label>
            <input
              type="email"
              className="form-control"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>
          <div className="d-grid gap-2">
            <button className="btn btn-primary" onClick={handleLogin}>
              Login
            </button>
          </div>
        </div>
      </div>
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

