# Course Explorer v2 → Course Data Manager

Nama : I Kadek Santa Buana Gotama
NIM  : 2415051019

## Endpoint REST API (Pertemuan 7)

Base URL: `https://course-api-pearl.vercel.app`

| Method | Path | Fungsi | Status sukses |
|---|---|---|---|
| GET | `/courses` | Ambil semua course | 200 |
| GET | `/courses?status=active` | Filter berdasarkan status | 200 |
| GET | `/courses/{id}` | Ambil satu course | 200 |
| POST | `/courses` | Tambah course | 201 |
| PUT | `/courses/{id}` | Ganti seluruh data course | 200 |
| PATCH | `/courses/{id}` | Ubah sebagian field | 200 |
| DELETE | `/courses/{id}` | Hapus course | 204 |

Bentuk resource JSON:

```json
{
  "id": 1,
  "code": "MOB01",
  "title": "Git & GitHub",
  "credits": 2,
  "status": "active"
}