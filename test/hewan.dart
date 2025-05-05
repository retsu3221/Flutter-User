abstract class Hewan {
	String? nama;
	String? warna;
	int? _berat;

	Hewan({this.nama, this.warna, required int berat}) {
		_berat = berat;
	}

	get berat => _berat;

	set berat(newBerat) {
		_berat = newBerat;
	}
}
