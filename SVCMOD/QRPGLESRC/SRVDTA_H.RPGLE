      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Global definitions and templates
      *-------------------------------------------------------------------------

     D t_Address       DS                  qualified
     D                                     based(pt_Template)
     D   Line                        40A   varying
     D                                     dim(4)

     D t_AuditStamp...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   CreatedByUSER...
     D                               10A
     D   CreatedByPGM...
     D                               10A
     D   CreatedDTS                    Z
     D   EditedByUSER...
     D                               10A
     D   EditedByPGM...
     D                               10A
     D   EditedDTS                     Z

     D t_ImprintKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ImprintNo                    8P 0
     D   ISBNImprint                 10A   varying
     D   SearchKey                   10A   varying
     D t_ImprintSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   SearchKey                   10A   varying
     D   Deleted                      1A
     D t_ImprintRecord...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ImprintNo                    8P 0
     D   ISBNImprint                 10A   varying
     D   Name                        40A   varying
     D   Address                           likeds(t_Address)
     D   SearchKey                   10A   varying
     D   IsDeleted                     N
     D   Audit                             likeds(t_AuditStamp)
     D t_Imprint...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   Keys                              likeds(t_ImprintKeys)
     D   Record                            likeds(t_ImprintRecord)
     D                                     dim(2)

     D t_AuthorKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   MARCTag                      3P 0
     D   Sequence                     3P 0
     D t_AuthorSubset...
     D                 DS                  Likeds(t_AuthorKeys)
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

     D t_BibliographicKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   SupplierNo                   7P 0
     D   SearchKey                   10A   varying
     D t_BibliographicSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   SupplierNo                   7P 0
     D   SearchKey                   10A   varying
     D   ISBNImprint                 10A   varying
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

      *-------------------------------------------------------------------------
      * END Global definitions and templates
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetImprint
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetImprint...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetImprint
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetImprintFirst
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetImprintFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetImprintFirst
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetImprintLast
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetImprintLast...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetImprintLast
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetImprintNext
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetImprintNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetImprintNext
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetImprintPrevious
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetImprintPrevious...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetImprintPrevious
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorFirst
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorLast
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorLast...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorNext
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorPrevious
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorPrevious...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetQualifiedSearchKey
      * Description     : Get Qualified SearchKey
      * Returns         :< QualifiedSearchKey
      * Parameter      >:  SearchKey
      *-------------------------------------------------------------------------
     D SRVDTA_GetQualifiedSearchKey...
     D                 PR            10A   varying
     D  SearchKey                    10A   varying
     D                                     const
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetQualifiedSearchKey
      *-------------------------------------------------------------------------
      /endif

      /if defined(SrvDta_)
      *-------------------------------------------------------------------------
      * BEGIN Internal procedures
      *-------------------------------------------------------------------------

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetImprint
      * Description     : Get Imprint
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetImprint...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetImprint
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetImprintRecord
      * Description     : Get Imprint record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetImprintRecord...
     D                 PR                  like(*in)
     D  Record                             likeds(t_ImprintRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetImprintRecord
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTIMPNF
      * Description     : Get MTBIBLF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTIMPNF...
     D                 PR                  like(*in)
     D  Record                             likeds(t_ImprintRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTIMPNF
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTIMPNF2
      * Description     : Get MTIMPNF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTIMPNF2...
     D                 PR                  like(*in)
     D  Record                             likeds(t_ImprintRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTIMPNF2
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMTIMPNIsValid
      * Description     : Check MTIMPN record is valid
      * Returns         :< IsValid
      *                >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
     D ChkMTIMPNIsValid...
     D                 PR              N
     D  Record                             likerec(MTIMPNF:*input)
     D  Subset                             likeds(t_ImprintSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTIMPNIsValid
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTIMPNSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTIMPNSequence...
     D                 PR             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTIMPNSequence
      *-------------------------------------------------------------------------
      /endif

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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetAuthorRecord
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHF
      * Description     : Get MTAUTHF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTAUTHF...
     D                 PR                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHF
      *-------------------------------------------------------------------------
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
     D  Subset                             likeds(t_AuthorSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTAUTHSequence...
     D                 PR             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHSequence
      *-------------------------------------------------------------------------
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographicRecord
      * Description     : Get Bibliographic record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF1...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF2
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF2...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF3
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF3...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF4
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF4...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF4
      *-------------------------------------------------------------------------
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
     D  Record                             likerec(MTBIBLF1:*input)
     D  Subset                             likeds(t_BibliographicSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLSequence...
     D                 PR             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetQualifiedGeneric
      * Description     : Get Qualified Generic
      * Returns         :< Qualified Generic
      * Parameter      >:  Generic
      *-------------------------------------------------------------------------
     D GetQualifiedGeneric...
     D                 PR            10A   varying
     D  Generic                      10A   varying
     D                                     const
      *-------------------------------------------------------------------------
      * END Prototype   : GetQualifiedGeneric
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetPartialHiValue
      * Description     : Get Partial and/or Hi-Value
      * Returns         :< PartialHiValue
      * Parameter      ?:  Partial
      *                ?:  Size
      *-------------------------------------------------------------------------
     D GetPartialHiValue...
     D                 PR           256A   opdesc
     D                                     varying
     D  Partial                     256A   varying
     D                                     options(*varsize:
     D                                             *nopass:
     D                                             *omit)
     D                                     const
     D  Size                         10I 0 options(*nopass)
     D                                     const
      *-------------------------------------------------------------------------
      * END Prototype   : GetPartialHiValue
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkSearchKey
      * Description     : Check SearchKey
      * Returns         :< IsValid
      * Parameter      >:  QualifiedSearchKey
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D ChkSearchKey...
     D                 PR              N
     D  SearchKey1                   10A   varying
     D  SearchKey2                   10A
      *-------------------------------------------------------------------------
      * END Prototype   : ChkSearchKey
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkISBNImprint
      * Description     : Check ISBN Imprint
      * Returns         :< IsValid
      * Parameter      >:  ISBNImprint
      *                >:  ISBN
      *-------------------------------------------------------------------------
     D ChkISBNImprint...
     D                 PR              N
     D  ISBNImprint                  10A   varying
     D  ISBN                         10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkISBNImprint
      *-------------------------------------------------------------------------
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkImprintNo
      * Description     : Check Imprint number
      * Returns         :< IsValid
      *                >:  ImprintNo1
      *                >:  ImprintNo2
      *-------------------------------------------------------------------------
     D ChkImprintNo...
     D                 PR              N
     D  ImprintNo1                    8P 0
     D  ImprintNo2                    8P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkImprintNo
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkSupplierNo
      * Description     : Check Supplier number
      * Returns         :< IsValid
      *                >:  SupplierNo1
      *                >:  SupplierNo2
      *-------------------------------------------------------------------------
     D ChkSupplierNo...
     D                 PR              N
     D  SupplierNo1                   7P 0
     D  SupplierNo2                   7P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkSupplierNo
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkDeleted
      * Description     : Check deleted status
      * Returns         :< IsValid
      *                >:  Deleted1
      *                >:  Deleted2
      *-------------------------------------------------------------------------
     D ChkDeleted...
     D                 PR              N
     D  Deleted1                      1A
     D  Deleted2                      1A
      *-------------------------------------------------------------------------
      * END Prototype   : ChkDeleted
      *-------------------------------------------------------------------------
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkIsPartial
      * Description     : Check length verses size
      * Returns         : IsValid
      * Parameter      >: Data
      *
      *-------------------------------------------------------------------------
     D ChkIsPartial...
     D                 PR             1N   opdesc
     D  Data                        256A   varying
     D                                     options(*varsize)
     D
      *-------------------------------------------------------------------------
      * END Prototype   : ChkIsPartial
      *-------------------------------------------------------------------------
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

      *-------------------------------------------------------------------------
      * END Internal procedures
      *-------------------------------------------------------------------------
      /endif

      /define SrvDta_h
