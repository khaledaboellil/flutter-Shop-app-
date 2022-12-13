

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomestate.dart';
import 'package:todo_app/models/ShopAppModel/Homemodel.dart';
import 'package:todo_app/models/categoriesModel/categoriesmodel.dart';

import '../../../shared/comapnents/companents.dart';
import '../../../shared/comapnents/constans.dart';
import '../Productdetails/prodtuctdetails_screen.dart';

class ShopHome extends StatelessWidget {

  bool istrue(bool ? value )
  {

    if(value!=null)
    {
      return value ;
    }
    else
      return false ;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,ShopHomeStates>(
        listener: (context, state) {
          if(state is ChangeFavSucessState)
            {
              if(state.model.status == false ){
                toastShow(msg:'${state.model.message}',state: toastStatus.ERROR ) ;
              }
            }
        },
        builder: (context,state){
          return ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel != null&&HomeCubit.get(context).categoriesModel != null ,
            builder: (context)=>HomeBuilder(HomeCubit.get(context).homeModel!,HomeCubit.get(context).categoriesModel!,context),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },

    );

  }


  Widget HomeBuilder(HomeModel model,CategoriesModel catModel,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(items: model.data!.banners.map((e) => Image(image: NetworkImage('${e.image}'),
          width:double.infinity,fit:BoxFit.cover,)).toList()
        , options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection:Axis.horizontal,
              autoPlay: true ,

            )) ,
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Catogeries',
              style: TextStyle(
                fontSize: 24 ,
                fontWeight: FontWeight.w800,
              ),) ,
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>buildCategories(catModel.data!.data[index]),
                    separatorBuilder:(context,index) =>SizedBox(width: 10,),
                    itemCount: catModel.data!.data.length),
              ),
            ],
          ),
        ) ,

        SizedBox(
          height: 20.0,
        ) ,
        Text('NewProduct',
          style: TextStyle(
            fontSize: 24 ,
            fontWeight: FontWeight.w800,
          ),) ,
        SizedBox(
          height: 8.0,
        ) ,
        GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.55,

            children:List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context)) ,

        ),
      ],
    ),
  ) ;

  Widget buildCategories(DataModel model)=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
          image:NetworkImage('${model.image}') ,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.8),
        child: Text('${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow:TextOverflow.ellipsis ,
          style: TextStyle(
            fontSize: 12 ,
            color: Colors.white ,
          ),
        ),
      ),

    ],
  ) ;
  Widget buildGridProduct(ProductModel model,context)=>GestureDetector(
    onTap: (){
      navigateTo(context, Productdetails_screen(model));
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200,
              ),
              if(model.discount!=0)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}' ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3
                  ),

                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}' ,

                      style: TextStyle(
                          color: defaultcolor,
                          fontSize: 12,
                      ),

                    ),
                    SizedBox(width: 5,),
                    if(model.discount!=0)
                    Text(

                      '${model.oldPrice.round()}' ,

                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration:TextDecoration.lineThrough ,
                      ),

                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: istrue(HomeCubit.get(context).fav[model.id]) ? defaultcolor : Colors.grey,
                      child: IconButton(onPressed: (){
                          HomeCubit.get(context).changeButtonColor(model.id) ;

                      },
                        icon: Icon(Icons.favorite_border),
                        color: Colors.white,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}