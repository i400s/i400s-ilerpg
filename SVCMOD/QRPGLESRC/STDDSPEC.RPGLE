
      *-------------------------------------------------------------------------
      * TEMPLATE API errors DS
      *-------------------------------------------------------------------------
     D t_QUSEC         DS                  based(pt_QUSEC)
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
     D t_QLGIDRCB00    DS                  based(pt_QLGIDRCB00)
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

