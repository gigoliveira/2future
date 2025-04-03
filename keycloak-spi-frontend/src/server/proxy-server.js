const login = async () => {
    try {
        const response = await fetch('/api/auth-proxy', { // Your backend endpoint
            method: 'POST',
            headers: {
                'X-Konneqt-Token': CONFIG.TOKEN,
                'Content-Type': 'application/json'
            },
            body: new URLSearchParams({
                client_id: 'konneqt-client',
                grant_type: 'konneqt_token',
            }),
        });

        const result = await response.json();
        if (result.redirectUrl) {
            window.location.href = result.redirectUrl;
        }
    } catch (error) {
        console.error('Login error:', error);
    }
};