import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import CONFIG from "../config/config";

const Login: React.FC = () => {
  const navigate = useNavigate();
  const [error, setError] = useState<string | null>(null);

  const login = () => {
    // Construct the Keycloak authorization URL
    const authUrl = new URL('http://localhost:8080/realms/test/protocol/openid-connect/auth');
    
    // Add required OAuth2 parameters
    authUrl.searchParams.append('client_id', 'konneqt-client');
    authUrl.searchParams.append('redirect_uri', 'http://localhost:5173/callback');
    authUrl.searchParams.append('response_type', 'code');
    authUrl.searchParams.append('scope', 'openid');
    
    // Add your custom token as a query parameter
    authUrl.searchParams.append('konneqt_token', CONFIG.TOKEN);
    
    // Redirect to Keycloak
    window.location.href = authUrl.toString();
  };
  

  return (
    <div className="flex items-center justify-center h-screen">
      <div className="text-center">
        <h1>Login</h1>
        {error && <p className="text-red-500">{error}</p>}
        <button
          onClick={login}
          className="px-4 py-2 bg-blue-500 text-white rounded-lg mt-4"
        >
          Login
        </button>
      </div>
    </div>
  );
};

export default Login;
