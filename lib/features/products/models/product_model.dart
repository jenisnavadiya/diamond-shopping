class ProductModel {
  final String? id;
  final int? qty;
  final dynamic lotId;
  final String? size;
  final double? carat;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;
  final String? cut;
  final String? polish;
  final String? symmetry;
  final String? fluorescence;
  final double? discount;
  final double? perCaratRate;
  final double? finalAmount;
  final String? keyToSymbol;
  final String? labComment;

  ProductModel({
    this.id,
    this.qty,
    this.lotId,
    this.size,
    this.carat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
    this.cut,
    this.polish,
    this.symmetry,
    this.fluorescence,
    this.discount,
    this.perCaratRate,
    this.finalAmount,
    this.keyToSymbol,
    this.labComment,
  });

  ProductModel copyWith({
    String? id,
    int? qty,
    dynamic lotId,
    String? size,
    double? carat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
    String? cut,
    String? polish,
    String? symmetry,
    String? fluorescence,
    double? discount,
    double? perCaratRate,
    double? finalAmount,
    String? keyToSymbol,
    String? labComment,
  }) =>
      ProductModel(
        id: id ?? this.id,
        qty: qty ?? this.qty,
        lotId: lotId ?? this.lotId,
        size: size ?? this.size,
        carat: carat ?? this.carat,
        lab: lab ?? this.lab,
        shape: shape ?? this.shape,
        color: color ?? this.color,
        clarity: clarity ?? this.clarity,
        cut: cut ?? this.cut,
        polish: polish ?? this.polish,
        symmetry: symmetry ?? this.symmetry,
        fluorescence: fluorescence ?? this.fluorescence,
        discount: discount ?? this.discount,
        perCaratRate: perCaratRate ?? this.perCaratRate,
        finalAmount: finalAmount ?? this.finalAmount,
        keyToSymbol: keyToSymbol ?? this.keyToSymbol,
        labComment: labComment ?? this.labComment,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
       id: json["id"],
        qty: json["Qty"],
        lotId: json["Lot ID"],
        size: json["Size"],
        carat: json["Carat"]?.toDouble(),
        lab: json["Lab"],
        shape: json["Shape"],
        color: json["Color"],
        clarity: json["Clarity"],
        cut: json["Cut"],
        polish: json["Polish"],
        symmetry: json["Symmetry"],
        fluorescence: json["Fluorescence"],
        discount: json["Discount"]?.toDouble(),
        perCaratRate: json["Per Carat Rate"]?.toDouble(),
        finalAmount: json["Final Amount"]?.toDouble(),
        keyToSymbol: json["Key To Symbol"],
        labComment: json["Lab Comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Qty": qty,
        "Lot ID": lotId,
        "Size": size,
        "Carat": carat,
        "Lab": lab,
        "Shape": shape,
        "Color": color,
        "Clarity": clarity,
        "Cut": cut,
        "Polish": polish,
        "Symmetry": symmetry,
        "Fluorescence": fluorescence,
        "Discount": discount,
        "Per Carat Rate": perCaratRate,
        "Final Amount": finalAmount,
        "Key To Symbol": keyToSymbol,
        "Lab Comment": labComment,
      };

  @override
  String toString() {
    return 'ProductModel(id: $id, qty: $qty, lotId: $lotId, size: $size, carat: $carat, lab: $lab, shape: $shape, color: $color, clarity: $clarity, cut: $cut, polish: $polish, symmetry: $symmetry, fluorescence: $fluorescence, discount: $discount, perCaratRate: $perCaratRate, finalAmount: $finalAmount, keyToSymbol: $keyToSymbol, labComment: $labComment)';
  }
}
