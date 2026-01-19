class PortfolioState {
  final String name;
  final String? email;
  final String? selfiePath;
  final bool hasAssets; // demo toggle

  const PortfolioState({
    required this.name,
    required this.email,
    required this.selfiePath,
    required this.hasAssets,
  });

  PortfolioState copyWith({
    String? name,
    String? email,
    String? selfiePath,
    bool? hasAssets,
  }) {
    return PortfolioState(
      name: name ?? this.name,
      email: email ?? this.email,
      selfiePath: selfiePath ?? this.selfiePath,
      hasAssets: hasAssets ?? this.hasAssets,
    );
  }
}
