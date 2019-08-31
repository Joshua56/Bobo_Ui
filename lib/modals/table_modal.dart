class TableModal{
  final String id;
  final int maxNoChairs;
  final int minNoChairs;
  final double reserveCostPerChair;

  get map => _map();

  // TODO:
  // schedule

  TableModal({
    this.id,
    this.maxNoChairs = 1,
    this.minNoChairs = 1,
    this.reserveCostPerChair = 0.0,
  });

  Map<String, dynamic> _map(){
    return{
      'id': id,
      'maxNoChairs': maxNoChairs,
      'minNoChairs': minNoChairs,
      'reserveCostPerChair': reserveCostPerChair
    };
  }
}