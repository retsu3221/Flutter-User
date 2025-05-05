import 'hewan.dart';
import 'lari.dart';

class Kuda extends Hewan with Lari {
	String jenis;

	Kuda({required this.jenis}) : super(nama: "Kuda", warna: "Cokelat", berat: 10);
}
