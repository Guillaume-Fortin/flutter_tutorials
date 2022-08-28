import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

const iidIMyDotNetApi = '{A4902B72-7B6A-4D4F-8EAB-24F341D0DA7E}';

class IMyDotNetApi extends IUnknown {
  // vtable begins at 3, is 1 entries long.
  IMyDotNetApi(super.ptr);

  void add(int val1, int val2, Pointer<Int32> result) => ptr.ref.vtable
          .elementAt(3)
          .cast<
              Pointer<
                  NativeFunction<
                      Void Function(Pointer, Int32, Int32, Pointer<Int32>)>>>()
          .value
          .asFunction<void Function(Pointer, int, int, Pointer<Int32>)>()(
      ptr.ref.lpVtbl, val1, val2, result);

  void echo(Pointer<Utf16> text, Pointer<Pointer<Utf16>> echoText) => ptr
      .ref.vtable
      .elementAt(4)
      .cast<
          Pointer<
              NativeFunction<
                  Void Function(
                      Pointer, Pointer<Utf16>, Pointer<Pointer<Utf16>>)>>>()
      .value
      .asFunction<
          void Function(Pointer, Pointer<Utf16>,
              Pointer<Pointer<Utf16>>)>()(ptr.ref.lpVtbl, text, echoText);
}
