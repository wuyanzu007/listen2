class LogUtil {
  static const String _TAG_DEF = "Listen2";

  static bool debuggable = false; //是否是debug模式,true: log v 不输出.
  static String tag = _TAG_DEF;
  static void init({bool isDebug = false, String tagStr = _TAG_DEF}) {
    debuggable = isDebug;
    tag = tagStr;
  }

  //DEBUG 级别日志
  static void d(Object object, {String tag}) {
    if (debuggable) {
      _printLog(1, tag, '：', object);
    }
  }

  //INFO 级别日志
  static void i(Object object, {String tag}) {
    _printLog(2, tag, '：', object);
  }

  //WORN 级别日志
  static void w(Object object, {String tag}) {
    _printLog(3, tag, '：', object);
  }


  //ERROR 级别日志
  static void e(Object object, {String tag}) {
    _printLog(4, tag, '：', object);
  }

  static void _printLog(int level, String tagStr, String stag, Object object) {
    String da = object.toString();
    String _tag = (tagStr == null || tagStr.isEmpty) ? tag : tagStr;
    while (da.isNotEmpty) {
      if (da.length > 500) {
        print("$_tag $stag ${da.substring(0, 500)}");
        da = da.substring(500, da.length);
      } else {
        print("$_tag $stag $da");
        da = "";
      }
    }
  }
}
