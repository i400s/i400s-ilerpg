
      *-------------------------------------------------------------------------
      * TEMPLATE API errors DS
      *-------------------------------------------------------------------------
     D t_QUSEC         DS                  based(pt_Template)
     D                                     qualified
     D  BytesProvided                10I 0
     D  BytesAvailable...
     D                               10I 0
     D  ExceptionID                   7A
     D  Reserved                      1A
     D  MessageData                 256A

      *-------------------------------------------------------------------------
      * TEMPLATE Convert case DS
      *-------------------------------------------------------------------------
     D t_QLGIDRCB00    DS                  based(pt_Template)
     D                                     qualified
     D  TypeOfRequest                10I 0
     D  CCSIDInput                   10I 0
     D  CaseRequest                  10I 0
     D  Reserved                     10A

      *-------------------------------------------------------------------------
      * API Convert case
      *-------------------------------------------------------------------------
     D QlgConvertCase...
     D                 PR                  extproc('QlgConvertCase')
     D  CtrlBlock                          likeds(t_QLGIDRCB00)
     D                                     const
     D  SetString                  2048A   options(*varsize)
     D                                     const
     D  GetString                  2048A   options(*varsize)
     D  Length                       10I 0 const
     D  APIError                           options(*varsize)
     D                                     likeds(t_QUSEC)
     D                                     const

      *-------------------------------------------------------------------------
      * API Send program message
      *-------------------------------------------------------------------------
     D QmhSndPgmMsg    PR                  extpgm('QMHSNDPM')
     D  MsgID                         7A   const
     D  MsgFile                      20A   const
     D  MsgData                     256A   options(*varsize)
     D                                     const
     D  MsgDataLength                10I 0 const
     D  MsgType                      10A   const
     D  CallStackEntry...
     D                              256A   options(*varsize)
     D                                     const
     D  CallStackCount...
     D                               10I 0 const
     D  MsgKey                        4A   const
     D  APIError                           options(*varsize)
     D                                     likeds(t_QUSEC)
     D                                     const

      *-------------------------------------------------------------------------
      * API Resend escape message
      *-------------------------------------------------------------------------
     D QmhReSndEscMsg  PR                  extpgm('QMHRSNEM')
     D  MsgKey                        4A   const
     D  APIError                           options(*varsize)
     D                                     const
     D                                     likeds(t_QUSEC)
     D  CallStackEntry...
     D                              256A   options(*varsize:
     D                                             *nopass)
     D                                     const
     D  CallStackEntryLength...
     D                               10I 0 options(*nopass)
     D                                     const
     D  FmtCallStackEntry...
     D                                8A   options(*nopass)
     D                                     const
     D  FromCallStackEntryAddress...
     D                                 *   options(*nopass)
     D                                     const
     D  FromCallStackCount...
     D                               10I 0 options(*nopass)
     D                                     const
     D
     D t_RSNM0100      DS                  based(pt_Template)
     D                                     qualified
     D  ToCallStackCount...
     D                               10I 0
     D  ToCallStackQualifier...
     D                               20A
     D  LenToCallStackEntry...
     D                               10I 0
     D  ToCallStackEntry...
     D                              256A

      *-------------------------------------------------------------------------
      * API Receive Program Message
      *-------------------------------------------------------------------------
     D QmhRcvPgmMsg    PR                  extpgm('QMHRCVPM')
     D  MsgInfo...
     D                                     options(*varsize)
     D                                     const
     D                                     likeds(t_RCVM0100)
     D  LenMsgInfo...
     D                               10I 0 const
     D  FmtName...
     D                                8A   const
     D  CallStackEntry...
     D                              256A   options(*varsize)
     D                                     const
     D  CallStackCounter...
     D                               10I 0 const
     D  MsgType...
     D                               10A   const
     D  MsgKey...
     D                                4A   const
     D  WaitTime...
     D                               10I 0 const
     D  MessageAction...
     D                               10A   const
     D  APIError                           options(*varsize)
     D                                     const
     D                                     likeds(t_QUSEC)
      *
     D t_RCVM0100      DS                  template
     D                                     qualified
     D                                     inz
     D  BytesReturned...
     D                               10I 0
     D  BytesAvailable...
     D                               10I 0
     D  MessageSeverity...
     D                               10I 0
     D  MessageId...
     D                                7A
     D  MessageType...
     D                                2A
     D  MessageKey...
     D                                4A
     D  Reserved...
     D                                7A
     D  CCSID_ConversionSts...
     D                               10I 0
     D  CCSID_MsgData...
     D                               10I 0
     D  MsgDataReturnedLength...
     D                               10I 0
     D  MsgDataAvailableLength...
     D                               10I 0
     D  MsgData...
     D                             8192A

      *-------------------------------------------------------------------------
      * API Promote Message
      *-------------------------------------------------------------------------
     D QmhPrmMsg       PR                  extpgm('QMHPRMM')
     D  InvocationPointer...
     D                                 *   const
     D  CallStackCounter...
     D                               10I 0 const
     D  MsgKey...
     D                                4A   const
     D  MessageId...
     D                                7A   const
     D  QualifiedMsgFile...
     D                               20A   const
     D  MsgData...
     D                             8192A   const
     D                                     options(*varsize)
     D  LengthOfMsgData...
     D                               10I 0 const
     D  MsgType...
     D                               10A   const
     D  MsgSeverity...
     D                               10I 0 const
     D  LogOption...
     D                                1A   const
     D  Priority...
     D                               10A   const
     D  NewMsgKey...
     D                                4A
     D  APIError                           const
     D                                     options(*varsize)
     D                                     likeds(t_QUSEC)
      *

      *-------------------------------------------------------------------------
      * API Retreive member description
      *-------------------------------------------------------------------------
     D QusrMbrDsc      PR                  extpgm('QUSRMBRD')
     D  MbrDesc...
     D                                     options(*varsize)
     D                                     const
     D                                     likeds(t_MBRD0100)
     D  LenMbrDesc...
     D                               10I 0 const
     D  FmtName...
     D                                8A   const
     D  QualFileName...
     D                               20A   const
     D  MbrName...
     D                               10A   const
     D  OverrideProcessing...
     D                                1A   const
     D  APIError                           options(*varsize)
     D                                     const
     D                                     likeds(t_QUSEC)
      *
     D t_MBRD0100      DS                  template
     D                                     qualified
     D                                     inz
     D  BytesReturned...
     D                               10I 0
     D  BytesAvailable...
     D                               10I 0
     D  FileName...
     D                               10A
     D  LibraryName...
     D                               10A
     D  MbrName...
     D                               10A
     D  FileAttribute...
     D                               10A
     D  SrcType...
     D                               10A
     D  CreationDateTime...
     D                               13A
     D  SrcChangeDateTime...
     D                               13A
     D  MbrTextDescription...
     D                               40A
     D  SrcFile...
     D                                1A

      *-------------------------------------------------------------------------
      * API Retrieve operational descriptor
      *-------------------------------------------------------------------------
     D t_CEEDOD        DS                  based(pt_Template)
     D                                     qualified
     D  ParmNo                       10I 0
     D  DescType                     10I 0
     D  DataType                     10I 0
     D  DescInfo1                    10I 0
     D  DescInfo2                    10I 0
     D  ParmLength                   10I 0
     D  APIError                     12A
     D CEEDOD          PR
     D  ParmNo                       10I 0 const
     D  DescType                     10I 0
     D  DataType                     10I 0
     D  DescInfo1                    10I 0
     D  DescInfo2                    10I 0
     D  ParmLength                   10I 0
     D  APIError                     12A   options(*omit)

      *-------------------------------------------------------------------------
      * API Register activation group exit procedure
      *-------------------------------------------------------------------------
     D CEE4RAGE        PR
     D  Procedure                      *   procptr const
     D  APIError                     12A   options(*omit)

      *-------------------------------------------------------------------------
      * BEGIN Global constants
      *-------------------------------------------------------------------------
     D MsgFileQCPF     C                   'QCPFMSG   *LIBL     '
     D MsgFileLMMSGF   C                   'LMMSGF    *LIBL     '
      *-------------------------------------------------------------------------
      * END Global constants
      *-------------------------------------------------------------------------

      *-------------------------------------------------------------------------
      * BEGIN Global variables
      *-------------------------------------------------------------------------

      *-------------------------------------------------------------------------
      * END Global variables
      *-------------------------------------------------------------------------

