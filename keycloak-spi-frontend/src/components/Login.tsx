import React, { useState } from "react";

const Login = () => {
    const [email, setEmail] = useState("");

    const handleLogin = () => {
        const authUrl = new URL("http://localhost:8080/realms/test/protocol/openid-connect/auth");

        authUrl.searchParams.append("client_id", "konneqt-client");
        authUrl.searchParams.append("redirect_uri", "http://localhost:5173/callback");
        authUrl.searchParams.append("response_type", "code");
        authUrl.searchParams.append("scope", "openid");
        authUrl.searchParams.append("konneqt_token", email);

        window.location.href = authUrl.toString();
    };

    return (
        <div className="flex items-center justify-center h-screen">
            <div className="text-center">
                <h1 className="text-2xl font-bold">Login</h1>
                <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Enter your email"
                    className="border p-2 mt-4"
                />
                <button
                    onClick={handleLogin}
                    className="px-4 py-2 bg-blue-500 text-white rounded-lg mt-4"
                >
                    Login
                </button>
            </div>
        </div>
    );
};

export default Login;
