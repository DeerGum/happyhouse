import { apiInstance } from './index.js';

const api = apiInstance();

async function listArticle(param, success, fail) {
  await api.get(`/board`, { params: param }).then(success).catch(fail);
}

async function listArticleTotalCount(param, success, fail) {
  await api.get(`/board/count`, { params: param }).then(success).catch(fail);
}

async function writeArticle(article, success, fail) {
  await api.post(`/board`, JSON.stringify(article)).then(success).catch(fail);
}

async function getArticle(articleno, success, fail) {
  await api.get(`/board/${articleno}`).then(success).catch(fail);
}

async function modifyArticle(article, success, fail) {
  await api.put(`/board`, JSON.stringify(article)).then(success).catch(fail);
}

async function deleteArticle(articleno, success, fail) {
  await api.delete(`/board/${articleno}`).then(success).catch(fail);
}

async function registComment(comment, success, fail) {
  await api.post(`/board/comment`, JSON.stringify(comment)).then(success).catch(fail);
}

async function getComment(articleno, success, fail) {
  await api.get(`/board/comment/${articleno}`).then(success).catch(fail);
}

async function modifyComment(comment, success, fail) {
  await api.put(`/board/comment`, JSON.stringify(comment)).then(success).catch(fail);
}

async function deleteComment(data, success, fail) {
  await api.delete(`/board/comment`, { data: data }).then(success).catch(fail);
}

export {
  listArticle,
  listArticleTotalCount,
  writeArticle,
  getArticle,
  modifyArticle,
  deleteArticle,
  registComment,
  getComment,
  modifyComment,
  deleteComment,
};
