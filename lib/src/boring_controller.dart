class BoringController<T> {
  T? Function() getValue = () => null;
  bool Function() isValid = () => true;
  void Function(T? value)? _setValueFunction;

  void Function()? _validateFunction;
  void Function()? _resetFunction;
  void addValidationCallback(void Function() function) {
    _validateFunction = function;
  }

  void addResetCallback(void Function() function) {
    _resetFunction = function;
  }

  void setValue(T value) {
    _setValueFunction?.call(value);
  }

  void addSetValueCallback(void Function(T?) function) {
    _setValueFunction = function;
  }

  void validate() {
    _validateFunction?.call();
  }

  void reset() {
    _resetFunction?.call();
  }
}
