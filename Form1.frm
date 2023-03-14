VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4635
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   4635
   ScaleWidth      =   4560
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command5 
      Caption         =   "close"
      Height          =   615
      Left            =   2760
      TabIndex        =   7
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton Command4 
      Caption         =   "read"
      Height          =   615
      Left            =   2640
      TabIndex        =   6
      Top             =   2640
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "write"
      Height          =   615
      Left            =   600
      TabIndex        =   5
      Top             =   2520
      Width           =   1695
   End
   Begin VB.TextBox Text2 
      Height          =   615
      Left            =   120
      TabIndex        =   4
      Text            =   "Text2"
      Top             =   1560
      Width           =   3975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "io con"
      Height          =   495
      Left            =   1200
      TabIndex        =   3
      Top             =   960
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "打开"
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   975
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   240
      Width           =   3855
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   3840
      Width           =   2655
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Const GENERIC_WRITE = &H40000000
Private Const GENERIC_READ As Long = &H80000000

Private Const OPEN_EXISTING = 3
Private Const FILE_SHARE_READ = &H1
Private Const FILE_SHARE_WRITE = &H2
Public lngHandle As Long
Public h2 As Long
Private Sub Command1_Click()

Dim sa As SECURITY_ATTRIBUTES
sa.nLength = Len(sa)
sa.bInheritHandle = 0&
'lngHandle = CreateFile(Text1.Text, GENERIC_WRITE, FILE_SHARE_READ Or FILE_SHARE_WRITE, sa, OPEN_EXISTING, 0, 0)
lngHandle = CreateFile(Text1.Text, GENERIC_READ Or GENERIC_WRITE, 0, sa, OPEN_EXISTING, 0, 0&)
Label1.Caption = lngHandle
End Sub

Private Sub Command2_Click()
Dim overlapped As overlapped
Dim diskGeometry As DISK_GEOMETRY
h2 = DeviceIoControl(lngHandle, IOCTL_DISK_GET_DRIVE_GEOMETRY, 0&, 0&, diskGeometry, Len(diskGeometry), _
                       bytesReturned, overlapped)
Label1.Caption = h2
End Sub

Private Sub Command3_Click()
Dim buffer As String
Dim overlapped As overlapped
buffer = Text2.Text

 WriteFile lngHandle, ByVal buffer, Len(buffer), bytesWritten, overlapped
 CloseHandle lngHandle
End Sub

Private Sub Command4_Click()
    Dim buffer(1024) As Byte
    Dim bytesToRead As Long
    Dim bytesRead As Long
    Dim overlapped As overlapped
      bytesToRead = 1
            bytesRead = 0
            ReadFile lngHandle, buffer(0), bytesToRead, bytesRead, overlapped
            
            '将读取的数据显示在Text1控件中
            If bytesRead > 0 Then
                Text1.SelStart = Len(Text1.Text)
                Text1.SelText = Left$(buffer, bytesRead)
            End If

    


End Sub

Private Sub Command5_Click()
CloseHandle lngHandle
Label1.Caption = "0"
End Sub
