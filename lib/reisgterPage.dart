import 'package:flutter/material.dart';
import 'package:flutter_assignment_login_regsiter_using_sqllite/loginPage.dart';
import 'package:flutter_assignment_login_regsiter_using_sqllite/sqlConnectionPoint.dart';

void main(){
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String? uNameSQL;
  String? emailIdSQL;
  String? passwordSQL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Form(
         key: formKey,
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "User Name",
                labelText: "User Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              validator: (uname){
                uNameSQL=uname;
                if((uname!.isEmpty)){
                  return "username shouldn't empty";
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
                hintText: "Email",
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            validator: (email){
              emailIdSQL=email;
              if((email!.isEmpty) || (!email!.contains('@')) || (!email!.contains('.'))){
                return "email is not valid";
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
                if((password!.isEmpty) || (password.length<6) || (password.length>8)){
                  return "Password should be between 6 and 8 characters";
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
                     createAccount(uNameSQL,emailIdSQL,passwordSQL);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Data")));
                  }
                }, child: Text("Register")),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
                }, child: Text("Already a member?Sign In")),
              )
            ],
          ),

        ],
      )),
    );
  }

  Future<void> createAccount(String? uNameSQL, String? emailIdSQL, String? passwordSQL) async{
    await SQL_Operations.createAccountSQL(uNameSQL,emailIdSQL,passwordSQL);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
  }


}
