{extends file='./blogs.tpl'}
{block name="content-bar"}
<div class="col-md-12">
  <a href="#" class="btn btn-primary pull-right disabled"><i class="glyphicon glyphicon-plus"></i></a>
  <ul class="nav nav-pills">
    <li class="{if $sMode=='all' || $sMode==''}active{/if}">
      <a href="{router page='admin'}content-blogs/list/">
      {$aLang.action.admin.blogs_all_types} <span class="label label-primary">{$nBlogsTotal}</span>
      </a>
    </li>
    {foreach $aBlogTypes as $oBlogType}
    <li class="{if $sMode==$oBlogType->GetTypeCode()}active{/if}">
      <a href="{router page='admin'}content-blogs/list/{$oBlogType->GetTypeCode()}/">
      {$oBlogType->GetName()} <span class="label label-primary">{$oBlogType->GetBlogsCount()}</span>
      </a>
    </li>
    {/foreach}
  </ul>
</div>
{/block}
{block name="content-body"}
<div class="col-md-12">
  <div class="panel panel-default">
    <div class="panel-body no-padding">
      <div class="table table-striped-responsive"><table class="table table-striped mresources-list">
        <thead>
          <tr>
            <th class="span1">ID</th>
            <th>Date</th>
            <th>User</th>
            <th>Url</th>
            <th>Preview</th>
            <th>Targets</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {foreach $aMresources as $oMresource}
          {$oUser = $oMresource->getUser()}
          <tr>
            <td class="number">{$oMresource->GetId()}</td>
            <td class="center">
              {$oMresource->GetDateAdd()}
            </td>
            <td class="name">
              {if $oUser}
              <a href="{$oUser->getProfileUrl()}">{$oUser->getDisplayName()}</a>
              {/if}
            </td>
            <td class="name">
              {if $oMresource->IsLink()}
              <i class="icon icon-globe"></i>
              {elseif $oMresource->IsType(ModuleMresource::TYPE_IMAGE)}
              <i class="icon icon-picture"></i>
              {elseif $oMresource->IsType(ModuleMresource::TYPE_IMAGE)}
              <i class="icon icon-stop"></i>
              {/if}
              {$oMresource->GetPathUrl()}
            </td>
            <td>
              {if $oMresource->GetImgUrl(100)}
              <img src="{$oMresource->GetImgUrl(100)}" alt="" class="i-img-preview-100x100"/>
              {/if}
            </td>
            <td class="center">
              {$oMresource->GetTargetsCount()}
            </td>
            <td>
              {if !$oMresource->GetTargetsCount()}
              <a href="#" title="{$aLang.action.admin.delete}" class=" i-block"
                onclick="return admin.confirmDelete('{$oMresource->getId()}', '{$oMresource->GetImgUrl(100)}');">
              <i class="ion-ios7-trash"></i>
              </a>
              {else}
              <!-- i class="ion-ios7-trash disabled"></i -->
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
<!-- modal -->
<div class="modal fade in" id="modal-mresource_delete">
  <div class="modal-dialog">
    <div class="modal-content">
      <header class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>{$aLang.action.admin.mresource_delete_confirm}</h3>
      </header>
      <form action="" method="POST" class="uniform">
        <div class="modal-body">
          <p></p>
          <p>{$aLang.action.admin.mresource_will_be_delete}</p>
          <input type="hidden" name="cmd" value="delete"/>
          <input type="hidden" name="mresource_id" value=""/>
          <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
          <input type="hidden" name="return-path" value="{Router::Url('link')}"/>
        </div>
        <div class="modal-footer">
          <button class="btn" data-dismiss="modal" aria-hidden="true">{$aLang.text_cancel}</button>
          <button type="submit" class="btn btn-primary">{$aLang.action.admin.delete}</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- /modal -->
<script>
  var admin = admin || { };
  
  admin.confirmDelete = function(id, imgUrl) {
      var modal = $('#modal-mresource_delete');
      var form = modal.find('form');
      form.find('h3').text(ls.lang.get('action.admin.mresource_delete_confirm'));
      form.find('form p:first').html('<img src="' + imgUrl + '">');
      form.find('[name=mresource_id]').val(id);
  
      modal.modal('show');
      return false;
  }
  
</script>
{/block}