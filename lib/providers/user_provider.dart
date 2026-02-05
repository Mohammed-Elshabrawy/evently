import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider  extends ChangeNotifier{
   MyUser? currentUser;
   void updateUser(MyUser user){
     currentUser = user;
     notifyListeners();

   }

}