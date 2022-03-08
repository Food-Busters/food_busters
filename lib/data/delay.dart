/// Simulate Server Request, Delay for 1 second
Future<void> serverRequest() async {
  await Future.delayed(const Duration(milliseconds: 1000));
}
