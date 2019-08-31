import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bobo_ui/modals/club_modal.dart';
import 'package:bobo_ui/modals/preoder_modal.dart';
import 'package:bobo_ui/modals/product_modal.dart';
import 'package:bobo_ui/modals/reservation_modal.dart';
import 'package:bobo_ui/modals/table_modal.dart';
import 'package:bobo_ui/modals/user_modal.dart';
import 'package:bobo_ui/modules/club_module.dart';
import 'package:bobo_ui/modules/user_module.dart';
import 'package:flutter/material.dart';


class ReservationModule extends ChangeNotifier{

  // Firebase
  final databaseReference = Firestore.instance;

  List<ReservationModal> _reservations = [];

  // dummy data

  

  //////////////////////////
  
  // get reservations => (ClubModal res){
  //   List<ReservationModal> items = [];

  //   _reservations.forEach((item){
  //     if(item.club == res){
  //       items.add(item);
  //     }
  //   });
  //   return items;
  // };

  get reservations => _reservations;

  get resCount => _reservations.length;


  set addReservation(ReservationModal item){
    _reservations.add(item);
    createReservation(item);
    notifyListeners();
  }

  // id is preffered since each reservation will have a unique id/key
  set _removeResevation(int index){
    _reservations.removeAt(index);
    notifyListeners();
  }

  get convertToReservationModal => (List<DocumentSnapshot> data){
    return _convertToReservationModal(data);
  };

  void removeResevation(ClubModal res, int index){
    int i = 0;
    int j = 0;
    _reservations.forEach((item){
      if(item.club == res){
        if(j == index){
          _removeResevation = i;
        }
        j++;
      }
      i++;
    });
  }

  void createReservation(ReservationModal reservation) async {
    DocumentReference ref = await databaseReference.collection("reservations")
        .add(reservation.map);
  }

  List<ReservationModal> _convertToReservationModal(List<DocumentSnapshot> data){
    List<ReservationModal> _reservationModals=[];

    data.forEach((item){
      UserModal _us = UserModal(
        id: item.data['user']['id'],
        username: item.data['user']['username']
      );
      
      TableModal _tb = TableModal(
        id: item.data['table']['id'],
        maxNoChairs: item.data['table']['maxNoChairs'],
        minNoChairs: item.data['table']['minNoChairs'],
        reserveCostPerChair: item.data['table']['reserveCostPerChair'],
      );

      List<OderItemModal> _orderItems(){
        List<OderItemModal> _ls = [];
        item.data['preoderModal']['orderItems'].forEach((item){
          _ls.add(
            OderItemModal(
              product: ProductModal(
                id: item['product']['id'],
                name: item['product']['name'],
                price: item['product']['price'],
              ),
              quantity: item['quantity'],
            )
          );
        });
        return _ls;
      }

      PreoderModal _pre = PreoderModal(
        id: item.data['preoderModal']['id'],
        orderItems: _orderItems()
      );
      

      _reservationModals.add(
        ReservationModal(
          id: item.documentID,
          state: item.data['state'],
          user: _us,
          club: item.data['club'],
          table: _tb,
          noChairs: item.data['noChairs'],
          reserveDateTime: DateTime.fromMillisecondsSinceEpoch(item.data['reserveDateTime'].seconds * 1000),
          dateTimeBooked: DateTime.fromMillisecondsSinceEpoch(item.data['dateTimeBooked'].seconds * 1000),
          preoderModal: _pre,
        )
      );
    });
    return _reservationModals;
  }


}