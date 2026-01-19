import 'package:flutter/material.dart';
import 'package:flutter_sudoku/widgets/game_over.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 16, horizontal: 48),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How To PLAY",
                  style: TextStyle(
                    fontFamily: "Cartoon",
                    fontSize: 24,
                    color: Colors.black54
                  ),
                ),
                SizedBox(height: 28,),
                Text(
                  '''
1. Isi papan 9×9 dengan angka 1 sampai 9.

2. Setiap angka hanya boleh muncul 1 kali di setiap baris.

3. Setiap angka hanya boleh muncul 1 kali di setiap kolom.

4. Setiap angka hanya boleh muncul 1 kali di setiap kotak 3×3.

5. Gunakan angka yang sudah ada sebagai petunjuk.

6. Gunakan logika, bukan tebakan.

7. Selesaikan semua kotak tanpa melanggar aturan untuk menang.
''',
                  style: TextStyle(
                    fontFamily: "Cartoon",
                    color: Colors.black54
                  ),
                ),
                SizedBox(height: 28,),
                GoToHome()
              ],
            ),
          ),
        )
      ),
    );
  }
}