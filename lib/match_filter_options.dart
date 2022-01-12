library singleton;

var Singleton = new FilterOptions();

class FilterOptions {
  static final FilterOptions _instance = FilterOptions._internal();

  factory FilterOptions() {
    return _instance;
  }

  FilterOptions._internal() { //클래스가 최초 생성될때 1회 발생
    //초기화 코드
    _ntrp=null;
  }

  double? _ntrp;
  DateTime? _starttime;
  DateTime? _endtime;
  String? _location;


  DateTime? get starttime => _starttime;
  set starttime(DateTime? value) {
    _starttime = value;
  }

  DateTime? get endtime => _endtime;
  set endtime(DateTime? value) {
    _endtime = value;
  }


  double? get ntrp => _ntrp;
  set ntrp(double? value) {
    _ntrp = value;
  }

  String? get location => _location;
  set location(String? value) {
    _location = value;
  }
}