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
	Dim job2 As HttpJob
	Dim Button1 As Button
	Dim Button2 As Button
	Dim Button3 As Button
	Dim EditText1 As EditText
	Dim EditText2 As EditText
	Dim Label1 As Label
	Dim Panel1 As Panel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("auth")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub JobDone (job As HttpJob)
	Log("JobName = " & job.JobName & ", Success = " & job.Success)
	If job.Success = True Then
		Select job.JobName
			Case "Job1"
				'print the result to the logs
				Log(job.GetString)
				ToastMessageShow("登录成功！",False)
				ProgressDialogHide
			Case "Job2"
				'show the downloaded image
				ToastMessageShow("注销成功！",False)
				ProgressDialogHide
		End Select
	Else
		Log("Error: " & job.ErrorMessage)
		ToastMessageShow("Error: " & job.ErrorMessage, True)
		ProgressDialogHide
	End If
	job.Release
End Sub

Sub Button2_Click
    ProgressDialogShow("注销中...")
	job2.Initialize("Job2",Me)
    job2.Download("http://210.28.16.3/F.html")
End Sub
Sub Button1_Click
    ProgressDialogShow("登录中...")
	job1.Initialize("Job1",Me)
    job1.PostString("http://210.28.16.3","DDDDD="&EditText1.Text&"&upass="&EditText2.Text&"&0MKKey=C2%BC+Login")
End Sub



Sub Button3_Click
    ToastMessageShow("将用系统浏览器访问网址",False)
	Dim Intent1 As Intent
    Intent1.Initialize2("http://210.28.16.3", 0)
    StartActivity(Intent1) 
End Sub