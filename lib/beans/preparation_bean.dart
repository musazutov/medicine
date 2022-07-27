class PreparationBean {
  late int id;
  late String tradeLabel;
  late String manufacturerName;

  PreparationBean.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    tradeLabel = json['trade_label']?['name'] ?? '';
    manufacturerName = json['manufacturer']?['name'] ?? '';
  }
}
