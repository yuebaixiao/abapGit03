CLASS lsc_zbp_i_online_shop_c11 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.
ENDCLASS.
CLASS lsc_zbp_i_online_shop_c11 IMPLEMENTATION.
  METHOD save_modified.
    DATA : lt_online_shop_as TYPE STANDARD TABLE OF zshop_as_C11,
           ls_online_shop_as TYPE zshop_as_C11.
    IF zbp_i_online_shop_C11=>cv_pr_mapped-purchaserequisition IS NOT INITIAL.
      LOOP AT zbp_i_online_shop_C11=>cv_pr_mapped-purchaserequisition ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_purchaserequisitiontp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-purchaserequisition = ls_pr_key-purchaserequisition.

      ENDLOOP.

    ENDIF.
    IF create-online_shop IS NOT INITIAL.
      " Creates internal table with instance data
      lt_online_shop_as = CORRESPONDING #( create-online_shop ).
      lt_online_shop_as[ 1 ]-purchasereqn = ls_pr_key-purchaserequisition .
      INSERT zshop_as_C11 FROM TABLE @lt_online_shop_as.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
CLASS lhc_zbp_i_online_shop_c11 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
        IMPORTING keys REQUEST requested_authorizations FOR  online_shop RESULT result.
ENDCLASS.

CLASS lhc_zbp_i_online_shop_c11  IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  ENDCLASS.
