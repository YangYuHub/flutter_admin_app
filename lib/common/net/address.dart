import 'package:flutter_admin_app/common/config/config.dart';

///地址数据
class Address {
  static const String host = "https://api.github.com/";

  ///获取授权  post
  static getAuthorization() {
    return "${host}authorizations";
  }

  ///搜索 get
  static search(q, sort, order, type, page, [pageSize = Config.PAGE_SIZE]) {
    if (type == 'user') {
      return "${host}search/users?q=$q&page=$page&per_page=$pageSize";
    }
    sort ??= "best%20match";
    order ??= "desc";
    page ??= 1;
    pageSize ??= Config.PAGE_SIZE;
    return "${host}search/repositories?q=$q&sort=$sort&order=$order&page=$page&per_page=$pageSize";
  }
}
