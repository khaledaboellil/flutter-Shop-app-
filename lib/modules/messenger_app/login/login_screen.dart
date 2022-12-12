
import 'package:flutter/material.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

class login_screen extends StatefulWidget {
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey =GlobalKey<FormState>();
  bool visib = true ;
  IconData passwordicon = Icons.remove_red_eye ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey ,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login" ,
                      style: TextStyle(
                        fontSize: 40.0 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    defaultTextForm(controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value){
                        if(value!.isEmpty)
                        {
                          return("Email must be not empty ") ;
                        }
                        return null ;
                        },
                        label: "Email Adress",
                        prefix: Icons.email) ,
                    SizedBox(
                      height: 20.0,
                    ) ,
                    defaultTextForm(controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value){
                        if (value!.isEmpty)
                          {
                            return("password is too short ") ;
                          }
                        return null ;
                        }, label: "password",
                      prefix: Icons.lock,
                      isPassword: visib,
                      suffix: visib ? Icons.visibility:Icons.visibility_off,
                      visblepass: (){
                      setState(() {
                          visib = !visib ;
                      });
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ) ,
                    defaultButton(
                      function: (){
                        if(formkey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                        },text: "LOGIN" ,


                    ),
                    SizedBox(
                      height: 15.0,
                    ) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don\'t have an account "),


                      ],
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
