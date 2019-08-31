import 'package:bobo_ui/modals/preoder_modal.dart';
import 'package:bobo_ui/modals/table_modal.dart';
import 'package:bobo_ui/modals/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ReservationModal{
  ReservationState state;
  final String id;
  final UserModal user;
  final DocumentReference club;
  final TableModal table;
  final int noChairs;
  final DateTime reserveDateTime;
  final DateTime dateTimeBooked;
  final PreoderModal preoderModal;

  get key => _key();

  get tableReservationCost => noChairs * table.reserveCostPerChair;
  get preoderCost => preoderModal.totalAmount;

  get totalCost => calcTotalCost();

  get autoCompleteReservation => _autoCompleteState;
  get map => _map();

  set updateState(ReservationState stt){
    state = stt;
  }

  
  ReservationModal({
    this.state = ReservationState.pending,
    this.id = '',
    @required this.user,
    @required this.club,
    @required this.table,
    this.noChairs = 1,
    @required this.reserveDateTime,
    this.dateTimeBooked,
    this.preoderModal,
  });

  double calcTotalCost(){
    double total = 0;
    total = noChairs * table.reserveCostPerChair;
    if(preoderModal != null){
      total += preoderModal.totalAmount;
    }
    return total;
  }

  void _autoCompleteState(){
    if(
      state != ReservationState.cancled && 
      state != ReservationState.complete &&
      DateTime.now().isAfter(reserveDateTime)
    ){
      updateState = ReservationState.complete;
    }
  }

  String _key(){
    return club.documentID + user.id.toString() + dateTimeBooked.toString();
  }

  Map<String, dynamic> _map(){
    DocumentReference _clubRef = Firestore.instance.document('clubs/${club.documentID}');
    return {
      'user': user.map,
      'club': club,
      'table': table.map,
      'noChairs': noChairs,
      'reserveDateTime': reserveDateTime,
      'dateTimeBooked': dateTimeBooked,
      'preoderModal': preoderModal.map
    };
  }

}

enum ReservationState{
  pending,
  cancled,
  complete,
}