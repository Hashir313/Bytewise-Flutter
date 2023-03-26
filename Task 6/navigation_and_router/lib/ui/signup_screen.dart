import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup Screen',
                style: GoogleFonts.figtree(
                    fontSize: 30.0,
                    color: Colors.deepPurpleAccent.withOpacity(0.6),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.network(
                  'https://thumbs.dreamstime.com/b/personal-young-teacher-private-education-girl-intern-school-girl-learning-woman-tutor-preschool-children-personal-young-187996257.jpg'),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
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
                      hintText: 'Enter your Password',
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
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.deepPurpleAccent.withOpacity(0.6),
                      ),
                      hintText: 'Confirm your Password',
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
                        Navigator.pop(context);
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
                        'SignUp',
                        style: GoogleFonts.figtree(),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
