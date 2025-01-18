import 'package:flutterproiecttest1/AppConstants/AndroidEmulatorServerIpAddress.dart';

// Products.API Endpoints

const String getAllMakeupProductsAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5052/api/AllProducts/GetMakeupProducts";

const String getAllPerfumeProductsAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5052/api/AllProducts/GetPerfumeProducts";

const String getMakeupProductDetailsAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5052/api/Makeup";

const String getPerfumeProductDetailsAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5052/api/Perfume";

const String getDealersAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5052/api/DateCompletePartener/PreluareDatePartener";

// Client.ConturiClient.API Endpoints

const String getCustomerDataAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5169/api/Client/GetCustomerDataById";

const String loginCustomerAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5169/api/CustomerLogin/VerifyCustomerLoginCredentials";

const String registerCustomerAndroidEmulatorApiEndpoint =
    "http://$androidEmulatorServerIpAddress:5169/api/CustomerLogin";

const String updateCustomerProfileData =
    "http://$androidEmulatorServerIpAddress:5169/api/Client/UpdateClient";
