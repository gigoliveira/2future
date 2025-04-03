import { useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";

const Callback = () => {
    const navigate = useNavigate();
    const hasRun = useRef(false); // ✅ Prevent duplicate execution

    useEffect(() => {
        if (hasRun.current) return; // ✅ Stop second call
        hasRun.current = true; // ✅ Mark execution

        const params = new URLSearchParams(window.location.search);
        const code = params.get("code");

        if (code) {
            exchangeCodeForToken(code)
                .then(() => navigate("/profile"))
                .catch(() => navigate("/login"));
        } else {
            navigate("/login");
        }
    }, []);

    const exchangeCodeForToken = async (code: string) => {
        try {
            const response = await fetch("/keycloak/realms/test/protocol/openid-connect/token", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: new URLSearchParams({
                    client_id: "konneqt-client",
                    grant_type: "authorization_code",
                    code,
                    redirect_uri: "http://localhost:5173/callback",
                }),
            });

            const data = await response.json();
            if (data.access_token) {
                localStorage.setItem("access_token", data.access_token);
            } else {
                throw new Error("Failed to retrieve access token");
            }
        } catch (error) {
            console.error("Token exchange error:", error);
        }
    };

    return <div>Processing authentication...</div>;
};

export default Callback;
