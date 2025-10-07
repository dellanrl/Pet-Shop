class Layanan {
  String nama;
  String deskripsi;
  double harga;
  String gambar;

  Layanan({
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
  });

 
  String get getNama => nama;
  String get getDeskripsi => deskripsi;
  double get getHarga => harga;
  String get getGambar => gambar;

  
  set setNama(String value) => nama = value;
  set setDeskripsi(String value) => deskripsi = value;
  set setHarga(double value) => harga = value;
  set setGambar(String value) => gambar = value;
}
