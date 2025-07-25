enum IntroEnums {
  insurance('assets/intro/Insurance.json'),
  billing('assets/intro/bill.json'),
  inventory('assets/intro/Inventory.json');

  const IntroEnums(this.toJson);
  final String toJson;
}
