

abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url , dynamic data);
  Future<dynamic> getPostApiResponse1(String url , dynamic data);
  Future<dynamic> getPostApiResponse2(String url , int data);

}