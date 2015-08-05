      *-------------------------------------------------------------------------
      * Description  : Data Service program/procedures
      * Programmer   : Jonathan Wilson
      * Date Created : 30/07/2015
      *-------------------------------------------------------------------------
      /define SrvMod
      /include qincprsrc,StdHSpec

      *-------------------------------------------------------------------------
      *     [AU] Author
     FMTAUTHP   IF   E           K DISK    usropn

      *
      *-------------------------------------------------------------------------
      * Global data and procedure specifications
      *-------------------------------------------------------------------------
      /include StdDSpec
      * Special define to remove "const" and make fields "reference" internally
      /define SrvDta_
      * Header file
      /include SrvDta_h

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetAuthor
       // Description     : Get Author
       // Returns         :< IsFound
       // Parameter      >:  Keys
       //                >:< Author
       //                ?:  KeysType
       //                ?:  Selection
       /define SRVDTA_GetAuthor
       /include SrvDta_H
       // ----------------------------------------------------------------------

       // test inputs
       if %parms < 2; // not enough parameters
          QmhSndPgmMsg('CPF24B4':      // Severe error whie addressing parameter list
                       MsgFileQCPF:    // Message file
                       '':             // Message data
                       0:              // Length of message data
                       '*ESCAPE':      // Message type
                       '*':            // Call stack entry
                       1:              // Call stack count
                       '':             // Message key
                       x'00000000');   // API error DS
       endif;

       if %parms >= 3; // Keys type passed
         p_KeysType = %addr(KeysType); // Set pointer
         if p_KeysType <> *null;
           QlgCtrlBlock.TypeOfRequest = 1;
           QlgCtrlBlock.CCSIDInput = 37;
           QlgCtrlBlock.CaseRequest = 0;
           QlgCtrlBlock.Reserved = *allx'00';
           QlgConvertCase(QlgCtrlBlock: // Control block
                          KeysType:        // Set
                          KeysType:        // Get
                          %len(keysType):  // Length of string
                          x'00000000');    // API error DS
           if KeysType = '*ALLKEY';
             p_KeysType = *null; // Unset pointer = '*ALLKEY'
             dump(a);
           else;
             QmhSndPgmMsg('MSG2010':      // Keys type '&1' is invalid
                          MsgFileLMMSGF:  // Message file
                          keysType:       // Message data
                          %len(KeysType): // Length of message data
                          '*ESCAPE':      // Message type
                          '*':            // Call stack entry
                          1:              // Call stack count
                          '':             // Message key
                          x'00000000');   // API error DS
           endif;
         endif;
       endif;

       if %parms >= 4; // Selection passed
         if %addr(Selection) <> *null;
           QmhSndPgmMsg('MSG2011':     // Selection is not allowed
                        MsgFileLMMSGF: // Message file
                        '':            // Message data
                         0:             // Length of message data
                        '*ESCAPE':     // Message type
                        '*':           // Call stack entry
                        1:             // Call stack count
                        '':            // Message key
                        x'00000000');  // API error DS
         endif;
       endif;

         if OpenMTAUTHP;
           Select;
             when p_KeysType = *null; // Default '*ALLKEY'
               p_AuthorKeys = %addr(Keys);
               setll (AuthorKeys.ISBN:
                      AuthorKeys.MARCTag:
                      AuthorKeys.Sequence) MTAUTHF;
               reade (AuthorKeys.ISBN:
                      AuthorKeys.MARCTag:
                      AuthorKeys.Sequence) MTAUTHF;
               if %eof(MTAUTHP);
                 return *off;
               else;
                 clear Author;
                 Author(1).ISBN = AUISBN;
                 Author(1).MARCTag = AUTAGC;
                 Author(1).Sequence = AUSEQN;
                 dow not %eof(MTAUTHP);
                   Author(1).Name += AUAUTN;
                   reade (AuthorKeys.ISBN:
                          AuthorKeys.MARCTag:
                          AuthorKeys.Sequence) MTAUTHF;
                 enddo;
                 Author(2) = Author(1);
                 return *on;
               endif;
             other; // Problem, flag as no record found
               return *off;
           endsl;
       endif;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       // Opens file and returns indicator showing success
       /define OpenMTAUTHP
       /include SrvDta_H
       // -------------------------------------------------------------------------
       If IsOpen;
         return IsOpen;
       else;
         monitor;
           open MTAUTHP;
           IsOpen = *on;
         on-error;
           IsOpen = *off;
         endmon;
         return IsOpen;
       endif;
      /end-free
     P                 E
