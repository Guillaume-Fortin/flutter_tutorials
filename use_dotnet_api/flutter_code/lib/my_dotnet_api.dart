import 'package:win32/win32.dart';

import 'i_my_dotnet_api.dart';

const clsIdMyDotNetApi = '{C5BC517E-4B8E-477C-9319-D90464465F54}';

class MyDotNetApi extends IMyDotNetApi {
  MyDotNetApi(super.ptr);

  factory MyDotNetApi.createInstance() => MyDotNetApi(
        COMObject.createFromID(clsIdMyDotNetApi, iidIMyDotNetApi),
      );
}
