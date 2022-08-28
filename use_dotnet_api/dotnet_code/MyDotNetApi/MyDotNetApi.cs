using System.Runtime.InteropServices;

namespace MyDotNetApi;

[ComVisible(true)]
[ClassInterface(ClassInterfaceType.None)]
[Guid("C5BC517E-4B8E-477C-9319-D90464465F54")]
public class MyDotNetApi : IMyDotNetApi
{
    void IMyDotNetApi.Add(int val1, int val2, out int val3)
    {
        val3 = val1 + val2;
    }

    void IMyDotNetApi.Echo(string text, out string echoText)
    {
        echoText = text;
    }
}