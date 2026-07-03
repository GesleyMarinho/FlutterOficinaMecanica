import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

class VeiculoService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> salvarVeiculoFirebase(VeiculosModel veiculo) async {
    try {
      DocumentReference doc = await _firebaseFirestore
          .collection("Veiculos")
          .add(veiculo.toMap());
      print('Returne salvou $doc.id');
      return doc.id;
    } catch (e) {
      print('Log: Erro ao cadastrar Veiculo $e');
      rethrow;
    }
  }
}
