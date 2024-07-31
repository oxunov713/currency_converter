class Convert {
  int? id;
  String? code;
  String? ccy;
  String? ccyNm_RU;
  String? ccyNm_UZ;
  String? ccyNm_UZC;
  String? ccyNm_EN;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  Convert({
    this.id,
    this.code,
    this.ccy,
    this.ccyNm_RU,
    this.ccyNm_UZ,
    this.ccyNm_UZC,
    this.ccyNm_EN,
    this.nominal,
    this.rate,
    this.diff,
    this.date,
  });

  factory Convert.fromJson(Map<String, Object?> json) => Convert(
        id: json["id"] as int?,
        code: json["Code"] as String?,
        ccy: json["Ccy"] as String?,
        ccyNm_RU: json["CcyNm_RU"] as String?,
        ccyNm_UZ: json["CcyNm_UZ"] as String?,
        ccyNm_UZC: json["CcyNm_UZC"] as String?,
        ccyNm_EN: json["CcyNm_EN"] as String?,
        nominal: json["Nominal"] as String?,
        rate: json["Rate"] as String?,
        diff: json["Diff"] as String?,
        date: json["Date"] as String?,
      );
}
