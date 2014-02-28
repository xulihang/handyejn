Type=Activity
Version=3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim WebView1 As WebView
	Dim Button1 As Button
	Dim EditText1 As EditText
	Dim Panel1 As Panel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("lib")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Button1_Click
    Dim su As StringUtils
    Dim encodedUrl As String
	encodedUrl = su.EncodeUrl(EditText1.Text, "UTF8")
    Dim result As Int
    result = Msgbox2("查询书名还是作者？", "选择", "书名", "", "作者",Null)
    If result = DialogResponse.Positive Then  
		WebView1.LoadUrl("http://202.195.144.48:8080/search?kw="&encodedUrl&"&xc=6&searchtype=title")
	Else
	    WebView1.LoadUrl("http://202.195.144.48:8080/search?kw="&encodedUrl&"&xc=6&searchtype=author")
	End If
End Sub


