abstract class PointState {
  // ! Subjected to be change to server-based rather than local
  // ! for prototype demonstration only
  int _points = 398;

  int get points => _points;

  void addPoints(int points) {
    _points += points;
  }

  bool usePoints(int points) {
    if (_points < points) return false;
    _points -= points;
    return true;
  }

  bool _premium = false;

  bool get isPremiumUser => _premium;

  void assignPremium() {
    _premium = true;
  }
}
