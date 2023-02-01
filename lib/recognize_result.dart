class RecognizeResult {
  final List<Observation> observations;

  RecognizeResult(this.observations);
}

class Observation {
  final List<double> rect;
  final List<String> textOptions;

  Observation(this.rect, this.textOptions);
}
