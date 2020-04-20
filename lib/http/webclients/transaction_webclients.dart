import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    // convertendo o json, que é uma string, para um objeto
    // Código original sem extrair para um método

    // final List<dynamic> decodedJson = jsonDecode(response.body);
    // final List<Transaction> transactions = List();
    // for (Map<String, dynamic> transactionJson in decodedJson) {
    //   final Map<String, dynamic> contactJson = transactionJson['contact'];
    //   final Transaction transaction = Transaction(
    //     transactionJson['value'],
    //     Contact(
    //       0,
    //       contactJson['name'],
    //       contactJson['accountNumber'],
    //     ),
    //   );
    //   transactions.add(transaction);
    // }
    
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {

      // Irei usar o JSON and serialization

      // final Map<String, dynamic> contactJson = transactionJson['contact'];
      // final Transaction transaction = Transaction(
      //   transactionJson['value'],
      //   Contact(
      //     0,
      //     contactJson['name'],
      //     contactJson['accountNumber'],
      //   ),
      // );
      // transactions.add(transaction);

      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {

    // Código original antes de extrair

    // final Map<String, dynamic> transactionMap = {
    //   'value': transaction.value,
    //   'contact': {
    //     'name': transaction.contact.name,
    //     'accountNumber': transaction.contact.accountNumber,
    //   }
    // };


    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson,
    );

    // Código original antes de extrair

    // Map<String, dynamic> json = jsonDecode(response.body);
    // final Map<String, dynamic> contactJson = json['contact'];
    // return Transaction(
    //   json['value'],
    //   Contact(
    //     0,
    //     contactJson['name'],
    //     contactJson['accountNumber'],
    //   ),
    // );

    return _toTransaction(response);
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    // Irei usar o JSON and serialization

    // final Map<String, dynamic> contactJson = json['contact'];
    // return Transaction(
    //   json['value'],
    //   Contact(
    //     0,
    //     contactJson['name'],
    //     contactJson['accountNumber'],
    //   ),
    // );

    return Transaction.fromJson(json);
  }
}
