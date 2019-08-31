import 'package:bobo_ui/modals/club_modal.dart';
import 'package:bobo_ui/modals/product_modal.dart';
import 'package:bobo_ui/modals/table_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClubModule extends ChangeNotifier{

  // Firebase
  final databaseReference = Firestore.instance;

  List<ClubModal> _clubs=[];

  // set setClubs (List<ClubModal> cls){
  //   _clubs = cls;
  //   notifyListeners();
  // }


  Set<Marker> _markers (){
    final Set<Marker> lst = {};

    _clubs.forEach((item){

      lst.add(item.marker);
    });
    return lst;
  }
  void _fetchClubs()async{
    QuerySnapshot _clubsSnapshot = await databaseReference.collection('clubs').getDocuments();
    setClubs = _convertToClubModal(_clubsSnapshot.documents);
    
  }

  ClubModal _getClub(String key){
    ClubModal club;
    _clubs.forEach((item){
      if(item.key == key){
        club = item;
      }
    });
    return club;
  }


  get clubs => _clubs;
  get clubsCount => _clubs.length;
  Set<Marker> get markers => _markers();
  get getClub => (key) { return _getClub(key); };
  get fetchClubs => _fetchClubs();

  get convertToClubModal => (List<DocumentSnapshot> data){
    // _fetchClubs();
    return _convertToClubModal(data);
  };


  // set _setRestaurant(List<ClubModal> lst) {
  //   _restaurant = lst;
  //   notifyListeners();
  // }
  set setClubs(List<ClubModal> item){
    _clubs = item;
    notifyListeners();
  }

  set addClub(ClubModal club){
    _clubs.add(club);
    createClub(club);
    notifyListeners();
    
  }

  set deleteClub(String id){
    _deleteClub(id);
    notifyListeners();
  }

  // id is preffered since each restaurant will have a unique id/key
  // set deleteClub(String id)
  void _deleteClub(String id) async {
    DocumentReference r = await databaseReference.document('clubs/$id');
    r.delete();
  }

  void createClub(ClubModal club) async {
    DocumentReference ref = await databaseReference.collection("clubs")
        .add(club.map);

  }

  List<ClubModal> _convertToClubModal(List<DocumentSnapshot> data){
    List<ClubModal> _clubModals=[];
    data.forEach((item){
      List<TableModal> _t=[];
      List<ProductModal> _p=[];

      item.data['tables'].forEach((it){
        _t.add(
          TableModal(
            id: it['id'],
            maxNoChairs: it['maxNoChairs'],
            minNoChairs: it['minNoChairs'],
            reserveCostPerChair: it['reserveCostPerChair']
          )
        );
      });

      item.data['products'].forEach((p){
        _p.add(
          ProductModal(
            id: p['id'],
            name: p['name'],
            price: p['price']
          )
        );
      });

      _clubModals.add(
        ClubModal(
          id: item.documentID,
          name: item.data['name'],
          image: item.data['image'],
          position: LatLng(item.data['position'].latitude, item.data['position'].longitude),
          locationLabel: item.data['locationLabel'],
          tables: _t,
          products: _p,
        )
      );
    });

    return _clubModals;
  }






}