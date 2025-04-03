import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      "/realms/test/protocol/openid-connect/token": {
        target: "http://localhost:8080",
        changeOrigin: true,
        secure: false,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Content-Type, X-Konneqt-Token",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        },
      },
      '/keycloak': {
          target: 'http://localhost:8080',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/keycloak/, ''),
      },
    },
  },
});