enum NetworkRequestMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const NetworkRequestMethod(this.method);
  final String method;
}
