import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/view_models/homeVM.dart';
import 'package:wheelznstuff/ui/ui_helpers.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';

import '../ui_helpers.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeVM>(
        onModelReady: (model) {
          model.getVendors();
        },
        builder: (context, model, child) => Scaffold(
            /*backgroundColor: backgroundColor,*/
            body: model.state == ViewState.Idle
                ? SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset("assets/images/burger_icon.svg"),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset("assets/images/search_icon.svg"),
                                  SizedBox(width: 20,),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Top Brands",style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),),
                              SvgPicture.asset("assets/images/forward_icon.svg")
                            ],),
                          SizedBox(height: 30,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: buildTopVendors(model),

                          ),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Popular Design",style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),),
                              SvgPicture.asset("assets/images/forward_icon.svg")
                            ],),
                          SizedBox(height: 30,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(/*builder: (_) => DetailPage())*/));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/image_1.png"))
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 80) / 2,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: AssetImage("assets/images/image_2.png"),fit: BoxFit.cover)
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 80) / 2,
                                    height: 230,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: AssetImage("assets/images/image_3.png"),fit: BoxFit.cover)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 80) / 2,
                                    height: 230,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: AssetImage("assets/images/image_4.png"),fit: BoxFit.cover)
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 80) / 2,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: AssetImage("assets/images/image_5.png"),fit: BoxFit.cover)
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
            )
                )
            )
                : Center(child: CircularProgressIndicator())));
  }

  /*Widget getPostsUi(List<Post> posts) => ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => PostListItem(
        post: posts[index],
        onTap: () {
          Navigator.pushNamed(context, 'post', arguments: posts[index]);
        },
      ));*/

  /*
  Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),fit: BoxFit.cover)
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text("Jean-Luis")
                                  ],
                                ),
                              ),
  * */


  Widget buildTopVendors(HomeVM homeVM){

    List<Padding> paddingElements = new List<Padding>();
    homeVM.vendors.forEach((vendorImage) {
      var _padElement = new Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //assets/images/forward_icon.svg
                  image: DecorationImage(image: AssetImage(UIHelper.getLogoUrl(logo: vendorImage.logo)),fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 15,),
            Text(vendorImage.companyName)
          ],
        ),
      );
      paddingElements.add(_padElement);
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: paddingElements
    );
  }

}