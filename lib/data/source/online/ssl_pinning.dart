import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SSLPinning {
  static Future<http.Client> get _instance async => _clientInstance ??= await VerifyCertificate.getData();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}

class VerifyCertificate {
  static Future getData() async {
    final sslCert = await rootBundle.load('assets/movie.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}
