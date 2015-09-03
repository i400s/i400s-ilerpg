      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Global definitions and templates
      *-------------------------------------------------------------------------
     D t_AuthorKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   MARCTag                      3P 0
     D   Sequence                     3P 0
     D t_AuthorSubset...
     D                 DS                  Likeds(T_AuthorKeys)
     D                                     based(pt_Template)
     D t_AuthorRecord...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   AUISBN                      10A
     D   AUTAGC                       3P 0
     D   AUSEQN                       3P 0
     D   CreatedDTS                    Z
     D   ChangedDTS                    Z
     D   Name                      2048A   varying
     D t_Author...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   Keys                              likeds(t_AuthorKeys)
     D   Record                            likeds(t_AuthorRecord)
     D                                     dim(2)
      /if defined(SrvDta_)
     D t_MTAUTHSubset...
     D                 DS                  Likeds(T_AuthorSubset)
     D                                     based(pt_Template)
      /endif

     D t_BibliographicKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D t_BibliographicSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D   ImprintNo                    8P 0
     D   Deleted                      1A
     D t_BibliographicRecord...
     D               E DS                  qualified
     D                                     extname(MTBIBLP:MTBIBLF:*input)
     D                                     based(pt_Template)
     D t_Bibliographic...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   Keys                              likeds(t_BibliographicKeys)
     D   Record                            likeds(t_BibliographicRecord)
     D                                     dim(2)

     D t_SearchKeyPfx...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D t_ImprintPfx    DS                  qualified
     D                                     based(pt_Template)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D
     D
      /if defined(SrvDta_)
     D t_MTBIBLSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D  SupplierNo                    7  0
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  ImprintPfx                         likeds(t_ImprintPfx)
     D  Deleted                       1A
     D  ISBN                         10A
      /endif
      *-------------------------------------------------------------------------
      * END Global definitions and templates
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthor
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthor...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /endif

      /if defined(SRVDTA_GetAuthor)
      /undefine   SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthor...
     P                 B                   export
     D SRVDTA_GetAuthor...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*unique')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographic...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /endif

      /if defined(SRVDTA_GetBibliographic)
      /undefine   SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographic...
     P                 B                   export
     D SRVDTA_GetBibliographic...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*unique')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicFirst
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicFirst)
      /undefine   SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicFirst...
     P                 B                   export
     D SRVDTA_GetBibliographicFirst...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*first')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicLast
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicLast...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicLast)
      /undefine   SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicLast...
     P                 B                   export
     D SRVDTA_GetBibliographicLast...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*last')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicNext
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicNext)
      /undefine   SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicNext...
     P                 B                   export
     D SRVDTA_GetBibliographicNext...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*next')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicPrevious
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicPrevious...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicPrevious)
      /undefine   SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicPrevious...
     P                 B                   export
     D SRVDTA_GetBibliographicPrevious...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*previous')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if defined(SrvDta_)
      *-------------------------------------------------------------------------
      * BEGIN Internal procedures
      *-------------------------------------------------------------------------

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetAuthor
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetAuthor...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetAuthor
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetAuthor)
      /undefine   GetAuthor
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthor
      *-------------------------------------------------------------------------
     P GetAuthor...
     P                 B
     D GetAuthor...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetAuthor
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Author)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_AuthorRecord)
     D                                     inz

      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthor
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetAuthorRecord
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetAuthorRecord...
     D                 PR                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetAuthorRecord
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetAuthorRecord)
      /undefine   GetAuthorRecord
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthorRecord
      *-------------------------------------------------------------------------
     P GetAuthorRecord...
     P                 B
     D GetAuthorRecord...
     D                 PI                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetAuthorRecord
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_AuthorKeys)
     D                                     based(p_keys)
     D Subset          DS                  likeds(t_AuthorSubset)
     D                                     based(p_Subset)
     D Sequence        S              3I 0
     D RecordKeys      DS                  likeds(t_AuthorKeys)
     D                                     inz
     D RecordSubset    DS                  likeds(t_MTAUTHSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthorRecord
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHF
      * Description     : Get MTAUTHF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTAUTHF...
     D                 PR                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHF
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTAUTHF)
      /undefine   GetMTAUTHF
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHF
      *-------------------------------------------------------------------------
     P GetMTAUTHF...
     P                 B
     D GetMTAUTHF...
     D                 PI                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  Keys                               Likeds(t_AuthorKeys)
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHF
      *-------------------------------------------------------------------------
     D FileRecord      DS                  likerec(MTAUTHF:*input)
     D                                     inz
     D FileKeys        DS                  likerec(MTAUTHF:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHF
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMTAUTHIsValid
      * Description     : Check MTAUTH record is valid
      * Returns         :< IsValid
      *                >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
     D ChkMTAUTHIsValid...
     D                 PR              N
     D  Record                             likerec(MTAUTHF:*input)
     D  Subset                             likeds(t_MTAUTHSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkMTAUTHIsValid)
      /undefine   ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
     P ChkMTAUTHIsValid...
     P                 B
     D ChkMTAUTHIsValid...
     D                 PI              N
     D  Record                             likerec(MTAUTHF:*input)
     D  Subset                             likeds(t_MTAUTHSubset)

      *-------------------------------------------------------------------------
      * Local Variables : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : VhkMTAUTHUsValid
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  Subset
      *-------------------------------------------------------------------------
     D GetMTAUTHSequence...
     D                 PR             3I 0
     D  Subset                             likeds(t_MTAUTHSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTAUTHSequence)
      /undefine   GetMTAUTHSequence
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHSequence
      *-------------------------------------------------------------------------
     P GetMTAUTHSequence...
     P                 B
     D GetMTAUTHSequence...
     D                 PI             3I 0
     D  Subset                             likeds(t_MTAUTHSubset)

      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetBibliographic...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographic
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetBibliographic)
      /undefine   GetBibliographic
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographic
      *-------------------------------------------------------------------------
     P GetBibliographic...
     P                 B
     D GetBibliographic...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographic
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_BibliographicRecord)
     D                                     inz

      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographic
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographicRecord
      * Description     : Get Bibliographic record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetBibliographicRecord...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographicRecord
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetBibliographicRecord)
      /undefine   GetBibliographicRecord
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographicRecord
      *-------------------------------------------------------------------------
     P GetBibliographicRecord...
     P                 B
     D GetBibliographicRecord...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographicRecord
      *-------------------------------------------------------------------------
     D Sequence        S              3I 0
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
     D RecordKeys      DS                  likeds(t_BibliographicKeys)
     D                                     inz
     D RecordSubset    DS                  likeds(t_MTBIBLSubset)
     D                                     inz
     D SKSNLo          S             10A   inz(*allx'00')
     D SKSNHi          S             10A   inz(*allx'FF')
     D ISBNLo          S             10A   inz(*allx'00')
     D ISBNHi          S             10A   inz(*allx'FF')
      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographicRecord
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF1...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF1)
      /undefine   GetMTBIBLF1
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF1
      *-------------------------------------------------------------------------
     P GetMTBIBLF1...
     P                 B
     D GetMTBIBLF1...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF1
      *-------------------------------------------------------------------------
     D FileRecord      DS                  likerec(MTBIBLF1:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF1:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF2
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF2...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF2)
      /undefine   GetMTBIBLF2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF2
      *-------------------------------------------------------------------------
     P GetMTBIBLF2...
     P                 B
     D GetMTBIBLF2...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF2
      *-------------------------------------------------------------------------
     D FileRecord      DS                  likerec(MTBIBLF2:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF2:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF3
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF3...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF3)
      /undefine   GetMTBIBLF3
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF3
      *-------------------------------------------------------------------------
     P GetMTBIBLF3...
     P                 B
     D GetMTBIBLF3...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF3
      *-------------------------------------------------------------------------
     D FileRecord      DS                  likerec(MTBIBLF3:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF3:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF4
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF4...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF4
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF4)
      /undefine   GetMTBIBLF4
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF4
      *-------------------------------------------------------------------------
     P GetMTBIBLF4...
     P                 B
     D GetMTBIBLF4...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF4
      *-------------------------------------------------------------------------
     D FileRecord      DS                  likerec(MTBIBLF4:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF4:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF4
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMTBIBLIsValid
      * Description     : Check MTBIBL record is valid
      * Returns         :< IsValid
      *                >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
     D ChkMTBIBLIsValid...
     D                 PR              N
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkMTBIBLIsValid)
      /undefine   ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
     P ChkMTBIBLIsValid...
     P                 B
     D ChkMTBIBLIsValid...
     D                 PI              N
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)

      *-------------------------------------------------------------------------
      * Local Variables : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLIsValid
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  Subset
      *-------------------------------------------------------------------------
     D GetMTBIBLSequence...
     D                 PR             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLSequence)
      /undefine   GetMTBIBLSequence
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLSequence
      *-------------------------------------------------------------------------
     P GetMTBIBLSequence...
     P                 B
     D GetMTBIBLSequence...
     D                 PI             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetSearchKeyPfx
      * Description     : Get formatted SearchKeyPfx
      * Returns         :< SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D GetSearchKeyPfx...
     D                 PR                  likeds(t_SearchKeyPfx)
     D  SearchKey                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetSearchKeyPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetSearchKeyPfx)
      /undefine   GetSearchKeyPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetSearchKeyPfx
      *-------------------------------------------------------------------------
     P GetSearchKeyPfx...
     P                 B
     D GetSearchKeyPfx...
     D                 PI                  likeds(t_SearchKeyPfx)
     D  SearchKey                    10    const

      *-------------------------------------------------------------------------
      * Local Variables : GetSearchKeyPfx
      *-------------------------------------------------------------------------
     D SearchKeyPfx    DS                  likeds(t_SearchKeyPfx)
     D                                     inz
     D i               S              3I 0
      *-------------------------------------------------------------------------
      * END Procedure   : GetSearchKeyPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkSearchKeyPfx
      * Description     : Check SearchKeyPfx
      * Returns         :< IsValid
      *                >:  SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D ChkSearchKeyPfx...
     D                 PR              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkSearchKeyPfx)
      /undefine   ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
     P ChkSearchKeyPfx...
     P                 B
     D ChkSearchKeyPfx...
     D                 PI              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10

      *-------------------------------------------------------------------------
      * Local Variables : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkSearckKeyPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetImprintPfx
      * Description     : Get formatted ImprintPfx
      * Returns         :< ImprintPfx
      *                >:  ImprintNo
      *-------------------------------------------------------------------------
     D GetImprintPfx...
     D                 PR                  likeds(t_ImprintPfx)
     D  ImprintNo                     8P 0 const
      *-------------------------------------------------------------------------
      * END Prototype   : GetImprintPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetImprintPfx)
      /undefine   GetImprintPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetImprintPfx
      *-------------------------------------------------------------------------
     P GetImprintPfx...
     P                 B
     D GetImprintPfx...
     D                 PI                  likeds(t_ImprintPfx)
     D  ImprintNo                     8P 0 const

      *-------------------------------------------------------------------------
      * Local Variables : GetImprintPfx
      *-------------------------------------------------------------------------
     D ImprintPfx      DS                  likeds(t_ImprintPfx)
     D                                     inz
      *-------------------------------------------------------------------------
      * END Procedure   : GetImprintPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkImprintPfx
      * Description     : Check ImprintPfx
      * Returns         :< IsValid
      *                >:  ImprintPfx
      *                >:  ISBN
      *-------------------------------------------------------------------------
     D ChkImprintPfx...
     D                 PR              N
     D  ImprintPfx                         likeds(t_ImprintPfx)
     D  ISBN                         10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkImprintPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkImprintPfx)
      /undefine   ChkImprintPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkImprintPfx
      *-------------------------------------------------------------------------
     P ChkImprintPfx...
     P                 B
     D ChkImprintPfx...
     D                 PI              N
     D  ImprintPfx                         likeds(t_imprintPfx)
     D  ISBN                         10

      *-------------------------------------------------------------------------
      * Local Variables : ChkImprintPfx
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkImprintPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkISBN
      * Description     : Check ISBN
      * Returns         :< IsValid
      *                >:  ISBN1
      *                >:  ISBN2
      *-------------------------------------------------------------------------
     D ChkISBN...
     D                 PR              N
     D  ISBN1                        10
     D  ISBN2                        10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkISBN
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkISBN)
      /undefine   ChkISBN
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkISBN
      *-------------------------------------------------------------------------
     P ChkISBN...
     P                 B
     D ChkISBN...
     D                 PI              N
     D  ISBN1                        10
     D  ISBN2                        10

      *-------------------------------------------------------------------------
      * Local Variables : ChkISBN
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkISBN
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMARCTag
      * Description     : Check MARC tag
      * Returns         :< IsValid
      *                >:  TAGC1
      *                >:  TAGC2
      *-------------------------------------------------------------------------
     D ChkMARCTag...
     D                 PR              N
     D  TAGC1                         3P 0
     D  TAGC2                         3P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMARCTag
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkMARCTag)
      /undefine   ChkMARCTag
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMARCTag
      *-------------------------------------------------------------------------
     P ChkMARCTag...
     P                 B
     D ChkMARCTag...
     D                 PI              N
     D  TAGC1                         3P 0
     D  TAGC2                         3P 0

      *-------------------------------------------------------------------------
      * Local Variables : ChkMARCTag
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMARCTag
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMARCSequence
      * Description     : Check MARC sequence
      * Returns         :< IsValid
      *                >:  SEQN1
      *                >:  SEQN2
      *-------------------------------------------------------------------------
     D ChkMARCsequence...
     D                 PR              N
     D  SEQN1                         3P 0
     D  SEQN2                         3P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMARCSequence
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkMARCSequence)
      /undefine   ChkMARCSequence
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMARCSequence
      *-------------------------------------------------------------------------
     P ChkMARCSequence...
     P                 B
     D ChkMARCSequence...
     D                 PI              N
     D  SEQN1                         3P 0
     D  SEQN2                         3P 0

      *-------------------------------------------------------------------------
      * Local Variables : ChkMARCSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMARCSequence
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkGetParms
      * Description     : Check the parameters for the accessors
      * Returns         : IsValid
      * Parameter      >:  p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *
      *-------------------------------------------------------------------------
     D ChkGetParms...
     D                 PR             1N
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : ChkGetParms
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkGetParms)
      /undefine ChkGetParms
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkGetParms
      *-------------------------------------------------------------------------
     P ChkGetParms...
     P                 B
     D ChkGetParms...
     D                 PI             1N
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : ChkGetParms
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * END Procedure   : ChkGetParms
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : InzSrvPgm
      * Description     : Service program initialisation
      * Returns         : *none
      * Parameter       : *none
      *-------------------------------------------------------------------------
     D InzSrvPgm...
     D                 PR             1N
      *-------------------------------------------------------------------------
      * END Prototype   : InzSrvPgm
      *-------------------------------------------------------------------------
      /endif
      /if defined(InzSrvPgm)
      /undefine InzSrvPgm
      *-------------------------------------------------------------------------
      * BEGIN Procedure : InzSrvPgm
      *-------------------------------------------------------------------------
     P InzSrvPgm...
     P                 B
     D InzSrvPgm...
     D                 PI             1N

      *-------------------------------------------------------------------------
      * Local Variables : InzSrvPgm
      *-------------------------------------------------------------------------
     D IsInitialised   S              1N   static
     D OpenError       S              1N
      *-------------------------------------------------------------------------
      * END Procedure   : InzSrvPgm
      *-------------------------------------------------------------------------
      /EOF
      /endif

      *-------------------------------------------------------------------------
      * END Internal procedures
      *-------------------------------------------------------------------------
      /endif

      /define SrvDta_h
