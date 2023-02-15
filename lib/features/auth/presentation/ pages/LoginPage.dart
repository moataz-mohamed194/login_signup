import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../widgets/login_form_widget.dart';
import 'CreateAccountPage.dart';
import 'MainUserPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF6F3EC),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection : Axis.vertical,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(children: [
              Text('Welcome back', style: TextStyle(color: Colors.grey, fontSize: 33, fontWeight: FontWeight.bold),),
              Text('Login to your account', style: TextStyle(color: Colors.grey, ))
            ],),
          ),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is MessageLoginState) {
                SnackBarMessage()
                    .showSuccesSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainUserPage()),
                    (route) => false);
              } else if (state is ErrorLoginState) {
                SnackBarMessage()
                    .showErrorSnackBar(message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingLoginState) {
                return LoadingWidget();
              }
              return LoginFormWidget();
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?  ", style: TextStyle(color: Colors.grey,  fontWeight: FontWeight.bold),),
                InkWell(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xff5C027E),
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => CreateAccountPage(num: 1,)));
                  },
                ),
              ],),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? 2  ", style: TextStyle(color: Colors.grey,  fontWeight: FontWeight.bold),),
                InkWell(
                  child: Text(
                    'Sign Up 2',
                    style: TextStyle(
                      color: Color(0xff5C027E),
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => CreateAccountPage(num: 2,)));
                  },
                ),
              ],),
          ),
        ],
        // padding: EdgeInsets.all(10),
        // ),
      ),
    );
  }
}
