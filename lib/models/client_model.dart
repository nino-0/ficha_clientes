class Client {
  late String uuid;
  late String nome;
  late String telefone;
  late String rua;
  late int numeroCasa;

  Client({
    required this.uuid,
    required this.nome,
    required this.telefone,
    required this.rua,
    required this.numeroCasa,
  });

  Client.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] ?? "";
    nome = json['nome'] ?? "";
    telefone = json['telefone'] ?? "";
    rua = json['rua'] ?? "";
    numeroCasa = json['numero_casa'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['rua'] = this.rua;
    data['numero_casa'] = this.numeroCasa;
    return data;
  }
}
