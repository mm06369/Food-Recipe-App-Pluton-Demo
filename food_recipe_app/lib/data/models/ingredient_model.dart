
class Measurement {
  final String unit;
  final double value;

  Measurement({required this.unit, required this.value});

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      unit: json['unit'],
      value: json['value'].toDouble(),
    );
  }
}

class Amount {
  final Measurement metric;

  Amount({required this.metric});

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      metric: Measurement.fromJson(json['metric']),
    );
  }
}


class Ingredient {
  final Amount amount;
  final String name;

  Ingredient({
    required this.amount,
    required this.name,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      amount: Amount.fromJson(json['amount']),
      name: json['name'],
    );
  }
}
