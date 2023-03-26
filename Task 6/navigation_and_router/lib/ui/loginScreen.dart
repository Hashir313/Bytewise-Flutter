import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_and_router/ui/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Screen',
                style: GoogleFonts.figtree(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.6)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset('assets/flutterImage.png'),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter you Email',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.deepPurpleAccent.withOpacity(0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintStyle: GoogleFonts.figtree(color: Colors.deepPurple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent))),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter you Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.deepPurpleAccent.withOpacity(0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintStyle: GoogleFonts.figtree(color: Colors.deepPurple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.deepPurpleAccent))),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                  height: 40,
                  width: 270,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors
                              .deepPurpleAccent.shade200
                              .withOpacity(0.6)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                      child: Text(
                        'Login',
                        style: GoogleFonts.figtree(),
                      ))),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: GoogleFonts.figtree(),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Signup');
                      },
                      child: Text(
                        'Signup',
                        style: GoogleFonts.figtree(
                            color: Colors.deepPurpleAccent.withOpacity(0.6),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
