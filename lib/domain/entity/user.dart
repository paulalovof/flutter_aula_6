class User {
  final int id;
  final String usuario;
  final String nome;
  final String email;
  final String telefone;
  final String senha;

  User({
    required this.id,
    required this.usuario,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha,
    dtNascimento,
  });

  User copyWith({
    int? id,
    String? usuario,
    String? nome,
    String? email,
    String? telefone,
    String? senha,
  }) {
    return User(
      id: id ?? this.id,
      usuario: usuario ?? this.usuario,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      senha: senha ?? this.senha,
    );
  }

  @override
  String toString() {
    return 'Usuario(id: $id, user: $usuario, nome: $nome, email: $email, telefone: $telefone, senha: $senha)';
  }
}
