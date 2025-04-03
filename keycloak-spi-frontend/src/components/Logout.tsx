import React from "react";

const Logout = () => {
    // Call the Keycloak logout endpoint to invalidate the user's session
    const logoutUrl = new URL("http://localhost:8080/realms/test/protocol/openid-connect/logout");
    logoutUrl.searchParams.append("redirect_uri", "http://localhost:5173/");

    // Redirect the user to the logout endpoint
    window.location.href = logoutUrl.toString();

    return <div>Logging out...</div>;
};

export default Logout;