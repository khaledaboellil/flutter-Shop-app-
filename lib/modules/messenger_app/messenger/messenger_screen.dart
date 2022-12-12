import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messenger_screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title:
         Row(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(backgroundImage: NetworkImage("https://scontent.fcai1-2.fna.fbcdn.net/v/t39.30808-6/273612340_4747900048597114_8850077921425398866_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeH3LwRr_7vBoyfn4x9ejfMjMLmFR2AC_sIwuYVHYAL-wk-3-Ny1TjJLOGgDUeJ4fTHZqTZSeSf_7oSW-j_vk_vM&_nc_ohc=lOhXyqs3ty0AX9HJp8h&_nc_ht=scontent.fcai1-2.fna&oh=00_AT_vWmYuJkvbW6I6i4NcpQf7NgEvNwMnbnSEoXz_YmVHQA&oe=624B49CB")),
              SizedBox(width: 15.0,),
              Text("Chats",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),

        actions: <Widget>[

          IconButton(icon: CircleAvatar(
              radius: 20,
              child:Icon(Icons.camera_alt) ) , onPressed: null) ,
          IconButton(icon:
          CircleAvatar( child :
          Icon(Icons.edit) ), onPressed: null)

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start  ,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[300]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("Search"),
                    ],
                  ),
                ),

              ),
              SizedBox(height: 20) ,
              Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>BuildStoryitem(),
                    separatorBuilder:(context,index) =>SizedBox(width: 20,),
                    itemCount: 5),
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index)=>BuildChatitem(),
                  separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: 15)


                    ],
                  ),
        ),

            ),





    );

  }
}
Widget BuildStoryitem()=>Container(
  width: 60,
  child: Column(

    children: <Widget>[
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          CircleAvatar( radius: 30,
              backgroundImage: NetworkImage("https://scontent.fcai1-2.fna.fbcdn.net/v/t39.30808-6/273612340_4747900048597114_8850077921425398866_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeH3LwRr_7vBoyfn4x9ejfMjMLmFR2AC_sIwuYVHYAL-wk-3-Ny1TjJLOGgDUeJ4fTHZqTZSeSf_7oSW-j_vk_vM&_nc_ohc=lOhXyqs3ty0AX9HJp8h&_nc_ht=scontent.fcai1-2.fna&oh=00_AT_vWmYuJkvbW6I6i4NcpQf7NgEvNwMnbnSEoXz_YmVHQA&oe=624B49CB")),
          CircleAvatar(radius: 9,backgroundColor: Colors.white,),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 2 ,
              end:2,
            ),
            child: CircleAvatar(radius: 7,backgroundColor: Colors.green,),
          ),

        ],
      ),
      Text("khaled aboellil",overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,),
    ],
  ),
) ;

Widget BuildChatitem()=> Row(
  children: <Widget>[
    Container(
      width: 60,
      child: Column(

        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              CircleAvatar( radius: 30,
                  backgroundImage: NetworkImage("https://scontent.fcai1-2.fna.fbcdn.net/v/t39.30808-6/273612340_4747900048597114_8850077921425398866_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeH3LwRr_7vBoyfn4x9ejfMjMLmFR2AC_sIwuYVHYAL-wk-3-Ny1TjJLOGgDUeJ4fTHZqTZSeSf_7oSW-j_vk_vM&_nc_ohc=lOhXyqs3ty0AX9HJp8h&_nc_ht=scontent.fcai1-2.fna&oh=00_AT_vWmYuJkvbW6I6i4NcpQf7NgEvNwMnbnSEoXz_YmVHQA&oe=624B49CB")),
              CircleAvatar(radius: 9,backgroundColor: Colors.white,),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 2 ,
                  end:2,
                ),
                child: CircleAvatar(radius: 7,backgroundColor: Colors.green,),
              ),

            ],
          ),

        ],
      ),
    ),
    SizedBox(width: 10,),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Khaled aboellil",style: TextStyle(fontSize: 15),),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Expanded(child: Text("Hello I am new at messenger")),
              Text(" . "),
              Text("11:42 PM")
            ],
          ),
        ],
      ),
    ),
  ],
) ;