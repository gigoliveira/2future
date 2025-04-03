import { useNavigate } from "react-router-dom";
import CONFIG from "./config/config";

const App = () => {
  const navigate = useNavigate();

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
    <div>
      <h1>Welcome</h1>
      <button onClick={login}>Login</button>
    </div>
  );
};

export default App;
