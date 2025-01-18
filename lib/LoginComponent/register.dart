import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/AppConstants/AndroidEmulatorApiEndpoints.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  Future<void> _register(BuildContext context, String registerEmail,
      String registerPassword, String registerConfirmPassword) async {
    const registerAPIEndpoint = registerCustomerAndroidEmulatorApiEndpoint;

    final requestData = {
      "id": "",
      "cnp": "",
      "nume": "",
      "prenume": "",
      "email": registerEmail,
      "dataNasterii": "",
      "parola": registerPassword,
      "joinedSinceDate": "",
      "tara": "",
      "oras": "",
      "favProduse": [],
      "produseCumparate": []
    };

    if (registerPassword == registerConfirmPassword) {
      try {
        final response = await http.post(Uri.parse(registerAPIEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestData));

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Account created successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              textColor: Colors.white,
              fontSize: 16.0);

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          Fluttertoast.showToast(
              msg: "Error! Account could not be created!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Color.fromARGB(255, 255, 0, 0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (error) {
        print("Error: $error");
      }
    } else {
      Fluttertoast.showToast(
          msg: "Password is not matching!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

//UI
  @override
  Widget build(BuildContext context) {
    TextEditingController registerEmailController = TextEditingController();
    TextEditingController registerPasswordController = TextEditingController();
    TextEditingController registerConfirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.pink.shade600, Colors.white])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "N O T I N O",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.normal),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 1,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: registerEmailController,
                                    decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    obscureText: true,
                                    controller: registerPasswordController,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    obscureText: true,
                                    controller:
                                        registerConfirmPasswordController,
                                    decoration: const InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: const Text(
                            "Use a secure password for your account",
                            style: TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () => _register(
                                context,
                                registerEmailController.text,
                                registerPasswordController.text,
                                registerConfirmPasswordController.text),
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 239, 152, 181),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: const Center(
                              child: Text(
                                "Login now",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 239, 152, 181),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: const Text(
                            "App by: Vasilian Mihaela, IM, IE, AN II, MASTER",
                            style: TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
