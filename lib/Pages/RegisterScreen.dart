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
  runApp(const Register());
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

bool _prikaziText = true;
bool _prikaziText1 = true;
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _passwordConfirmController = TextEditingController();

class _RegisterState extends State<Register> {
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
                child: Text('Registrujte se',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Lottie.network(
                  height: 200,
                  width: 200,
                  repeat: true,
                  'https://assets8.lottiefiles.com/packages/lf20_zw0djhar.json'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Registrujte se koristeći e-mail i lozinku',
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

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text(
                  'Potvrdite lozinku',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: TextFormField(
                controller: _passwordConfirmController,
                style: GoogleFonts.archivo(
                  fontSize: 13,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_reset,
                      color: Colors.deepOrangeAccent),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _prikaziText1 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        _prikaziText1 = !_prikaziText1;
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
                obscureText: _prikaziText1,
              ),
            ),

            ///////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: SizedBox(
                height: 40,
                width: 130,
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
                    register();
                  },
                  child: Text(
                    'Registrujte se',
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
                      'Imate račun?',
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
                              builder: (context) => const Login()),
                        );
                      },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _passwordConfirmController.text.trim();

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: 'Lozinke se ne podudaraju');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Request email verification
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 3,
            msg: 'Email poslat na ${user.email}. Molimo potvrdite email!.');
      }

      _emailController.clear();
      _passwordController.clear();
      _passwordConfirmController.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email adresa već postoji');
      } else {
        Fluttertoast.showToast(msg: 'Greška prilikom registracije');
      }
    }
  }
}
