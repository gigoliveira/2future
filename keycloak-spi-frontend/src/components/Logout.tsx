import React from "react";

const Logout = () => {
    const logoutUrl = new URL("http://localhost:8080/realms/test/protocol/openid-connect/logout");
    logoutUrl.searchParams.append("redirect_uri", "http://localhost:5173/");

    window.location.href = logoutUrl.toString();

    return <div>Logging out...</div>;
};

export default Logout;