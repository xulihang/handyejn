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
    Dim manager As PreferenceManager
	Dim screen As PreferenceScreen
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
	Dim authlink=manager.GetString("edit1") As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	If FirstTime Then
		CreatePreferenceScreen
		If manager.GetAll.Size = 0 Then SetDefaults
	End If
	Activity.LoadLayout("auth")
	Activity.AddMenuItem("设置","setting")
	ToastMessageShow("接入网站IP地址会有变化，请在设置里设置。",True)
    Log(authlink)
End Sub

Sub Activity_Resume
    HandleSettings
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
    job2.Download("http://"&authlink&"/F.html")
End Sub
Sub Button1_Click
    ProgressDialogShow("登录中...")
	job1.Initialize("Job1",Me)
    job1.PostString("http://"&authlink,"DDDDD="&EditText1.Text&"&upass="&EditText2.Text&"&0MKKey=C2%BC+Login")
End Sub



Sub Button3_Click
    ToastMessageShow("将用系统浏览器访问网址",False)
	Dim Intent1 As Intent
    Intent1.Initialize2("http://"&authlink, 0)
    StartActivity(Intent1) 
End Sub

Sub setting_Click
	StartActivity(screen.CreateIntent)
End Sub

Sub SetDefaults
	'defaults are only set on the first run.
	manager.SetString("edit1","210.28.16.3")
End Sub


Sub CreatePreferenceScreen
	screen.Initialize("设置", "")
	'create two categories
	Dim cat1 As PreferenceCategory
	cat1.Initialize("提示")
	cat1.AddEditText("edit1", "设置接入地址", "根据校园网接入网站IP地址设置", "210.28.16.3")
		
	'add the categories to the main screen
	screen.AddPreferenceCategory(cat1)
End Sub

Sub HandleSettings
	authlink=manager.GetString("edit1")
	Log(authlink)
End Sub