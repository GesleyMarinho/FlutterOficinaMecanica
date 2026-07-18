import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_oficina/features/models/domain/orderServico_model.dart';

class OrdemServicoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> salvarOrdemServicoFireBase(OrdemServicoModel orderServico) async {
    try {
      DocumentReference doc = await _firestore
          .collection("ordens_servico")
          .add(orderServico.toMap());
      return doc.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrdemServicoModel>> listarPorVeiculo(String veiculoId) async {
    final snapshot = await _firestore
        .collection("ordens_servico")
        .where("veiculoId", isEqualTo: veiculoId)
        .get();
    return snapshot.docs
        .map((doc) => OrdemServicoModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
