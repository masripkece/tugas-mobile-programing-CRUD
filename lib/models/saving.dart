class Saving {
  int? id;
  String bulan;
  int jumlah;

  Saving({this.id, required this.bulan, required this.jumlah});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bulan': bulan,
      'jumlah': jumlah,
    };
  }

  factory Saving.fromMap(Map<String, dynamic> map) {
    return Saving(
      id: map['id'],
      bulan: map['bulan'],
      jumlah: map['jumlah'],
    );
  }
}
