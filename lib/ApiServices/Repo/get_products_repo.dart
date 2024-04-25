import 'package:api_task/ApiServices/api_routes.dart';
import 'package:api_task/Model/Response/products_response_model.dart';
import 'package:http/http.dart' as http;

class GetProductsRepo {
  static Future<ProductsResponseModel> getProductsRepo() async {
    ProductsResponseModel? data;
    try {
      http.Response response = await http.get(Uri.parse(ApiRoutes.getProducts));
      if (response.statusCode == 200) {
        data = productsResponseModelFromJson(response.body);
        // print('SUCCESS ${dete[0]}');
      } else {
        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR $e');
    }
    return data!;
  }
}
