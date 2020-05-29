
import 'package:cloud_firestore/cloud_firestore.dart';

class NodosProvider {

  final fb = Firestore.instance.collection('Nodos');

  getAllNodos(){
    final nodos = fb.orderBy("Nombre").limit(5).snapshots();
    return nodos;
  }

  getDropdown(){
    final nodos = fb.snapshots();
    return nodos;
  }
  
}