// ignore_for_file: file_names, unused_import, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depoware/Pages/ForgotPassword.dart';
import 'package:depoware/Pages/HomePage.dart';
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
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool _prikaziText = true;
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class _LoginState extends State<Login> {
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
                child: Text('Dobrodošli, Prijavite se',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600)),
              ),
            ),
            Lottie.network(
                height: 300,
                width: 300,
                'https://assets10.lottiefiles.com/packages/lf20_XpVCMJTSQt.json'),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Prijavite se koristeći e-mail i lozinku',
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
            /////////////////////////////////////////////////////////

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text(
                  'Lozinka',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: TextFormField(
                controller: _passwordController,
                style: GoogleFonts.archivo(
                  fontSize: 13,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.lock, color: Colors.deepOrangeAccent),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _prikaziText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        _prikaziText = !_prikaziText;
                      });
                    },
                  ),
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
                  hintText: 'Lozinka',
                  hintStyle: GoogleFonts.archivo(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                obscureText: _prikaziText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  },
                  child: Text(
                    'Zaboravili ste lozinku?',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
            ),

            ///////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: SizedBox(
                height: 40,
                width: 120,
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
                    prijava();
                  },
                  child: Text(
                    'Prijavite se',
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

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Nemate račun?',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      child: Text(
                        'Napravite ga',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 7.3,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ili',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 7.3,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Prijavite se koristeći',
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepOrangeAccent),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidgets.socialButtonRect(
                      'Facebook', facebookColor, FontAwesomeIcons.facebook,
                      onTap: () {
                    Fluttertoast.showToast(msg: 'I am facebook');
                  }),
                  CustomWidgets.socialButtonRect(
                      'Google', googleColor, FontAwesomeIcons.google,
                      onTap: () {
                    Fluttertoast.showToast(msg: 'I am google');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> prijava() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Button pressed!');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _emailController.clear();
      _passwordController.clear();
      print('User logged in: ${userCredential.user!.uid}');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'Korisnik nije pronađen');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Kriva lozinka');
      } else {
        Fluttertoast.showToast(msg: 'Greška prilikom prijave');
      }
    } catch (e) {
      print(e);
    }
  }
}
