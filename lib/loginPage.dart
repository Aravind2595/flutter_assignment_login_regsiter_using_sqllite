import 'package:flutter/material.dart';
import 'package:flutter_assignment_login_regsiter_using_sqllite/homePage.dart';
import 'package:flutter_assignment_login_regsiter_using_sqllite/reisgterPage.dart';
import 'package:flutter_assignment_login_regsiter_using_sqllite/sqlConnectionPoint.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String? uNameSQL;
  String? emailIdSQL;
  String? passwordSQL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  validator: (email){
                    emailIdSQL=email;
                    if((email!.isEmpty)){
                      return "email is empty";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  validator: (password){
                    passwordSQL=password;
                    if((password!.isEmpty)){
                      return "Password is empty";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(onPressed: (){
                      final valid=formKey.currentState!.validate();
                      if(valid){
                        signInAccount(emailIdSQL,passwordSQL);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Data")));
                      }
                    }, child: Text("Sign In")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterPage()));
                    }, child: Text("Not a member?Register")),
                  )
                ],
              ),

            ],
          )),
    );
  }

  Future<void> signInAccount(String? emailIdSQL, String? passwordSQL) async{
    final List<Map<String, dynamic>> myAccount=await SQL_Operations.signInAccountSQL(emailIdSQL,passwordSQL);
    if(myAccount.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(uName: myAccount[0]['userName']!,)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credential")));
    }
  }
}
