import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/controllers/auth_controller.dart';
import 'package:pet_care_app/controllers/location_controller.dart';
import 'package:pet_care_app/controllers/user_controller.dart';
import 'package:pet_care_app/models/address_model.dart';
import 'package:pet_care_app/pages/address/pick_address_map.dart';
import 'package:pet_care_app/routes/route_helper.dart';
import 'package:pet_care_app/utils/colors.dart';
import 'package:pet_care_app/utils/dimensions.dart';
import 'package:pet_care_app/widgets/app_icon.dart';
import 'package:pet_care_app/widgets/app_text_field.dart';
import 'package:pet_care_app/widgets/big_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAdressPage extends StatefulWidget {
  const AddAdressPage({Key? key}) : super(key: key);

  @override
  State<AddAdressPage> createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(10.7760941, 106.6658924), zoom: 17);
  late LatLng _initialPosition = LatLng(10.7760941, 106.6658924);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if(Get.find<LocationController>().getUserAddressFromLocalStorage() == ""){
        Get.find<LocationController>().saveUserAddress(Get
          .find<LocationController>()
          .addressList
          .last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang địa chỉ"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return  GetBuilder<LocationController>(builder: (locationController){
        _addressController.text= '${locationController.placemark.name??''}'
        '${locationController.placemark.locality??''}'
        '${locationController.placemark.postalCode??''}'
        '${locationController.placemark.country??''}';
        print("địa chỉ là: "+ _addressController.text);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2,
                  color: AppColors.mainColor
                )
              ),
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: 
                  CameraPosition(target: _initialPosition, zoom: 17),
                    onTap: (latlng){
                      Get.toNamed(RouteHelper.getPickAddressPage(),
                        arguments: PickAddressMap(
                          fromSignup: false,
                          fromAddress: true,
                          googleMapController: locationController.mapController,
                        )
                      );
                    },
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    onCameraIdle: (){
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition=position),
                    onMapCreated: (GoogleMapController controller){
                      locationController.setMapController(controller);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20),
              child: SizedBox(height: 50, child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: locationController.addressTypeList.length,
                itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    locationController.setAddressTypeIndex(index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,
                    vertical: Dimensions.height10),
                    margin: EdgeInsets.only(right: Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          spreadRadius: 1,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: Icon(
                          index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                          color: locationController.addressTypeIndex==index?
                          AppColors.mainColor:Theme.of(context).disabledColor,
                        )
                  ),
                );
              }),),
            ),
            SizedBox(height:Dimensions.height20,),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: BigText(text: "Địa chỉ giao hàng"),
            ),
            SizedBox(height:Dimensions.height10,),
            AppTextField(textController: _addressController, hintText: "Địa chỉ của bạn", icon: Icons.map),
            SizedBox(height:Dimensions.height20,),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: BigText(text: "Tên liên hệ"),
            ),
        
            // tên
            SizedBox(height:Dimensions.height10,),                  
            AppTextField(textController: _contactPersonName, hintText: "Tên của bạn", icon: Icons.person),
            SizedBox(height:Dimensions.height20,),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: BigText(text: "Số điện thoại của bạn"),
            ),
        
            // sdt
            SizedBox(height:Dimensions.height10,),
            AppTextField(textController: _contactPersonNumber, hintText: "Số điện thoại của bạn", icon: Icons.phone),
          ],
              ),
        );
      });
      }),
     bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
              Container(
                height: Dimensions.height20*8,
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),                          
                        );
                        locationController.addAddress(_addressModel).then((response){
                          if(response.isSuccess){
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Địa chỉ", "Thêm địa chỉ thành công");
                          }
                          else{
                            Get.snackbar("Địa chỉ", "Thêm địa chỉ không thành công");
                          }
                        });

                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          top: Dimensions.height15,
                          bottom: Dimensions.height15,
                        ),
                        child: BigText(
                          text:"Lưu địa chỉ",
                          color: Colors.white,
                          size: 26,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
