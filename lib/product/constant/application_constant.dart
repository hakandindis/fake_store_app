class ApplicationConstant {
  static ApplicationConstant? _instance;
  static ApplicationConstant get instance {
    _instance ??= ApplicationConstant._init();

    return _instance!;
  }

  ApplicationConstant._init();

  final String baseUrl = 'https://fakestoreapi.com/';
  final String dummyImage = "https://picsum.photos/200/300";
}

double kZero = 0;
double kOne = 1;
