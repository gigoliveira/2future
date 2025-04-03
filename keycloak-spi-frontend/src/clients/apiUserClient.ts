import axios from 'axios';

const apiUserClient = axios.create({
    baseURL: 'http://localhost:8081/api',
    headers: {
        Authorization: `bearer ${localStorage.getItem('access_token')}`,
    },
});

export default apiUserClient;