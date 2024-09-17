enum Mes{
  janeiro(1, 'Janeiro', 31),
  fevereiro(2, 'Fevereiro', 29),
  marco(3, 'Março', 31),
  abril(4, 'Abril', 30),
  maio(5, 'Maio', 31),
  junho(6, 'Junho', 30),
  julho(7, 'Julho', 31),
  agosto(8, 'Agosto', 31),
  setembro(9, 'Setembro', 30),
  outubro(10, 'Outubro', 31),
  novembro(11, 'Novembro', 30),
  dezembro(12, 'Dezembro', 31);

  const Mes(this.numero, this.nome, this.dias);
  final int numero;
  final String nome;
  final int dias;

}