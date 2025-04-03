class Authenticator {
    private clientId = "konneqt-client";
    private redirectUri = "http://localhost:5173/callback";
    private responseType = "code";
    private scope = "openid";
    private authUrl = new URL("http://localhost:8080/realms/test/protocol/openid-connect/auth");

    public getAuthUrl(email: string): string {
        this.authUrl.searchParams.append("client_id", this.clientId);
        this.authUrl.searchParams.append("redirect_uri", this.redirectUri);
        this.authUrl.searchParams.append("response_type", this.responseType);
        this.authUrl.searchParams.append("scope", this.scope);
        this.authUrl.searchParams.append("konneqt_token", email);

        return this.authUrl.toString();
    }
}

export { Authenticator };