import 'package:flutter_oficina/core/constants/db_constants.dart';
import 'package:flutter_oficina/core/database/database_helper.dart';
import 'package:flutter_oficina/core/utils/logger.dart';
import 'package:flutter_oficina/features/domain/cliente_model.dart';

class ClienteService {
  Future<String> criar(ClienteModel cliente) async {
    AppLogger.info('Criando cliente: ${cliente.nome}', tag: 'ClienteService');

    final db = await DatabaseHelper.instance;
    final id = await db.insert(DbConstants.tabelaClientes, cliente.toMap());

    AppLogger.info('Cliente criado com ID: $id', tag: 'ClienteService');
    return id.toString();
  }

  Future<void> atualizar(ClienteModel cliente) async {
    if (cliente.id == null) throw Exception('Tentou atualizar cliente sem ID');
    final db = await DatabaseHelper.instance;
    await db.update(
      DbConstants.tabelaClientes,
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> deletar(String id) async {
    final db = await DatabaseHelper.instance;
    await db.delete(
      DbConstants.tabelaClientes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ClienteModel>> listarTodos() async {
    final db = await DatabaseHelper.instance;
    final maps = await db.query(
      DbConstants.tabelaClientes,
      orderBy: 'nome ASC',
    );
    return maps.map((m) => ClienteModel.fromMap(m['id'].toString(), m)).toList();
  }
}
