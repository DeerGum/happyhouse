import { apiInstance } from './index.js';

const api = apiInstance();

async function login(user, success, fail) {
  await api.post(`/user/login`, JSON.stringify(user)).then(success).catch(fail);
}

async function registerUser(user, success, fail) {
  await api.post(`/user`, JSON.stringify(user)).then(success).catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers['access-token'] = sessionStorage.getItem('access-token');
  await api.get(`/user/${userid}`).then(success).catch(fail);
}

async function deleteUser(data, success, fail) {
  await api.delete(`/user`, { data: data }).then(success).catch(fail);
}

async function modifyUser(user, success, fail) {
  await api.put(`/user`, JSON.stringify(user)).then(success).catch(fail);
}

function checkId(userid, success, fail) {
  api.get(`/user/idcheck/${userid}`).then(success).catch(fail);
}

async function getUserList(success, fail) {
  await api.get(`/admin/user`).then(success).catch(fail);
}

export { login, registerUser, findById, deleteUser, modifyUser, checkId, getUserList };
