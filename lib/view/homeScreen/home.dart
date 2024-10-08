import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagr/component/searchbar.dart';
import 'package:tagr/constant/colors.dart';
import 'package:tagr/constant/string.dart';
import 'package:tagr/constant/stroge_constant.dart';
import 'package:tagr/controller/registerController.dart';
import 'package:tagr/gen/assets.gen.dart';
import 'package:tagr/view/aboutScreen.dart';
import 'package:tagr/view/homeScreen/home_Screen.dart';
import 'package:tagr/view/homeScreen/profileScreen.dart';
import 'package:tagr/view/register/registerIntro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



final GlobalKey<ScaffoldState> _key = GlobalKey();

// ignore: must_be_immutable
class Home extends StatefulWidget{

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RxInt selectedIndex = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUserName = prefs.getString('userName');
  
  if (storedUserName != null) {
    setState(() {
      userNameAc = storedUserName;
    });
    print("Loaded userName: $storedUserName");
  } else {
    print("No userName found in storage");
  }
}


  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double spaceWidth = size.width/10;

    List<Widget> mainScreenPages=[
    ];

    return Scaffold(
      key: _key,
      //Drawer
      drawer: Drawer(
        backgroundColor: SoidColor.colorBGScafold,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _key.currentState!.closeDrawer();
                  selectedIndex.value = 1;
                },
                //Profile Humberger Menu
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Assets.images.user.path,scale: 5,),
                    SizedBox(height: size.height/65,),
                    // ignore: deprecated_member_use
                    SizedBox(height: size.height/100,),
                    Text(userNameAc,style: const TextStyle(fontSize: 25,color: Colors.black),),
                    //Text("mohamadmahdijebeli@gmail.com",style: textTheme.headlineLarge,)
                  ],
                ),
              ),
            ),
            //Humberger Menu
            const Divider(
              color: SoidColor.colorDivider,
            ),
            ListTile(
              title: Row(
                children: [
                  ImageIcon(Assets.icons.share.provider()),
                  const SizedBox(width: 7,),
                  const Text("Share")
                ],
              ),
              onTap: () async{
                await Share.share(string.share);
              },
            ),
            const Divider(
              color: SoidColor.colorDivider,
            ),
            ListTile(
              title: Row(
                children: [
                  ImageIcon(Assets.icons.customerSupport.provider()),
                  const SizedBox(width: 7,),
                  const Text("Support")
                ],
              ),
              // ignore: deprecated_member_use
              onTap:() => {launch("https://www.t.me/mohamadmahdi_jebeli")},
            ),
            const Divider(
              color: SoidColor.colorDivider,
            ),
            ListTile(
              title: Row(
                children: [
                  
                ],
              ),
            ),
            const Divider(
              color: SoidColor.colorDivider,
            ),
            ListTile(
              title: Row(
                children: [
                  ImageIcon(Assets.icons.about.provider()),
                  const SizedBox(width: 7,),
                  const Text("About"),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AboutScreen()));
              },
            )
          ],
        ),
      ),
      //AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        InkWell(
          child: const Icon(Icons.menu,),
          onTap: () {
            _key.currentState!.openDrawer();
          },
          ),
        Image(image: Assets.images.tagrLogoNoBG.provider(),color: Colors.black,height: size.height/13.6,),
        GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
              );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ZoomTapAnimation(
              child: Icon(Icons.search)),
          ),
        ),
        ],
        ),
      ),
      body: 
      Stack(
        children: [
          Positioned.fill(
            child: Obx(() => IndexedStack(
              index: selectedIndex.value,
              children: [
                HomeScreen(size: size, textTheme: textTheme, spaceWidth: spaceWidth),
                ProfileScreen(size: size, textTheme: textTheme, spaceWidth: spaceWidth),
              ],
            ))
            ),
          //Bottom Navigation
          BttmNavigation(
          size: size,
          mainScreenPages: mainScreenPages,
          changePage: (int value){
              selectedIndex.value=value;
          },
          ),
        ],
      ),
    );
    }
}

class BttmNavigation extends StatelessWidget {
   BttmNavigation({
    super.key,
    required this.size,
    required this.mainScreenPages,
    required this.changePage,
  });

  final Size size;
  final List<Widget> mainScreenPages;
  final Function changePage;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
    
      child: Container(
      height: size.height/10,
      
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors:GradientColor.bottomNavBGColor,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
          )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: size.width/13,right: size.width/13 ,bottom: size.height/80,top: size.height/80),
        child: Container(
          height: size.height/8,
      
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
      
            gradient: LinearGradient(colors: GradientColor.bottomNavColor)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ZoomTapAnimation(
                child: IconButton(onPressed: () => changePage(0), icon: ImageIcon(Assets.icons.home.provider(),size: 30,),color: SoidColor.colorSubjectOnPage,)
                ),
              IconButton(onPressed: (){Get.find<RegisterController>().checkLogin();}, icon: ImageIcon(Assets.icons.add.provider(),size: 30,),color: SoidColor.colorSubjectOnPage,),
              ZoomTapAnimation(
                child: IconButton(onPressed: () {
                  changePage(1);
                }, icon: ImageIcon(Assets.icons.user.provider(),size: 30,),color: SoidColor.colorSubjectOnPage,),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}