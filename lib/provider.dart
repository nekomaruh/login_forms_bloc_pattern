import 'package:flutter/widgets.dart';
import 'package:loginformsblocpattern/login_bloc.dart';
export 'package:loginformsblocpattern/login_bloc.dart';

class Provider extends InheritedWidget{
  final loginBloc = LoginBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}){
    if(_instance==null){
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child})
    :super(key: key, child: child);

  //Provider({Key key, Widget child})
  //  :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}