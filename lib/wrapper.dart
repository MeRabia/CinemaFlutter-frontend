import 'package:flutter/material.dart';

//import 'package:flutter_mobile_app/authenticate/authenticate.dart';
import 'package:flutter_mobile_app/home.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    // return home or Authenticate
    //return Authenticate();
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
