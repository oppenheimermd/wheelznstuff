import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/view_models/homeVM.dart';
import 'package:wheelznstuff/core/view_models/startupVM.dart';
import 'package:wheelznstuff/ui/ui_helpers.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';

import '../ui_helpers.dart';

class StartUpView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpVM>(
        onModelReady: (model) => model.handleStartUp(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: Image.asset('assets/images/icon_large.png'),
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xff19c7c1),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
