import 'package:bobo_ui/modals/product_modal.dart';
import 'package:bobo_ui/modals/table_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ClubModal{
  final String id;
  final String name;
  final String image;
  final List<TableModal> tables;
  final List<ProductModal> products;
  final LatLng position;
  final String locationLabel;


  // TODO: 
  // icon
  // reviews
  // rating

  ClubModal({
    this.id = '',
    @required this.name,
    this.image,
    this.position,
    this.locationLabel,
    this.tables = const[],
    this.products = const [],
  });

  get totalNoTables => tables.length;
  get key => _key();
  get marker => _marker();
  get map => _map();
  get ref => Firestore.instance.document('clubs/$id');


  String _key(){
    return position.latitude.toString()+'-' + position.longitude.toString() + name;
  }

  Marker _marker (){
  return Marker(
      markerId: MarkerId(_key()),
      position: position,
      infoWindow: InfoWindow(title: name),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueViolet,
      ),
    );
  }

  Map<String, dynamic> _map(){
    return {
      'name': name,
      'image': image,
      'position': GeoPoint(position.latitude, position.longitude),
      'locationLabel': locationLabel,
      'tables': mapTables(),
      'products': mapProducts()     
    };
  }

  List mapTables(){
    List<Map<String, dynamic>>  lst=[];
    tables.forEach((item){
      lst.add(item.map);
    });

    return lst;
  }

  List mapProducts(){
    List<Map<String, dynamic>>  lst=[];
    products.forEach((item){
      lst.add(item.map);
    });

    return lst;
  }

  

}

