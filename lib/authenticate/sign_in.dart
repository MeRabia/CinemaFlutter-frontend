import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/auth.dart';

class SignIn extends StatefulWidget {
  
   final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();
  String error = '';

   // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[400],
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          elevation: 0.0,
          title: Text("Sign in to Cinema App"),
          actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),//toggle to registerView
          ),
        ],
  
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
         child: Form(
           key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                 decoration: InputDecoration(
                   icon: Icon(Icons.email),
                   hintText: 'Email',
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color:Colors.pink,width:3.0)
                   ),
                  ),
                 
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                   icon: Icon(Icons.lock),
                   hintText: 'password',
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color:Colors.pink,width:3.0)
                   ),
                  ),
                 validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  /* print(email);
                  print(password); */
                  if(_formKey.currentState.validate()){
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
              
              ),
               SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      )
    );
  }
}
