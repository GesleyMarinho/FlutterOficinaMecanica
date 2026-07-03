import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/domain/cliente_model.dart';

class ClienteService {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<String> salvarCliente(ClienteModel cliente) async {
    try {
      DocumentReference doc = await _firebase
          .collection("clientes")
          .add(cliente.toMap());
      print("Cliente cadastrado com sucesso. ID: ${doc.id}");
      return doc.id;
    } catch (e) {
      print("log de erro ao cadastrar $e");
      rethrow;
    }
  }

  Future<void> atualizar(ClienteModel cliente) async {
    if (cliente.id != null){
    await _firebase
        .collection("clientes")
        .doc(cliente.id)
        .update(cliente.toMap());
  }
    }

  Future<void> deletarCliente(String id) async {
    await _firebase.collection("clientes").doc(id).delete();
  }

  Future<List<ClienteModel>> listarClientes() async {
    final snapshot = await _firebase.collection("clientes").get();
    return snapshot.docs
        .map((doc) => ClienteModel.fromMap(doc.id, doc.data()))
        .toList();
  }

}
