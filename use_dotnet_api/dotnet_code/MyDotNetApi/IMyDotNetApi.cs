using System.Runtime.InteropServices;

[ComVisible(true)]
[Guid("A4902B72-7B6A-4D4F-8EAB-24F341D0DA7E")]
[InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
public interface IMyDotNetApi
{
    void Add(int val1, int val2, out int val3);

    void Echo(
        [MarshalAs(UnmanagedType.LPWStr)] string text,
        [MarshalAs(UnmanagedType.LPWStr)] out string echoText
    );
}
