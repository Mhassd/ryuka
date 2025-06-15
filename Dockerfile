# Base image: nodejs LTS (stabil dan aman)
FROM node:lts

# Set folder kerja di dalam container
WORKDIR /app

# Install dependency penting buat fitur bot (media convert, webp, dsb)
RUN apt-get update && apt-get install -y \
  ffmpeg \
  imagemagick \
  webp \
  && rm -rf /var/lib/apt/lists/*

# Salin file penting untuk install dependencies duluan
COPY package*.json ./

# Install semua dependency dari package.json
RUN npm install

# Salin semua isi folder project ke dalam container
COPY . .

# Jika bot pakai port tertentu (misalnya Express), bisa expose
EXPOSE 5000

# Jalankan file utama bot sesuai script di package.json
CMD ["npm", "start"]
