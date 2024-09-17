class RefreshTokenResponse {
  final bool success;
  final RefreshTokenResponseBody body;

  RefreshTokenResponse({required this.success, required this.body});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      success: json['success'],
      body: RefreshTokenResponseBody.fromJson(json['body']),
    );
  }
}

class RefreshTokenResponseBody {
  final Token token;

  RefreshTokenResponseBody({required this.token});

  factory RefreshTokenResponseBody.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseBody(
      token: Token.fromJson(json['token']),
    );
  }
}

class Token {
  final String accessToken;
  final String chatToken;

  Token({required this.accessToken, required this.chatToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken'],
      chatToken: json['chatToken'],
    );
  }
}
