

import 'package:flutter/material.dart';
import 'package:wheelznstuff/core/enums/form_types.dart';
import 'package:wheelznstuff/core/enums/viewState.dart';
import 'package:wheelznstuff/core/view_models/loginVM.dart';
import 'package:wheelznstuff/helpers/form_validation.dart';
import 'package:wheelznstuff/ui/views/base_view.dart';

class LoginView extends StatefulWidget{

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<FormState> getFormKey () => formKey;
  FormType _formType = FormType.login;

  String _email;
  String _password;
  String _displayName;
  bool processingForm = false;

  //  ‘auto validate’ is used to validate the input as soon as we enter the data.
  //  Initially it is set it to false.  The reason that it is initially set to
  //  false, is because when the user opens the form, all the fields will by
  //  default empty, and an empty field is invalid. We don’t want to show such
  //  an invalid error.
  //
  //  Once the user submits the form, if there are any validation error then
  //  we'll start validating the input automatically by updating _autoValidate to true.
  bool _autoValidate = false;

  void viewRegister(GlobalKey<FormState> formKey, LoginVM model) {
    _formType = FormType.register;
    model.moveToRegister(formKey);
  }

  void viewLogin(GlobalKey<FormState> formKey, LoginVM model){
    _formType = FormType.login;
    model.moveToLogin(formKey);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginVM>(
        onModelReady: (model) {},
        builder: (context, model, child) =>
            Scaffold(
                body: model.state == ViewState.Idle
                    ? Scaffold(
                  body: ListView(
                    children: <Widget>[
                      //  Hero title
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  15.0, 110.0, 0.0, 0.0),
                              child: Text('Hello', style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold,),),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  15.0, 175.0, 0.0, 0.0),
                              child: Text('There', style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight
                                  .bold),),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  220.0, 175.0, 0.0, 0.0),
                              child: Text('.', style: TextStyle(fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),),
                            ),
                          ],
                        ),
                      ),
                      //  Form layout
                      Container(
                        padding: EdgeInsets.only(
                            top: 35.0, left: 20.0, right: 20.0),
                        child: Form(
                          key: getFormKey(),
                          autovalidate: _autoValidate,
                          child: Column(
                            children: buildInputs(model) +
                                buildSubmitButtons(model),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Center(child: CircularProgressIndicator())));
  }

  List<Widget> buildInputs(LoginVM model) {


    if (_formType == FormType.register) {
      return <Widget>[
        //  Email entry
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
              fontFamily: 'Archivo',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
            //style focus underline colour
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            ),
          ),
          validator: EmailFieldValidator.validate,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(height:20.0),
        //  Password entry
        TextFormField(
          key: Key('password'),
          decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(
              fontFamily: 'Archivo',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),

        SizedBox(height:20.0),
        TextFormField(
          key: Key('displayname'),
          decoration: InputDecoration(labelText: 'Display name', labelStyle: TextStyle(
              fontFamily: 'Archivo',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          validator: DisplayNameValidator.validate,
          onSaved: (String value) => _displayName = value,
        ),



        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Forgot Password',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  decoration: TextDecoration.underline),),
            onTap: (){},
          ),
        ),
        SizedBox(height: 20.0),
      ];
    }else{
      return <Widget>[
        //  Email entry
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
              fontFamily: 'Archivo',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
            //style focus underline colour
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            ),
          ),
          validator: EmailFieldValidator.validate /*longhand version - (value) => EmailFieldValidator.validate(value)*/,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(height:20.0),
        //  Password entry
        TextFormField(
          key: Key('password'),
          decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(
              fontFamily: 'Archivo',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Forgot Password',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  decoration: TextDecoration.underline),),
            onTap: (){},
          ),
        ),
        SizedBox(height: 20.0),
      ];
    }

  }

  List<Widget> buildSubmitButtons(LoginVM model) {
    if (_formType == FormType.login) {
      return <Widget>[
        //  Login button
        Container(
          height: 40.0,
          child: Material(
            key: Key("signIn"),
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 4.0,
            child: GestureDetector(
              onTap: () => model.validateAndSubmit(
                email: _email,
                formType: _formType,
                formKey: formKey
              ),
              child: Center(
                child: Text("LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo'
                  ),),
              ),
            ),
          ),
        ),
        //
        SizedBox(height: 20.0,),
        //  Login with facebook button
        Container(
          height: 40.0,
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => model.interceptGoogleSignIn(model),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    /*child: ImageIcon(AssetImage('assets/google_logo.png')),*/
                    child: Image(
                      image: AssetImage('assets/images/google_logo.png'),
                      height: 24.0,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Center(
                    child: Text("Sign In with Google",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Archivo"
                      ),),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Create an account',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  decoration: TextDecoration.underline),),
            onTap: () => viewRegister(formKey, model),
          ),
        ),

      ];
    } else {
      return <Widget>[
        //  Login button
        Container(
          height: 40.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 4.0,
            child: GestureDetector(
              onTap: () => model.validateAndSubmit(
                email: _email,
                password: _password,
                formKey: formKey,
                formType: _formType,
              ),
              child: Center(
                child: Text("Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo'
                  ),),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.0,),

        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Have an account? Login',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Archivo',
                  decoration: TextDecoration.underline),),
            onTap: () => viewLogin(formKey, model),
          ),
        ),

      ];
    }
  }
}