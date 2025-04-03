import apiUserClient from '../clients/apiUserClient';

const getUserProfile = async () => {
    try {
    console.log('access_token', localStorage.getItem('access_token'));

        const response = await apiUserClient.get('/user/profile', {
            withCredentials: true
        });
        return response.data;
    } catch (error) {
        console.error(error);
        return null;
    }
};

export default getUserProfile;