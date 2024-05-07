// ignore_for_file: file_names, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tagr/component/component.dart';
import 'package:tagr/controller/homeScreen_Controller.dart';
import 'package:tagr/gen/assets.gen.dart';
import 'package:tagr/models/fakeData.dart';
import 'package:tagr/component/colors.dart';
import 'package:tagr/component/string.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
   HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.spaceWidth,
  });
  
  HomeScreen_Controller homeScreen_Controller = Get.put(HomeScreen_Controller());

  final Size size;
  final TextTheme textTheme;
  final double spaceWidth;

  @override
  Widget build(BuildContext context) {
    Widget poster(){
      return
        Stack(
        children: [
          Container(
            width: size.width/1.25,
            height: size.height/4.2,
            // ignore: sort_child_properties_last
            child : CachedNetworkImage(
            imageUrl:homeScreen_Controller.posterModel.value.image!,
            imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: imageProvider,fit: BoxFit.cover
                )
            ),),
            placeholder:(context, url) => loading(),
            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined,color: Colors.grey,size: 50),
            ),
            foregroundDecoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: GradientColor.posterMainHomeColor)
            ),
            ),
          Positioned(
            bottom: 8,
            right: 8,
            left: 8,
            child: Column(
              children: [
                Text(homeScreen_Controller.posterModel.value.title!,style:textTheme.headline1,overflow: TextOverflow.ellipsis,maxLines: 2,)
              ],
            ),
          )
        ],
        );
    }
    Widget tags(){
      return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagList.length,
        itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(index==0?spaceWidth:8, 8, 8, 8),
          child: MainTags(textTheme: textTheme,index: index,),
        );
      },),
    );
    }
    Widget topVisitedPodcast(){
      return SizedBox(
      height: size.height/3.5,
          
      child: Obx(()=>
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeScreen_Controller.topPodcastList.length,
          itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(index==0?spaceWidth:8, 8, 8, 8),
            child: Column(
              children: [
                SizedBox(
                  height: size.height/5.2,
                  width: size.width/2.5,
                    
                  child: CachedNetworkImage(
                    imageUrl: homeScreen_Controller.topPodcastList[index].poster!,
                    imageBuilder: (context, imageProvider) =>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(14)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                          )
                      ),
                    ),
                    placeholder: (context, url) =>
                    const loading(),
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined,color: Colors.grey,size: 50,),
                  ),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: size.width/2.5,
                  child: Text(homeScreen_Controller.topPodcastList[index].title!,style: textTheme.headline3,overflow: TextOverflow.ellipsis,maxLines: 2,))
              ],
            ),
          );  
        },),
      ),
    );
    }
    Widget topVisitedBlogs(){
      return SizedBox(
      height: size.height/3.5,
          
      child: Obx(()=>
        ListView.builder(
          itemCount: homeScreen_Controller.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return  Padding(
              padding: EdgeInsets.fromLTRB(index==0?spaceWidth:8, 8, 8, 8),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height/5.2,
                    width: size.width/2.5,
            
                    child: CachedNetworkImage(
                      imageUrl: homeScreen_Controller.topVisitedList[index].image!,
                      imageBuilder: (context, imageProvider) => 
                      Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(14)),
                            image: DecorationImage(image: NetworkImage(homeScreen_Controller.topVisitedList[index].image!),fit: BoxFit.cover),
                          ),
                          foregroundDecoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            gradient: LinearGradient(
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: GradientColor.posterMainHomeColor) 
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(homeScreen_Controller.topVisitedList[index].author!,style: textTheme.subtitle1,overflow: TextOverflow.ellipsis,),
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye,color: SoidColor.colorSubjectOnPage,size: 17,),
                                  const SizedBox(width: 2,),
                                  Text(homeScreen_Controller.topVisitedList[index].view!,style: textTheme.subtitle1,overflow: TextOverflow.ellipsis,),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    placeholder: (context, url) => loading(),
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined,color: Colors.grey,size: 50)
                    )
                  ),
                  const SizedBox(height: 6,),
                  SizedBox(
                    width: size.width/2.5,
                    child: Text(homeScreen_Controller.topVisitedList[index].title!,overflow: TextOverflow.ellipsis,maxLines: 2,style: textTheme.headline3,))
                ],
              ),
            );
          },
        ),
      ),
    );  

    }
    return SingleChildScrollView(
      child: Obx(()=>
      homeScreen_Controller.homeScreenLoading.value==false?
        Column(
          children: [
            const SizedBox(height: 8,),
            //Poster
            poster(),          
            const SizedBox(height: 16,),
            //Tags
            tags(),
            const SizedBox(height: 26,),
            //Blogs
            HomeBlogsHottest(spaceWidth: spaceWidth, textTheme: textTheme),
            const SizedBox(height: 12,),
            topVisitedBlogs(),
            //Podcast
            HomePodcastHottest(spaceWidth: spaceWidth, textTheme: textTheme),
            topVisitedPodcast(),
            const SizedBox(height: 100,)
          ],
        ):SizedBox(height: size.height/1.3,child:const loading()),
      ),
    );
  }

}
class HomePodcastHottest extends StatelessWidget {
  const HomePodcastHottest({
    super.key,
    required this.spaceWidth,
    required this.textTheme,
  });

  final double spaceWidth;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spaceWidth,bottom: 9),
      child: Row(
        children: [
          ImageIcon(Assets.icons.podcast.provider(),color: SoidColor.colorSubject,size: 25,),
          const SizedBox(width: 8,),
          Text(string.showHottestPodcasts,style: textTheme.headline2,)
        ],
      ),
    );
  }
}

class HomeBlogsHottest extends StatelessWidget {
  const HomeBlogsHottest({
    super.key,
    required this.spaceWidth,
    required this.textTheme,
  });

  final double spaceWidth;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spaceWidth,bottom: 9),
      child: Row(
        children: [
          ImageIcon(Assets.icons.blogs.provider(),color: SoidColor.colorSubject,size: 25),
          const SizedBox(width: 8,),
          Text(string.showHottestBlog,style: textTheme.headline2,)
        ],
      ),
    );
  }
}