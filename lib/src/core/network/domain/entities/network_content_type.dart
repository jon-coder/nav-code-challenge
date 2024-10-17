enum NetworkContentType {
  json('application/json'),
  formUrlEncoded('application/x-www-form-urlencoded'),
  text('text/plain');

  const NetworkContentType(this.type);
  final String type;
}
