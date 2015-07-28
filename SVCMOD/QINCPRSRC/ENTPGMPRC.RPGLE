     D SO1710_WrkRcdBbl...
     D                 PR                  EXTPGM('SO1710')
     D  e_Caller                     10A   CONST
     D  e_CallerOpt                   2A   CONST
     D  e_FunctionKey                 2A
     D  e_CallerCommits...
     D                                1N   CONST
     D  e_ShortName                  10A   CONST
     D  e_SupplierNumber...
     D                                7P 0 CONST
     D  e_ImprintNumber...
     D                                8P 0 CONST
     D  e_DeletedStatus...
     D                                1A   CONST
     D  e_ISBN                       10A
     D  e_EC                        272A
      /if defined(SO1710_WrkRcdBbl)
     D SO1710_WrkRcdBbl...
     D                 PI
     D  e_Caller                     10A   CONST
     D  e_CallerOpt                   2A   CONST
     D  e_FunctionKey                 2A
     D  e_CallerCommits...
     D                                1N   CONST
     D  e_ShortName                  10A   CONST
     D  e_SupplierNumber...
     D                                7P 0 CONST
     D  e_ImprintNumber...
     D                                8P 0 CONST
     D  e_DeletedStatus...
     D                                1A   CONST
     D  e_ISBN                       10A
     D  e_EC                        272A
      /undefine SO1710_WrkRcdBbl
      /endif
     D SO1720_WrkRcdImp...
     D                 PR                  EXTPGM('SO1720')
     D  e_Caller                     10A   CONST
     D  e_CallerOpt                   2A   CONST
     D  e_FunctionKey                 2A
     D  e_CallerCommits...
     D                                1N   CONST
     D  e_ShortName                  10A   CONST
     D  e_DeletedStatus...
     D                                1A   CONST
     D  e_ImprintNumber...
     D                                8P 0
     D  e_EC                        272A
      /if defined(SO1720_WrkRcdImp)
     D SO1720_WrkRcdImp...
     D                 PI
     D  e_Caller                     10A   CONST
     D  e_CallerOpt                   2A   CONST
     D  e_FunctionKey                 2A
     D  e_CallerCommits...
     D                                1N   CONST
     D  e_ShortName                  10A   CONST
     D  e_DeletedStatus...
     D                                1A   CONST
     D  e_ImprintNumber...
     D                                8P 0 CONST
     D  e_EC                        272A
      /undefine SO1720_WrkRcdImp
      /endif

     D QSndPgmMsg      PR                  EXTPGM('QMHSNDPM')
     D  MsgID                         7    const
     D  MsgFile                      20    const
     D  MsgData                     256    const
     D  MsgDataLength                10i 0 const
     D  MsgType                      10    const
     D  MsgQueue                     10    const
     D  MsgStackCount                10i 0 const
     D  MsgKey                        4    const
     D  e_EC                        272    const
