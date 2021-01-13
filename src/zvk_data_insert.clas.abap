CLASS zvk_data_insert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS add_user_data.
    METHODS reset_admin_all_user.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvk_data_insert IMPLEMENTATION.

  METHOD add_user_data.

    DATA: lt_type_use TYPE STANDARD TABLE OF zvk_userinfo.

    lt_type_use = VALUE #( ( first_name = 'ram' last_name = 'gee' user_email = 'ram@gmail.com' )
                            ( first_name = 'shyam' last_name = 'g' user_email = 'shyam@gmail.com' )
                            ( first_name = 'ghanshyam' last_name = 'jee' user_email = 'ghanshyam@gmail.com' ) ).

    INSERT zvk_userinfo FROM TABLE @lt_type_use.

  ENDMETHOD.

  METHOD reset_admin_all_user.
    UPDATE zvk_userinfo SET is_admin = 'NO'.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    reset_admin_all_user( ).
*    add_user_data( ).
*    out->write(
*      EXPORTING
*        data   = 'data inserted'
**        name   =
**      RECEIVING
**        output =
*    ).
  ENDMETHOD.

ENDCLASS.
