import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import App from "./App";
import Profile from "./components/Profile";
import Login from "./components/Login";
import Logout from "./components/Logout"; // 👈 Import the new Logout component

import Callback from "./Callback";

ReactDOM.createRoot(document.getElementById("root")!).render(
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/profile" element={<Profile />} />
        <Route path="/login" element={<Login />} />
        <Route path="/callback" element={<Callback />} />
        <Route path="/logout" element={<Logout />} />

      </Routes>
    </BrowserRouter>
);
