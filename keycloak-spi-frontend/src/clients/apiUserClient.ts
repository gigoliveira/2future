import axios from 'axios';
import { getAuthHeader } from '../utils/authUtils';

const apiUserClient = axios.create({
    baseURL: 'http://localhost:8081/api',
    headers: getAuthHeader(),
  });

export default apiUserClient;