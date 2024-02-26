import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preference/model/user_model.dart';
import 'package:shared_preference/service/logger_service.dart';
import 'package:shared_preference/service/prefs_service.dart';

import '../service/secure_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String matn = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey,
              height: 100,
              width: double.infinity,
              child: Text(matn),
            ),

            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.perm_identity, color: Colors.grey,size: 25),
                  hintText: 'email',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: emailController,
              ),
            ),

            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.blue),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_open_outlined,size: 22),
                  prefixIconColor: Colors.blue,
                  hintText: 'password',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: passwordController,
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: Colors.yellowAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      String email = emailController.text;
                      String password = passwordController.text;
                      var user = User(email, password);
                      PrefService.storeUser(user);
                    },
                    child: const Text('Save'),
                  ),
                  MaterialButton(
                    color: Colors.orangeAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      PrefService.loadUser().then((user) {
                        if (user == null) {
                          matn = 'null';
                          LoggerService.w('null');
                        } else {
                          matn = user.toJson().toString();
                          LoggerService.w(user.toJson().toString());
                        }
                        setState(() {});
                      }
                      );
                    },
                    child: const Text('Load'),
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      PrefService.removeUser();
                    },
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: Colors.yellowAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      String email = emailController.text;
                      String password = passwordController.text;
                      var user = User( email, password);
                      SecureService.storeApiKeyUser(user);
                    },
                    child: const Text('Secure \n save'),
                  ),
                  MaterialButton(
                    color: Colors.orangeAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      SecureService.loadApiKeyUser().then((user) {
                        if (user == null) {
                          matn = 'null';
                          LoggerService.w('null');
                        } else {
                          matn = user.toJson().toString();
                          LoggerService.w(user.toJson().toString());
                        }
                        setState(() {});
                      }
                      );
                    },
                    child: const Text('Secure \n load'),
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    height:100 ,
                    minWidth: 100,
                    onPressed: (){
                      SecureService.removeApiKeyUser();
                    },
                    child: const Text('Secure \n remove'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
