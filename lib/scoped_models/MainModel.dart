import 'package:minor2/scoped_models/methods.dart';
import 'package:minor2/scoped_models/auths.dart';

import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with
        Methods,Auths
        {}


//return ScopedModelDescendant<MainModel>(
//builder: (context1, child, MainModel) {
//
//})