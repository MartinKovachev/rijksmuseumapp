import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rijksmuseumapp/app/core/const/api_endpoints.dart';
import 'package:rijksmuseumapp/app/core/errors/exceptions.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_details_model.dart';

import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_model.dart';

abstract class IRijksDataSource {
  /// Calls the endpoint to get all items.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<RijksItemModel>> getNextPageRijksItems();

  /// Calls the endpoint to get specific item details.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<RijksItemDetailsModel> getRijksItemDetails(String objectNumber);
}

@Injectable(as: IRijksDataSource)
class RijksDataSource implements IRijksDataSource {
  final http.Client client = http.Client();
  int _shownPagesCount = 1;

  @override
  Future<List<RijksItemModel>> getNextPageRijksItems() async {
    _shownPagesCount++;

    final response = await client.get(
      Uri.parse(ApiEndpoints.GET_RIJKS_ITEMS_URL + '&p=$_shownPagesCount'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['artObjects'])
          .map<RijksItemModel>((p) => RijksItemModel.fromJson(p))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RijksItemDetailsModel> getRijksItemDetails(String objectNumber) async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.GET_RIJKS_ITEM_DETAILS_URL +
          '$objectNumber?key=${ApiEndpoints.API_KEY}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return RijksItemDetailsModel.fromJson(responseJson['artObject']);
    } else {
      throw ServerException();
    }
  }
}
