class Label10n {
  String en;
  String? th;

  Label10n({
    required this.en,
    this.th,
  });

  String toStr(String loc) {
    return (loc == "th") ? (th ?? en) : en;
  }
}
