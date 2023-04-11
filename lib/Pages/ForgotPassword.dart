// ignore_for_file: file_names, unused_import, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depoware/Pages/ForgotPassword.dart';
import 'package:depoware/Pages/HomePage.dart';
import 'package:depoware/Pages/LoginScreen.dart';
import 'package:depoware/Pages/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets.dart';
import '../colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:depoware/firebase_options.dart';

void main() async {
  runApp(const ForgotPassword());
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

TextEditingController _emailController = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 0, 0),
                child: Text('Zaboravili ste lozinku?',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Lottie.network(
                height: 300,
                width: 300,
                'https://assets6.lottiefiles.com/packages/lf20_dneo0c5x.json'),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Unesite e-mail računa kojem ste zaboravili lozinku\ni mi ćemo Vam poslati e-mail za reset lozinke',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: Text(
                  'E-mail',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: TextFormField(
                controller: _emailController,
                style: GoogleFonts.archivo(
                  fontSize: 13,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepOrangeAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'E-mail',
                  hintStyle: GoogleFonts.archivo(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: SizedBox(
                height: 40,
                width: 130,
                child: GestureDetector(
                  onTap: resetPassword,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: () {
                      resetPassword();
                    },
                    child: Text(
                      'Pošalji e-mail',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    'Nazad na prijavu',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        Fluttertoast.showToast(msg: 'Link za reset lozinke je poslat.');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
          (route) => false,
        );
      } catch (e) {
        Fluttertoast.showToast(msg: 'Greška prilikom slanja linka.');
      }
    } else {
      Fluttertoast.showToast(msg: 'Molimo potvrdite email adresu!.');
    }
  }
}
