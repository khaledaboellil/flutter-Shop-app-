import 'package:flutter/material.dart';

class Home_screen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
     appBar: AppBar(
       leading:
       Icon(
         Icons.menu,
       ),
       title: Text(
         'Aboellil wa7d bs ',
       ),
       actions: <Widget>[
         IconButton(
             icon: Icon(Icons.notifications), onPressed: onNotification),
         IconButton(
             icon: Icon(Icons.search), onPressed: onSearch),

       ],
       centerTitle: true,
       backgroundColor: Colors.teal,
     ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(50.0),
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadiusDirectional.circular(20.0,
               ),
             ),
             clipBehavior: Clip.antiAliasWithSaveLayer,
             child: Stack(
               alignment: Alignment.bottomCenter,
               children: [
                 Image(
                   image: NetworkImage(
                     'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg',
                   ),
                   height: 200.0,
                   width: 200.0,
                   fit: BoxFit.cover,
                 ),
                 Container(
                   width: 200.0,
                   color: Colors.black.withOpacity(.7),
                   padding: const EdgeInsets.symmetric(
                     vertical: 10.0,
                   ),
                   child: Text(
                     'Flower',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 20.0,
                       color: Colors.white,
                     ),
                   ),

                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );

  }
}
void onNotification()
{
  print("Notification clicked");
}
void onSearch()
{
  print("search clicked");
}