import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/view_models/homeVM.dart';
import 'package:wheelznstuff/ui/ui_helpers.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';
import 'package:wheelznstuff/ui/views/tabchat_view.dart';
import 'package:wheelznstuff/ui/views/tabdashboard_view.dart';
import 'package:wheelznstuff/ui/views/tabgroup_view.dart';
import 'package:wheelznstuff/ui/views/tabprofile_view.dart';

import '../ui_helpers.dart';

class HomeView extends StatefulWidget{
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  TabController tabController;


  @override
  Widget build(BuildContext context) {
    return BaseView<HomeVM>(
      onModelReady: (model){
        this.tabController = model.initTabView(tabController: tabController,
            length: 4, tickerProvider: this);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Dashbord'),
          leading: Container()/* remove back bar */,
          centerTitle: true,
          actions: [
            FlatButton(
              child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => model.signOut(context),
            )
          ],
        ),
        body: TabBarView(
          controller: this.tabController,
          children: [
            TabDashboardView(),
            TabChatView(),
            TabGroupsView(),
            TabProfileView(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.teal,
          child: TabBar(
            controller: this.tabController,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home),),
              Tab(icon: Icon(Icons.chat),),
              Tab(icon: Icon(Icons.group),),
              Tab(icon: Icon(Icons.person),)
            ],
          ),
        ),
      ),
    );
  }
}