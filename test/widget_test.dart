import 'dart:math';

void main() {
	List<int> angka = [1,2,3,4,5];

	List<dynamic> hitung = [1,2,3,4,5];

	var angkaNew = angka.map((e)=> e*2).toList();

	Map<String?, dynamic> kendaraan = {
		"nama": "Sedan",
		"warna": "Putih"
	};
	
	print(angka[2]);
	print(hitung[0]);
	print("Nama kendaraan nya mobil ${kendaraan['nama']} dan warna nya ${kendaraan["warna"]}");
}
