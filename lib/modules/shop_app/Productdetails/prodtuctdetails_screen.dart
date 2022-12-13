import 'package:flutter/material.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

import '../../../models/ShopAppModel/Homemodel.dart';
import '../../../shared/comapnents/constans.dart';

class Productdetails_screen extends StatelessWidget {
  ProductModel? model ;
  Productdetails_screen(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image: NetworkImage('${model!.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if(model!.discount!=0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white ,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20,),
            Text('${model!.name}',style: TextStyle(
              fontSize: 20 ,
              fontWeight: FontWeight.bold ,
            ),),
            SizedBox(height: 20,),
            myDivider(),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  '${model!.price.round()}' ,

                  style: TextStyle(
                    color: defaultcolor,
                    fontSize: 18,
                  ),

                ),
                SizedBox(width: 20,),
                if(model!.discount!=0)
                Text(
                    '${model!.discount.round()}%' ,

                    style: TextStyle(
                      fontSize: 18,
                     color: Colors.red ,
                    ),

                  ),
              ],
            ),
            SizedBox(height: 10,),
            if(model!.discount!=0)
            Text('was : ${model!.oldPrice}',style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                decoration:TextDecoration.lineThrough ,
              ),),
            SizedBox(height: 20,),
            myDivider(),
            SizedBox(height: 20,),
            Text('${model!.description}',style: TextStyle(
              fontSize: 20 ,
              fontWeight: FontWeight.bold ,
            ),),

          ],
        ),
      )
    );
  }
}
