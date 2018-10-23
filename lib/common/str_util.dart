class StringUtil {
  static List<String> matchImageSrc(String srcImageStr) {
    List<String> result = [];
    RegExp exp = new RegExp(r"<(img|IMG)(.*?)(/>|></img>|>)");
    for (var item in exp.allMatches(srcImageStr)) {
      String str_img = item.group(2);
      print('str_img == $str_img');
      RegExp p_src = new RegExp(r"""(src|SRC)=(\"|\')(.*?)(\"|\')""");
      if (str_img != null && str_img.isNotEmpty) {
        var match = p_src.firstMatch(str_img);
        if (match != null) {
          result.add(match.group(3));
        }
      }
    }
    return result;
  }

  static String getSrcImagePath(String srcImageStr) {
    List list = matchImageSrc(srcImageStr);
    String path = list?.first;

    print('src === $path');
    return path;
  }
}
