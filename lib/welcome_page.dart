import 'package:flutter/material.dart';

import 'package:firebaseloginsignup/auth_controller.dart';

class WelcomePage extends StatelessWidget {
  String email;
   WelcomePage({
    Key? key,
    required this.email,
  }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
          body: Column(
        children: [
          Container(
           width: size.width,
           height: size.height*0.3,
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage(
               'img/signup.png'),
               fit: BoxFit.cover)
           ),
           child: Column(
             children: [
               SizedBox(height: size.height*0.15,),
               CircleAvatar(
                 backgroundColor: Colors.white70,
                 radius: 60,
                 backgroundImage: AssetImage(
                   'img/profile1.png'),
               ),
             ],
           ),
          ),
      
          SizedBox(height: 60,),
          
          Container(
            width: size.width,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Text('Welcome',
            style: TextStyle(fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500]),),
              
              Text(email,
            style: TextStyle(fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black54),),

              ],
              
            ),
          ),
          SizedBox(height: 200,)   ,    

            GestureDetector(
              onTap: () {
                AuthController.instance.logOut();
              } ,
              child: Container(
                       width: size.width*0.5,
                       height: size.height*0.08,
                       decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
               image: DecorationImage(image: AssetImage(
                 'img/loginbtn.png'),
                 fit: BoxFit.cover)
                       ),
                       child:     Center(
               child: Text('Sign out',
                   style: TextStyle(fontSize: 30,
                   fontWeight: FontWeight.bold,
                   color: Colors.white),),
                       ),
            
                      ),
            ),
       
      
        ],
      ),
   
      
    );
  
  }
}
