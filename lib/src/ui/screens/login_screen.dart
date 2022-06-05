import 'package:flutter/material.dart';
import 'package:pokedex_app/src/services/navigation_service.dart';
import 'package:pokedex_app/src/ui/screens/pokemons_screen.dart';
import 'package:pokedex_app/src/ui/widgets/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            const SizedBox(height: 100),
            const Image(
              image: AssetImage('assets/pokeball.png'),
              width: 150,
              height: 200,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Registro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: userCtrl,
                      style: const TextStyle(),
                      decoration: buildInputDecoration(
                        hint: 'Ingresar usuario',
                        label: 'Usuario',
                        icon: Icons.mail,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      text: 'Ingresar',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, 'pokemons_screen');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(5),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }
}
