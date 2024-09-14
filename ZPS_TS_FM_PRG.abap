*&---------------------------------------------------------------------*
*& Report ZPS_TS_FM_PRG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPS_TS_FM_PRG.

DATA(z_name) = 'Parul'.
DATA(z_phn) = '+91-1234567891'.
DATA(Z_Time) = sy-uzeit.
DATA(Z_date) = sy-datum.

*                                                      Declare the necessary variables
DATA: lt_varname TYPE TABLE OF ZPS_VAR_name,
      lt_tline_tab TYPE TABLE OF tline,
      lt_message_tab TYPE Table of BAPIRET1.

Data :ls_varname TYPE ZPS_VAR_name,
      ls_tline TYPE tline,
      ls_message TYPE BAPIRET1.


ls_varname-symbol_name = 'Z_PHN'.
APPEND ls_varname TO lt_varname.

ls_varname-symbol_name = 'Z_DATE'.
APPEND ls_varname TO lt_varname.

ls_varname-symbol_name = 'Z_TIME'.
APPEND ls_varname TO lt_varname.

ls_varname-symbol_name = 'Z_NAME'.
APPEND ls_varname TO lt_varname.

CALL FUNCTION 'ZPS_TS_FM'
  EXPORTING
    t_name                 =  'ZPRB4_FM_TEST_UV'
    t_object               =  'TEXT'
    t_id                   =  'ST'
    prog_name              =  'ZPS_TS_FM_PRG'
    t_lang                 =  'E'
  TABLES
    lt_var_name            =   LT_VARNAME
    lt_tline               =   lt_tline_tab
    lt_mess                =   lt_message_tab
 EXCEPTIONS
   TEXT_NOT_FOUND         = 1
   SYMBOL_NOT_FOUND       = 2
   OTHERS                 = 3
          .

IF sy-subrc <> 0.
  MESSAGE 'Error Occurred' type 'E'.

  else.
   LOOP AT lt_tline_tab INTO ls_tline.       " Loop through each line of output
    WRITE : / ls_tline-tdline.            " Write the output text line
  ENDLOOP.
ENDIF.
