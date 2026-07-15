import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_oficina/features/models/domain/veiculo_model.dart';

class VeiculoService {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<String> salvarVeiculoFirebase(VeiculosModel veiculo) async {
    try {
      DocumentReference doc = await _firebase
          .collection("Veiculos")
          .add(veiculo.toMap());
      print('Returne salvou $doc.id');
      return doc.id;
    } catch (e) {
      print('Log: Erro ao cadastrar Veiculo $e');
      rethrow;
    }
  }

  Future<List<VeiculosModel>> listarVeiculosPorCliente(String clienteId) async {
    final snapshot = await _firebase
        .collection("Veiculos")
        .where('clienteId', isEqualTo: clienteId)
        .get();
    return snapshot.docs
        .map((doc) => VeiculosModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
