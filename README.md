# JSONPlaceholder Explorer

Aplikasi Flutter web untuk menjelajahi posts, comments, albums, photos, todos,
dan users dari [JSONPlaceholder](https://jsonplaceholder.typicode.com/).

## Menjalankan lokal

```bash
flutter pub get
flutter run -d chrome
```

## Deploy ke Vercel

Impor repository ini di Vercel dan biarkan konfigurasi proyek menggunakan
`vercel.json`. Build script akan menyiapkan Flutter stable di environment Vercel
jika belum tersedia, lalu membuat situs statis di `build/web`.

Untuk build lokal yang setara:

```bash
flutter build web --release
```
