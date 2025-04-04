import React, { useState } from "react";
import { Authenticator } from "../auth/Authenticator";

const Login = () => {
    const [email, setEmail] = useState("");
    const authenticator = new Authenticator();

    const handleLogin = () => {
        const authUrl = authenticator.getAuthUrl(email);
        window.location.href = authUrl;
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
