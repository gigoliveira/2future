import { useEffect } from "react";
import { useNavigate } from "react-router-dom";

const Callback = () => {
    const navigate = useNavigate();

    useEffect(() => {
        // Extract code from URL
        const params = new URLSearchParams(window.location.search);
        const code = params.get("code");

        if (code) {
            // Exchange code for token (you'll need to implement this)
            exchangeCodeForToken(code).then(() => {
                navigate("/profile");
            });
        } else {
            navigate("/login");
        }
    }, []);

    const exchangeCodeForToken = async (code: string) => {
        // Implement token exchange logic here
    };

    return <div>Processing authentication...</div>;
};

export default Callback;