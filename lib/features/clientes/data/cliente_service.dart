import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_oficina/core/constants/firebase_collections.dart';
import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/domain/cliente_model.dart';

class ClienteService {
  final FirebaseFirestore _db;

  ClienteService({FirebaseFirestore? db})
    : _db = db ?? _buildDb();

  static FirebaseFirestore _buildDb() {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: true);
    return db;
  }

  CollectionReference get _colecao =>
      _db.collection(FirebaseCollections.clientes);

  Future<String> criar(ClienteModel cliente) async {
    AppLogger.info('Criando cliente: ${cliente.nome}', tag: 'ClienteService');

    // Com persistência offline, o add() grava no cache local e retorna imediatamente.
    // A sincronização com o servidor ocorre em segundo plano quando houver conexão.
    final docRef = await _colecao.add(cliente.toMap());

    AppLogger.info(
      'Cliente criado com ID: ${docRef.id}',
      tag: 'ClienteService',
    );
    return docRef.id;
  }

  Future<void> atualizar(ClienteModel cliente) async {
    if (cliente.id == null) throw Exception('Tentou atualizar cliente sem ID');
    await _colecao.doc(cliente.id).update(cliente.toMap());
  }

  Future<void> deletar(String id) async {
    await _colecao.doc(id).delete();
  }

  Stream<List<ClienteModel>> listarTodos() {
    return _colecao.orderBy('nome').snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => ClienteModel.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList();
    });
  }
}
