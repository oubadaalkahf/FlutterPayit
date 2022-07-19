class TransactionModel {

  late final int id;
  late final String transactionId;
  late final String dateTransaction;
  late final String message;
  late final String emetteur;
  late final String destinataire;
  late final double montant;

  TransactionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    transactionId = json['transactionId'];
    dateTransaction = json['date_transaction'];
    message = json['message'];
    emetteur = json['emetteur'];
    destinataire = json['destinataire'];
    montant = json['montant'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['transactionId'] = transactionId;
    _data['date_transaction'] = dateTransaction;
    _data['message'] = message;
    _data['emetteur'] = emetteur;
    _data['destinataire'] = destinataire;
    _data['montant'] = montant;
    return _data;
  }
}