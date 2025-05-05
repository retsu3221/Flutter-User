import 'hewan.dart';
import 'renang.dart';

class Ikan extends Hewan with Renang {
	String jenis;

	Ikan({required this.jenis}) : super(nama: "Ikan", warna: "Silver", berat: 3);
}
