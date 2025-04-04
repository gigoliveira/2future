// keycloak-spi-frontend/src/components/Profile.tsx
import React, { useEffect } from 'react';
import getUserProfile from '../services/userService';

interface User {
    email?: string;
    name?: string;
    preferredUsername?: string;
    givenName?: string;
    familyName?: string;
}

const Profile = () => {
    const [user, setUser] = React.useState<User>({} as User);

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
        <section className="d-flex flex-column align-items-center">
            <div className="col-md-3 bg-">
                <h1 className="pb-3">Profile</h1>
                <ul className="list-group list-group-flush">
                    <li className="list-group-item bg-dark text-light border-secondary">Email: {user?.email || "Not Available"}</li>
                    <li className="list-group-item bg-dark text-light border-secondary">Name: {user?.name || "Not Available"}</li>
                    <li className="list-group-item bg-dark text-light border-secondary">Preferred Username: {user?.preferredUsername || "Not Available"}</li>
                    <li className="list-group-item bg-dark text-light border-secondary">Given Name: {user?.givenName || "Not Available"}</li>
                    <li className="list-group-item bg-dark text-light border-secondary">Family Name: {user?.familyName || "Not Available"}</li>
                </ul>
            </div>
        </section>
    );
};

export default Profile;