import 'package:app_01/models/user.dart';
import 'package:app_01/services/database.dart';
import 'package:flutter/material.dart';
import 'package:app_01/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../shared/loading.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> names = ['a', 'b', 'c', 'd', 'e'];

  //form values
  String? _currentName  ;
  String? _currentAddress;
  int? _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamBuilder<MyUserData>(
      stream: DatabaseService(user.uId).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          MyUserData? myUserData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children:  [
                Text('Update your info setting', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: myUserData?.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Please enter address' : null,
                  onChanged: (value) => setState(()=> _currentAddress = value),
                ),

                //dropdown
                DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    value: _currentName ?? 'a' ,
                    items: names.map((name){
                      return DropdownMenuItem(
                          value: name,
                          child: Text('$name name')
                      );
                    }).toList(),
                    onChanged: (value) => setState(()=> _currentName = value.toString())
                ),

                //Slider
                Slider(
                    value: (_currentAge ?? myUserData!.age).toDouble(),
                    activeColor: Colors.purple[_currentAge ?? 100],
                    inactiveColor: Colors.purple[_currentAge ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (value)=> setState(() {
                      _currentAge = value.round() as int?;
                    })
                ),


                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purpleAccent)),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                        await DatabaseService(user.uId).updateUserData(
                            _currentName ?? myUserData!.name,
                            _currentAddress ?? myUserData!.address,
                            _currentAge ?? myUserData!.age);
                        Navigator.pop(context);
                    }
                  },

                ),
              ],
            ),
          );
        }else{
          return Loading();
        }

      }
    );
  }
}
