class Field{
  int _bombCount = 0;
  bool _isBomb = false;
  bool _isOpen = false;
  bool _isFlagged = false;

  int get bombCount => _bombCount;

  bool get isBomb => _isBomb;

  set isBomb(bool value) {
    _isBomb = value;
  }

  set bombCount(int value) {
    _bombCount = value;
  }

  bool get isOpen => _isOpen;

  bool get isFlagged => _isFlagged;

  set isFlagged(bool value) {
    _isFlagged = value;
  }

  set isOpen(bool value) {
    _isOpen = value;
  }
}
