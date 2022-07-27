class PreparationDetailBean {
  late String tradeLabel;
  late String manufacturerName;
  late String packagingDesc;
  late String compositionDesc;
  late String compositionInn;
  late String compositionPharmForm;

  PreparationDetailBean.fromJson(Map<String, dynamic> json) {
    tradeLabel = json['trade_label']?['name'] ?? '';
    manufacturerName = json['manufacturer']?['name'] ?? '';
    packagingDesc = json['packaging']?['description'] ?? '';
    compositionDesc = json['composition']?['description'] ?? '';
    compositionInn = json['composition']?['inn']?['name'] ?? '';
    compositionPharmForm = json['composition']?['pharm_form']?['name'] ?? '';
  }
}
