import 'package:geolocator/geolocator.dart';
import 'package:ride_app/assistants/request_assistant.dart';
import 'package:ride_app/config_maps.dart';

class AssistantMethods {
  static Future<String> searchCoordenateAddress(Position position) async {
    String placeAddress = '';
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
    }

    return placeAddress;
  }
}
