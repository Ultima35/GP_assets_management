import api from "./api";

/**
 * GET semua template paket peminjaman
 */
export async function getAllPaket() {
  const response = await api.get("/paket");
  return response.data.data;
}

/**
 * GET detail paket beserta daftar item & unit fisiknya
 */
export async function getPaketById(id) {
  const response = await api.get(`/paket/${id}`);
  return response.data.data;
}

/**
 * CREATE template paket baru (support multipart formData untuk upload foto)
 */
export async function createPaket(data, file = null) {
  const formData = new FormData();
  formData.append("nama_paket", data.nama_paket);
  if (data.deskripsi) formData.append("deskripsi", data.deskripsi);
  formData.append("items", JSON.stringify(data.items || []));

  if (file) {
    formData.append("gambar", file);
  }

  const response = await api.post("/paket", formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
  return response.data;
}

/**
 * UPDATE template paket
 */
export async function updatePaket(id, data, file = null) {
  const formData = new FormData();
  formData.append("nama_paket", data.nama_paket);
  formData.append("deskripsi", data.deskripsi || "");
  if (data.items) formData.append("items", JSON.stringify(data.items));

  if (file) {
    formData.append("gambar", file);
  }

  const response = await api.put(`/paket/${id}`, formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
  return response.data;
}

/**
 * DELETE template paket tunggal
 */
export async function deletePaket(id) {
  const response = await api.delete(`/paket/${id}`);
  return response.data;
}

/**
 * DELETE seluruh template paket (Super Admin only)
 */
export async function deleteAllPaket() {
  const response = await api.delete("/paket/bulk/delete-all");
  return response.data;
}
