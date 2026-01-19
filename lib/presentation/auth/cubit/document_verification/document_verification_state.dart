class DocumentVerificationState {
  final String? frontImage;
  final String? backImage;
  final String? selfieImage;

  const DocumentVerificationState({
    this.frontImage,
    this.backImage,
    this.selfieImage,
  });


  bool get canContinueDocs => frontImage != null && backImage != null;


  bool get canContinuePassport => frontImage != null;

  bool get canContinueAll => frontImage != null && selfieImage != null;

  DocumentVerificationState copyWith({
    String? frontImage,
    String? backImage,
    String? selfieImage,
    bool clearFront = false,
    bool clearBack = false,
    bool clearSelfie = false,
  }) {
    return DocumentVerificationState(
      frontImage: clearFront ? null : (frontImage ?? this.frontImage),
      backImage: clearBack ? null : (backImage ?? this.backImage),
      selfieImage: clearSelfie ? null : (selfieImage ?? this.selfieImage),
    );
  }
}
