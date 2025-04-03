import React from "react";

interface User {
    email?: string;
}

const Profile = () => {
    const user: User = JSON.parse(localStorage.getItem("user") || "{}");
    return (
        <div className="p-4">
            <h1 className="text-2xl">Profile</h1>
            <p>Email: {user?.email || "Not Available"}</p>
        </div>
    );
};

export default Profile;
