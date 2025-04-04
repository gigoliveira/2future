export function getAuthHeader(): { Authorization: string } {
    const accessToken = localStorage.getItem('access_token');
    return { Authorization: `bearer ${accessToken}` };
  }