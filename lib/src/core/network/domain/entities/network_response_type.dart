enum NetworkResponseType {
  json('json'),
  stream('stream'),
  plain('plain'),
  bytes('bytes');

  const NetworkResponseType(this.responseType);
  final String responseType;
}
