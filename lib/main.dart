import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/newsapp/cubit/cubit.dart';
import 'package:todo_app/layout/newsapp/cubit/states.dart';
import 'package:todo_app/layout/newsapp/news_app.dart';
import 'package:todo_app/layout/shopapp/cubit/shophomecubit.dart';
import 'package:todo_app/layout/shopapp/shopapp.dart';
import 'package:todo_app/layout/todo%20app/todo_app.dart';

import 'package:todo_app/layout/todo%20app/todo_app.dart';
import 'package:todo_app/modules/shop_app/Shop_Loginscreen/Shop_loginScreen.dart';
import 'package:todo_app/modules/shop_app/onboarding_screen/onBordingScreen.dart';
import 'package:todo_app/shared/Bloc_observe.dart';
import 'package:todo_app/shared/comapnents/constans.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';

import 'layout/newsapp/cubit/modecubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  blocObserver: MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData("isDark");
  bool? onBoarding =CacheHelper.getData('onBoarding');
  token =CacheHelper.loadStringData(key: 'token');

  if(isDark==null)
    {
      isDark=false ;
    }
  Widget widget ;
  print('this');
  print(onBoarding);
  if(onBoarding != null)
  {
    if(token != null) widget = Shop_Screen();
    else widget = Shop_Login_Screen();
  } else
  {
    widget = OnBoardingScreens();

  }

  runApp(MyApp(isDark: isDark, widget: widget,));
}


class MyApp extends StatelessWidget{
  final bool isDark;
  final Widget widget;
  MyApp( {  required this.isDark,  required this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (BuildContext context) => HomeCubit()..getHomeData()..
        getCategoriesData()..getFavouriteData()..getProfileData()..getSearchData('')) ,
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getScience()..getSports()),
        BlocProvider(create: (BuildContext context) => ModeCubit()..changelightmode(fromShared: isDark)),
      ],
      child: BlocConsumer<ModeCubit, NewsStates>(

        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme ,
            darkTheme: darktheme,
            themeMode: ModeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: widget,
          ) ;
        }

      ),
    ) ;
  }


}