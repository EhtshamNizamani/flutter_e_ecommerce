class LoginResponse {
  final bool success;
  final LoginResponseBody body;

  LoginResponse({required this.success, required this.body});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      body: LoginResponseBody.fromJson(json['body']),
    );
  }
}

class LoginResponseBody {
  final Client client;
  final String accessToken;
  final String refreshToken;
  final String chatToken;

  LoginResponseBody({
    required this.client,
    required this.accessToken,
    required this.refreshToken,
    required this.chatToken,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) {
    return LoginResponseBody(
      client: Client.fromJson(json['client']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      chatToken: json['chatToken'],
    );
  }
}

class Client {
  final bool detailsAdded;
  final bool onboardingDone;
  final int id;
  final String email;
  final List<ClientClinician> clientClinicians;

  Client({
    required this.detailsAdded,
    required this.onboardingDone,
    required this.id,
    required this.email,
    required this.clientClinicians,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    var list = json['clientClinicians'] as List;
    List<ClientClinician> clientCliniciansList =
        list.map((e) => ClientClinician.fromJson(e)).toList();

    return Client(
      detailsAdded: json['detailsAdded'],
      onboardingDone: json['onboardingDone'],
      id: json['id'],
      email: json['email'],
      clientClinicians: clientCliniciansList,
    );
  }
}

class ClientClinician {
  final int id;
  final Clinician clinician;

  ClientClinician({required this.id, required this.clinician});

  factory ClientClinician.fromJson(Map<String, dynamic> json) {
    return ClientClinician(
      id: json['id'],
      clinician: Clinician.fromJson(json['clinician']),
    );
  }
}

class Clinician {
  final int id;
  final String email;

  Clinician({required this.id, required this.email});

  factory Clinician.fromJson(Map<String, dynamic> json) {
    return Clinician(
      id: json['id'],
      email: json['email'],
    );
  }
}
