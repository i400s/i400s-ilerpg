             CMD        PROMPT('Work records: bibliographic')

             PARM       KWD(PGM) TYPE(*NAME) CONSTANT(WRKRCDBBL) PGM(*YES) PROMPT(*NONE)

             PARM       KWD(OPTION) TYPE(*CHAR) LEN(2) RSTD(*YES) DFT(*MAINTAIN) SPCVAL((*VIEW +
                          ' 5') (*SELECT 'F4') (*MAINTAIN '  ')) PROMPT('Program mode')

             PARM       KWD(FKY) TYPE(*CHAR) LEN(2) CONSTANT('  ') PROMPT(*NONE)


             PARM       KWD(CPC) TYPE(*LGL) CONSTANT('0') PROMPT(*NONE)


             PARM       KWD(SCHKEY) TYPE(*GENERIC) LEN(10) DFT(*ALL) SPCVAL((*ALL) (*BLANKS +
                          '')) PROMPT('Search key/short name')


             PARM       KWD(SUPNBR) TYPE(*DEC) LEN(7) DFT(*ALL) RANGE(1 9999999) SPCVAL((*ALL +
                          0)) PROMPT('Suppler number')


             PARM       KWD(IMPNBR) TYPE(*DEC) LEN(8) DFT(*ALL) RANGE(1 99999999) SPCVAL((*ALL +
                          0)) PROMPT('Imprint number')


             PARM       KWD(SHWDLD) TYPE(*NAME) RSTD(*YES) DFT(*NONE) SPCVAL((*ALLRECORDS *) +
                          (*NONE N) (*ONLY O)) PROMPT('Show deleted records')


             PARM       KWD(ISBN) TYPE(*CHAR) LEN(10) CONSTANT('*ALL') PROMPT(*NONE)


             PARM       KWD(EC) TYPE(*CHAR) LEN(10) CONSTANT('*IGNORE') PROMPT(*NONE)
