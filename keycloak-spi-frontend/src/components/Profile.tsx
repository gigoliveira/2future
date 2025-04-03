// keycloak-spi-frontend/src/components/Profile.tsx
import React, { useState, useEffect } from 'react';
import getUserProfile from '../services/userService';

interface User {
    email?: string;
    name?: string;
    preferredUsername?: string;
    givenName?: string;
    familyName?: string;
}

const Profile = () => {
    const [user, setUser] = useState<User>({});

    useEffect(() => {
        const fetchUserProfile = async () => {
            const userData = await getUserProfile();
            if (userData) {
                setUser(userData);
            }
        };
        fetchUserProfile();
    }, []);

    return (
        <div className="p-4">
            <h1 className="text-2xl">Profile</h1>
            <p>Email: {user?.email || "Not Available"}</p>
            <p>Name: {user?.name || "Not Available"}</p>
            <p>Preferred Username: {user?.preferredUsername || "Not Available"}</p>
            <p>Given Name: {user?.givenName || "Not Available"}</p>
            <p>Family Name: {user?.familyName || "Not Available"}</p>
        </div>
    );
};

export default Profile;