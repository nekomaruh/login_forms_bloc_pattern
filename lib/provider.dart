import 'package:flutter/cupertino.dart';
import 'package:loginformsblocpattern/login_bloc.dart';
export 'package:loginformsblocpattern/login_bloc.dart';

class Provider extends InheritedWidget{
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child})
    :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}