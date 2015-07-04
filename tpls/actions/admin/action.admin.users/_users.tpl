{extends file='_index.tpl'}
{block name="content-bar"}
<div class="col-md-12">
  <a href="#" class="btn btn-primary pull-right disabled"><i class="glyphicon glyphicon-plus"></i></a>
  <ul class="nav nav-pills">
    <li class="{if $sMode=='list'}active{/if}">
      <a href="{router page='admin'}users-list/list/">
      All users <span class="label label-primary">{$nCountUsers}</span>
      </a>
    </li>
    <li class="{if $sMode=='admins'}active{/if}">
      <a href="{router page='admin'}users-list/admins/">
      Admins <span class="label label-primary">{$nCountAdmins}</span>
      </a>
    </li>
  </ul>
</div>
{/block}
{block name="content-body"}
  <div class="col-md-9">
    {block name="content-body-main"}
    {/block}
  </div>
  <div class="col-md-3">
    {block name="content-body-sidebar"}
    <div class="panel panel-default" id="user-comands-switch">
      {hook run='admin_users_commands_switch_top'}
      {if $oUserProfile}
      {if $oUserProfile->IsBannedByLogin()}
        <div>
          <button class="btn-block btn btn-primary left" data-target="#admin_user_unban" data-toggle="collapse"
            data-parent="#user-comands-switch">
          <i class="icon icon-thumbs-up"></i>
          {$aLang.action.admin.users_unban}
          </button>
        </div>
      <div class="panel-body no-padding" style="padding-top:10px;">
        <div class="collapse" id="admin_user_unban">
          <form method="post" action="{$sFormAction}" class="well-well-small">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            {if $oUserProfile->getBanLine()}
            {$aLang.action.admin.ban_upto} {$oUserProfile->getBanLine()} <br/>
            {else}
            {$aLang.action.admin.ban_unlim} <br/>
            {/if}
            {$aLang.action.admin.ban_comment}: {$oUserProfile->getBanComment()}<br/>
            <br/>
            <input type="hidden" name="adm_user_list"
              value="{if $oUserProfile}{$oUserProfile->getId()}{/if}"/>
            <input type="hidden" name="return-path" value="{Router::Url('url')}"/>
            <input type="hidden" name="adm_user_cmd" value="adm_unban_user"/>
            <div class="panel-footer clearfix">
              <button type="submit" name="adm_action_submit" class="btn btn-primary">
              {$aLang.action.admin.users_unban}
              </button>
            </div>
          </form>
        </div>
      </div>
      {else}
      <div class="panel-heading no-padding">
        <div class="mb10">
          <button class="btn-block btn btn-primary left" data-target="#admin_user_ban" data-toggle="collapse"
            data-parent="#user-comands-switch">
          <i class="icon icon-ban"></i>
          {$aLang.action.admin.users_ban}
          </button>
        </div>
        <div class="collapse" id="admin_user_ban">
          <form method="post" action="{$sFormAction}" class="well-well-small">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <input type="hidden" name="adm_user_list" value="{if $oUserProfile}{$oUserProfile->getId()}{/if}"/>
            <label>
            <input class="form-control" type="radio" name="ban_period" value="days" />
            {$aLang.action.admin.ban_for}
            <input type="text" class="form-control" name="ban_days" id="ban_days"
              class="num1"/> {$aLang.action.admin.ban_days}
            </label>
            <label>
            <input class="form-control" type="radio" name="ban_period" value="unlim" checked />
            {$aLang.action.admin.ban_unlim}
            </label>
            <label for="ban_comment">{$aLang.action.admin.ban_comment}</label>
            <input type="text" class="form-control" name="ban_comment" id="ban_comment" maxlength="255" class="input-wide form-control"/>
            <input type="hidden" name="return-path" value="{Router::Url('url')}"/>
            <input type="hidden" name="adm_user_cmd" value="adm_ban_user"/>
            <div class="panel-footer clearfix">
              <button type="submit" name="adm_action_submit" class="btn btn-danger">
              {$aLang.action.admin.users_ban}
              </button>
            </div>
          </form>
        </div>
      </div>
        <div class="panel-heading no-padding noborder">
          <button class="btn-block btn btn-danger left" data-target="#admin_user_del" data-toggle="collapse"
            data-parent="#user-comands-switch">
          {$aLang.action.admin.user_delete}
          </button>
        </div>
      <div class="panel-body no-padding">
        <div class="collapse" id="admin_user_del">
          <form method="post" action="{$sFormAction}" class="well-well-small">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <input type="hidden" name="adm_user_list" value="{$oUserProfile->getId()}"/>
            <div class="alert alert-danger">{$aLang.action.admin.users_del_warning}</div>
            <label>
            <input type="checkbox" name="adm_user_del_confirm" value="{$oUserProfile->getId()}" />
            {$aLang.action.admin.users_del_confirm}
            </label>
            <input type="hidden" name="return-path" value="{Router::Url('url')}"/>
            <input type="hidden" name="adm_user_cmd" value="adm_del_user"/>
          </form>
        </div>
      </div>
            <div class="panel-footer clearfix">
              <button type="submit" name="adm_action_submit" class="btn btn-danger">{$aLang.action.admin.user_delete}</button>
            </div>
      {/if}
      {/if}
      {if !$oUserProfile}
      <div class="panel-heading">
        <div>
          <button class="btn-block btn btn-primary left" data-target="#admin_form_seek" data-toggle="collapse"
            data-parent="#user-comands-switch">
          {if $aFilter}<i class="icon icon-filter icon-green pull-right"></i>{/if}
          {$aLang.action.admin.seek_users}
          </button>
        </div>
        <div class="panel-body no-padding  {if !$aFilter}collapse{/if} collapse-save" id="admin_form_seek">
          <form method="post" action="{router page='admin'}users-list/" class="well-well-small" id="user_filter_form">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <div class="input-group {if $aFilter.login}success{/if}">
              <label for="user_filter_login">{$aLang.action.admin.user_login}</label>
              <div class="input-group">
                <span class="input-group-addon"><i class="ion-android-contact"></i></span>
                <input type="text" class="form-control" name="user_filter_login" id="user_filter_login" value="{$aFilter.login}" class="wide form-control js-autocomplete-users"/>
              </div>
            </div>
            <div class="input-group {if $aFilter.email}success{/if}">
              <label for="user_filter_email">{$aLang.action.admin.user_email}</label>
              <div class="input-group">
                <span class="input-group-addon"><i class="ion-android-mail"></i></span>
                <input type="text" class="form-control" name="user_filter_email" id="user_filter_email" value="{$aFilter.email}" class="wide form-control"/>
              </div>
              <span class="help-block">{$aLang.action.admin.user_filter_email_notice}</span>
            </div>
            <div class="input-group {if $aFilter.regdate}success{/if}">
              <label for="user_filter_regdate">{$aLang.action.admin.users_date_reg}</label>
              <div class="input-group">
                <span class="input-group-addon"><i class="ion-ios7-calendar"></i></span>
                <input type="text" class="form-control datepicker" name="user_filter_regdate" id="user_filter_regdate" value="{$aFilter.regdate}" class="wide form-control"/>
              </div>
              <span class="help-block">{$aLang.action.admin.user_filter_regdate_notice}</span>
            </div>
            <div class="input-group {if $aFilter.ip}success{/if}">
              <label for="user_filter_ip1">{$aLang.action.admin.user_ip}</label>
              <input type="text" class="form-control" name="user_filter_ip1" id="user_filter_ip1" value="{$aFilter.ip.0}"
                maxlength="3"
                class="ip-part" placeholder="*"/>
              <input type="text" class="form-control" name="user_filter_ip2" id="user_filter_ip2" value="{$aFilter.ip.1}"
                maxlength="3"
                class="ip-part" placeholder="*"/>
              <input type="text" class="form-control" name="user_filter_ip3" id="user_filter_ip3" value="{$aFilter.ip.2}"
                maxlength="3"
                class="ip-part" placeholder="*"/>
              <input type="text" class="form-control" name="user_filter_ip4" id="user_filter_ip4" value="{$aFilter.ip.3}"
                maxlength="3"
                class="ip-part" placeholder="*"/>
              <span class="help-block">{$aLang.action.admin.user_filter_ip_notice}</span>
            </div>
            <input type="hidden" name="user_list_sort" id="user_list_sort" value="{$sUserListSort}"/>
            <input type="hidden" name="user_list_order" id="user_list_order" value="{$sUserListOrder}"/>
            <input type="hidden" name="return-path" value="{Router::Url('url')}"/>
            <input type="hidden" name="adm_userlist_filter" value="1"/>
            <button type="submit" name="adm_action_submit"
              class="btn btn-primary">{$aLang.action.admin.seek}</button>
            <button type="reset" name="adm_action_reset" class="btn btn-primary"
              onclick="admin.user.filterReset('#user_filter_form');return false;">{$aLang.action.admin.reset}</button>
          </form>
        </div>
      </div>
      <div class="panel-heading no-padding" style="border-top:0px" style="display: none;">
        <div>
          <button class="btn-block btn btn-primary left" data-target="#admin_form_send" data-toggle="collapse"
            data-parent="#user-comands-switch">
          <i class="icon icon-envelope"></i>
          {$aLang.user_write_prvmsg}
          </button>
        </div>
        <div class="collapse" id="admin_form_send">
          <form method="post" action="" class="well-well-small">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <div class="input-group">
              <label for="users_list">{$aLang.talk_create_users}:</label>
              <span class="users_list_view"></span>
              <input type="hidden" name="users_list" id="users_list" class="users_list"/>
            </div>
            <div class="input-group">
              <label>
              <input type="radio" name="send_common_message" id="send_common_message_yes" value="yes"
                onclick="AdminMessageSeparate(this.checked)"/>
              {$aLang.action.admin.send_common_message}
              </label>
              <label>
              <input type="radio" name="send_common_message" id="send_common_message_no" value="no"
                checked
                onclick="AdminMessageSeparate(!this.checked)"/>
              {$aLang.action.admin.send_separate_messages}
              </label>
              <span id="send_common_notice" class="help-block"
                style="display:none;">{$aLang.action.admin.send_common_notice}</span>
              <span id="send_separate_notice"
                class="help-block">{$aLang.action.admin.send_separate_notice}</span>
            </div>
            <div class="">
              <label for="talk_inbox_list">{$aLang.action.admin.talk_menu_inbox_list}</label>
              <select name="talk_inbox_list" id="talk_inbox_list" onchange="AdminMessageSelect();" class="wide form-control">
                <option value="0">-- {$aLang.talk_menu_inbox_create} --</option>
                {if $aTalks}
                {foreach from=$aTalks item=oTalk}
                <option value="{$oTalk->getId()}">{$oTalk->getTitle()|escape:'html'}</option>
                {/foreach}
                {/if}
              </select>
            </div>
            <div class="">
              <label for="talk_title">{$aLang.talk_create_title}:</label>
              <input type="text" class="form-control" name="talk_title" id="talk_title" maxlength="30" class="wide form-control"/>
            </div>
            <div class="" style="margin-bottom:5px;">
              <label for="talk_text">{$aLang.talk_create_text}:</label>
              <textarea name="talk_text" id="talk_text" cols="80" rows="12" class="wide form-control"></textarea>
            </div>
            <div class="input-group">
              <label for="send_copy_self">
              <input type="checkbox" name="send_copy_self" id="send_copy_self" checked/>
              {$aLang.action.admin.send_copy_self}
              </label>
            </div>
            <input type="hidden" name="return_url" value="{$sPageRef}"/>
            <input type="hidden" name="adm_user_cmd" value="adm_user_message"/>
            <button type="submit" name="adm_action_submit" class="btn btn-primary"
              onclick="return admin.user.messageSubmit(['{$aLang.talk_create_users_error}', '{$aLang.talk_create_title_error}', '{$aLang.talk_create_text_error}'])">
            {$aLang.talk_create_submit}
            </button>
          </form>
        </div>
      </div>
      {/if}
      <div class="panel-heading" style="border:0px;">
        <div>
          <button class="btn-block btn btn-primary left" data-target="#admin_user_setadmin" data-toggle="collapse"
            data-parent="#user-comands-switch">
          {$aLang.action.admin.include_admin}
          </button>
        </div>
        <div class="collapse" id="admin_user_setadmin">
          <form method="post" action="{router page='admin'}users-list/">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <div class="well-well-small">
              <div class="input-group">
                <label for="user_login_admin">{$aLang.action.admin.user_login}</label>
                <div class="input-group">
                  <span class="input-group-addon"><i class="ion-android-contact"></i></span>
                  <input type="text" class="form-control" name="user_login_admin" id="user_login_admin" class="wide form-control users_list js-autocomplete-users"/>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
              <div class="panel-footer clearfix">
                <input type="hidden" name="return-path" value="{Router::Url('url')}"/>
                <input type="hidden" name="adm_user_cmd" value="adm_user_setadmin"/>
                <button type="submit" name="adm_action_submit" class="btn btn-primary pull-right">
                {$aLang.action.admin.include}
                </button>
              </div>
      {hook run='admin_users_commands_switch_bottom'}
    </div>
    {/block}
  </div>
<script>
  var admin = admin || { };
  admin.user = admin.user || { };
  admin.user.filterReset = function(form) {
      form = $(form);
      form.find('input[type=text]').each(function(){
          $(this).val('').removeClass('success');
      });
      form.submit();
  };
</script>
{/block}