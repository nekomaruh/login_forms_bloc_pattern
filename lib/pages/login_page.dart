import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _background(),
          _loginForm(context),
        ],
      )
    );
  }

  _background() {
    final purpleBackground = Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(63, 63, 156, 1),
                Color.fromRGBO(90, 70, 178, 1)
              ]
          )
      ),
    );

    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white.withOpacity(0.05),
      ),
    );

    final icon = Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(CupertinoIcons.profile_circled, color: Colors.white, size: 100,),
          SizedBox(height: 10, width: double.infinity,),
          Text('Johan Esteban', style: TextStyle(fontSize: 25, color: Colors.white),),

        ],
      ),
    );

    return new Stack(children: <Widget>[
      purpleBackground,
      Positioned(
        left: 30,
        top: 100,
        child: circle,
      ),
      Positioned(
        right: -40,
        top: -40,
        child: circle,
      ),
      icon
    ],);
  }

  _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 200,),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0,0),
                  //spreadRadius: 3
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Log In', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 28),),
                SizedBox(height: 30,),
                _createEmail(bloc),
                SizedBox(height: 30,),
                _createPassword(bloc),
                SizedBox(height: 50,),
                _createButton(bloc),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text('Forgot password?'),
          SizedBox(height: 30,)
        ],


      ),
    );

  }

  _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snap){
        return Container(
          padding: EdgeInsets.only(left: 40, right: 45),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
                labelText: 'Email',
                hintText: 'johesteb@gmail.com',
              errorText: snap.error
              //counterText: snap.data
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snap){
        return Container(
          padding: EdgeInsets.only(left: 40, right: 45),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
                labelText: 'Password',
                hintText: '******',
              errorText: snap.error
              //counterText: snap.data,
            ),
            onChanged: bloc.changePassword,
            //onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snap){
        return Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: RaisedButton(
            child: Text('Sign In'),
            color: Colors.deepPurple,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: snap.hasData ? (){Navigator.pushReplacementNamed(context, 'home');} : null,
          ),
        );
      },
    );
  }
}
