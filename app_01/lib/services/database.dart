import 'package:app_01/models/user.dart';
import 'package:app_01/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
   final String uId;

  DatabaseService(this.uId); //collection reference
  final CollectionReference userCollection = FirebaseFirestore.
              instance.collection('userData');
  Future updateUserData(String name, String address, int age ) async{
      return await userCollection.doc(uId).set({
        'name' : name,
        'address': address,
        'age': age
      });
  }
  //userInfo list from snapshot
   List<UserInfo> _userInfoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      final data = doc.data() as Map<String, dynamic>?;
      return UserInfo(
         data?['name'] ?? 'No name',
         data?['address'] ?? 'Nowhere',
         data?['age'] ?? 0,
      );
    }).toList();
   }

   //MyUserData from snapshot
   MyUserData _myUserDataFromSnapshot(DocumentSnapshot snapshot){
     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MyUserData(
        uId,
        data['name'],
        data['address'],
        data['age'],
    );
   }

  //get user data stream
  Stream<List<UserInfo>> get userInfo{
    return userCollection.snapshots().map(_userInfoListFromSnapshot);
  }

  //get user doc stream
  Stream<MyUserData> get userData{
    return userCollection.doc(uId).snapshots().map(_myUserDataFromSnapshot);
  }

}