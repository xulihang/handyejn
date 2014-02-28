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
	Dim job1 As HttpJob
	Dim WebView1 As WebView
	Dim Button1 As Button
	Dim Button2 As Button
	Dim EditText1 As EditText
	Dim Panel1 As Panel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("exercises")
    Button2.Enabled=False
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

   
Sub JobDone (job As HttpJob)
	Log("JobName = " & job.JobName & ", Success = " & job.Success)
	If job.Success = True Then
		Select job.JobName
			Case "Job1", "Job2"
				'print the result to the logs
				'Log(job.GetString)
				ProgressDialogHide
				File.WriteString(File.DirInternalCache,"times.html",job.GetString)
			Case "Job3"
				'show the downloaded image
				Activity.SetBackgroundImage(job.GetBitmap)
		End Select
	Else
		Log("Error: " & job.ErrorMessage)
		ToastMessageShow("Error: " & job.ErrorMessage, True)
		ProgressDialogHide
	End If
	job.Release
End Sub

Sub Button2_Click
	Dim Reader As TextReader
	Dim i=1 As Int
    Reader.Initialize(File.OpenInput(File.DirInternalCache, "times.html"))
    Dim line As String
    line = Reader.ReadLine
    Do While line <> Null
	    i=i+1
		If i=77 Then
		WebView1.LoadHtml(line)
		End If
        line = Reader.ReadLine
    Loop
    Reader.Close 
End Sub

Sub Button1_Click
    If IsNumber(EditText1.Text)=False Then
	ToastMessageShow("请输入数字",False)
    Else
	ProgressDialogShow("获取数据中...")
	job1.Initialize("Job1",Me)
    job1.Download("http://exercise.jiangnan.edu.cn/u/"&EditText1.Text&"/Rscount.aspx")
	Button2.Enabled=True
	End If
End Sub
