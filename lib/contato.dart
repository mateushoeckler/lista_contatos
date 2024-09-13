class Contato {

  final String nome;
  final String cargo;
  final String endereco;
  final String telefone;
  final String email;
  final String site;

  Contato({required this.nome, required this.cargo, required this.endereco, required this.telefone, required this.email, required this.site});

  static List<Contato> fromJson(Map<String, dynamic> json){
    return List.generate(length, (index){
      return Contato(
        nome: index.isEven  ? json['nome'] : 'Carlos Miguel',
        cargo: json['cargo'],
        endereco: json['endereco'],
        telefone: json['telefone'],
        email: json['email'],
        site: json['site']
      );
    });
  }

  static const int length = 20;

  static const Map<String, dynamic> json = {
    'nome': 'João Silva',
    'cargo': 'Gerente',
    'endereco': 'Rua dos Rico, 555',
    'telefone': '(99) 99999-9999',
    'email': 'joao@gmail.com',
    'site': 'sitedojoao.com.br',
  };


}

