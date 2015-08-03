      /if defined(SrvMod)
     H nomain
      /endif
     H debug(*yes)
     H cvtopt(*datetime)
     H option(*srcstmt:*nodebugio)
     H copyright('Jonathan Wilson, i400s@hotmail.com')
      /if defined(DspFmt)
     H bnddir('SVCDSPFMT')
      /endif
      /if defined(SrvDta)
     H bnddir('SRVDTA')
      /endif
