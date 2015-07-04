{extends file='./pages.tpl'}

{block name="content-bar"}
<div class="col-md-12">
    <a href="{router page='admin'}content-pages/add/" class="btn btn-primary mb15"><i class="glyphicon glyphicon-plus"></i></a>
</div>
{/block}

{block name="content-body"}

<div class="col-md-12">

    {if $aParams.0=='add'}
        <h3 class="page-sub-header">{$aLang.action.admin.pages_create}</h3>
        {include file='./page_add.tpl'}
    {elseif $aParams.0=='edit'}
        <h3 class="page-sub-header">{$aLang.action.admin.pages_edit} «{$oPageEdit->getTitle()}»</h3>
    {include file='./page_add.tpl'}
    {/if}

    <div class="panel panel-default">
        <div class="panel-body no-padding">

            <div class="table table-striped-responsive"><table class="table table-striped pages-list">
                <thead>
                <tr>
                    <th class="span1">ID</th>
                    <th>{$aLang.action.admin.pages_admin_title}</th>
                    <th>{$aLang.action.admin.pages_admin_url}</th>
                    <th>{$aLang.action.admin.pages_admin_active}</th>
                    <th>{$aLang.action.admin.pages_admin_main}</th>
                    <th class="span2"></th>
                </tr>
                </thead>

                <tbody>
                    {foreach $aPages as $oPage}
                    <tr>
                        <td>
                            {$oPage->GetId()}
                        </td>
                        <td style="padding-left: {$oPage->getLevel()*20+10}px;">
                            {if $oPage->getLevel()==0}<i class="icon icon-folder-open"></i>{else}<i class="icon icon-file"></i>{/if}
                            <a href="{router page='page'}{$oPage->getUrlFull()}/">{$oPage->getTitle()}</a>
                        </td>
                        <td>
                            /{$oPage->getUrlFull()}/
                        </td>
                        <td class="center">
                            {if $oPage->getActive()}
							{$aLang.action.admin.pages_admin_active_yes}
						{else}
							{$aLang.action.admin.pages_admin_active_no}
						{/if}
                        </td>
                        <td class="center">
                            {if $oPage->getMain()}
							{$aLang.action.admin.pages_admin_active_yes}
						{else}
							{$aLang.action.admin.pages_admin_active_no}
						{/if}
                        </td>
                        <td class="center">
                            <a href="{router page='admin'}content-pages/edit/{$oPage->getId()}/"
                               title="{$aLang.action.admin.pages_admin_action_edit}" class=" i-block">
                                <i class="ion-ios7-compose"></i>
                            </a>
                            <a href="#" title="{$aLang.action.admin.pages_admin_action_delete}" class=" i-block"
                                  onclick="return admin.confirmDelete('{$oPage->getId()}', '{$oPage->getTitle()}'); return false;">
                                <i class="ion-ios7-trash"></i>
                            </a>
                            {if $oPage@first}
                                <i class="icon icon-arrow-up icon-gray"></i>
                            {else}
                                <a href="{router page='admin'}content-pages/sort/{$oPage->getId()}/up/?security_key={$ALTO_SECURITY_KEY}"
                                   title="{$aLang.action.admin.pages_admin_sort_up} ({$oPage->getSort()})" class=" i-block">
                                    <i class="icon icon-arrow-up"></i>
                                </a>
                            {/if}
                            {if $oPage@last}
                                <i class="icon icon-arrow-down icon-gray"></i>
                            {else}
                                <a href="{router page='admin'}content-pages/sort/{$oPage->getId()}/down/?security_key={$ALTO_SECURITY_KEY}"
                                   title="{$aLang.action.admin.pages_admin_sort_down} ({$oPage->getSort()})" class=" i-block">
                                    <i class="icon icon-arrow-down"></i>
                                </a>
                            {/if}
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table></div>
        </div>
    </div>

    {include file="inc.paging.tpl"}

</div>

<script>
    var admin = admin || { };

    admin.confirmDelete = function(id, title) {
        ls.modal.confirm(
                '{$aLang.action.admin.pages_admin_action_delete}',
                '{$aLang.action.admin.pages_admin_action_delete_message} "' + title + '"<br/>{$aLang.action.admin.pages_admin_action_delete_confirm}',
                function() {
                    document.location = "{router page='admin'}content-pages/delete/" + id + "/?security_key={$ALTO_SECURITY_KEY}";
                }
        );
    }
</script>

{/block}