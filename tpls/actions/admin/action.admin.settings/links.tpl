{extends file='./_settings.tpl'}
{block name="content-body-formcontent"}
    <div class="panel-heading">
        <h3 class="panel-title">{$aLang.action.admin.set_links_homepage}</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label class="col-sm-4 control-label">{$aLang.action.admin.set_links_homepage_label}</label>

            <div class="col-sm-8">
                <label class="col-sm-12 {if $sHomePageSelect == 'home'}checked{/if}">
                    <input type="radio" name="homepage" value="home" {if $sHomePageSelect == 'home'}checked{/if}/>
                    {$aLang.action.admin.set_links_homepage_home}
                </label>
                <label class="col-sm-12 {if $sHomePageSelect == 'index'}checked{/if}">
                    <input type="radio" name="homepage" value="index" {if $sHomePageSelect == 'index'}checked{/if}/>
                    {$aLang.action.admin.set_links_homepage_index}
                </label>

                <div class="form-group">
                    <div class="col-sm-4">
                        <label for="homepage" class="col-sm-12 {if $sHomePageSelect == 'page'}checked{/if}">
                            <input type="radio" name="homepage" value="page"
                                   {if $sHomePageSelect == 'page'}checked{/if}/>
                            {$aLang.action.admin.set_links_homepage_page}
                        </label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" name="page_url">
                            {foreach $aPages as $oPage}
                                <option value="{$oPage->getUrlFull()}"
                                        {if $oPage->getUrlFull()==$sHomePage}selected{/if}
                                        {if !$oPage->GetActive()}disabled="disabled"{/if}>
                                    {$oPage->getUrlPath()} :: {$oPage->GetTitle()}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                {hook run='admin_select_homepage'}
                <div class="form-group">
                    <div class="col-sm-4">
                        <label for="homepage" class="col-sm-12 {if $sHomePageSelect == 'other'}checked{/if}">
                            <input type="radio" name="homepage" value="other"
                                   {if $sHomePageSelect == 'other'}checked{/if}/>
                            {$aLang.action.admin.set_links_homepage_other}
                        </label>
                    </div>
                    <div class="col-sm-4">
                        <input name="other_url" value="{$sHomePageUrl}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel-heading">
        <h3 class="panel-title">{$aLang.action.admin.set_links_topics}</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label class="col-sm-4 control-label">{$aLang.action.admin.set_links_topics_mode}</label>

            <div class="col-sm-8">
                <div class="-box">
                    <label {if $sPermalinkMode == 'alto'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="alto" {if $sPermalinkMode == 'alto'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_alto}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}123.html
                        </span>
                        <span id="topic_link_alto" style="display: none;">%topic_id%.html</span>
                    </label>

                    <label {if $sPermalinkMode == 'friendly'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="friendly" {if $sPermalinkMode == 'friendly'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_friendly}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}sample-topic.html
                        </span>
                        <span id="topic_link_alto" style="display: none;">%topic_url%.html</span>
                    </label>

                    <label {if $sPermalinkMode == 'ls'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="ls" {if $sPermalinkMode == 'ls'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_ls}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}blog/blog-name/123.html
                        </span>
                        <span id="topic_link_ls" style="display: none;">blog/%blog_url%/%topic_id%.html</span>
                    </label>

                    <label {if $sPermalinkMode == 'id'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="id" {if $sPermalinkMode == 'id'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_id}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}123
                        </span>
                        <span id="topic_link_id" style="display: none;">%topic_id%</span>
                    </label>

                    <label {if $sPermalinkMode == 'day_name'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="day_name" {if $sPermalinkMode == 'day_name'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_day_name}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}2013/04/28/sample-topic/
                        </span>
                        <span id="topic_link_day_name" style="display: none;">%year%/%month%/%day%/%topic_url%</span>
                    </label>

                    <label {if $sPermalinkMode == 'month_name'}class="checked"{/if}>
                        <span class="col-sm-12">
                        <input type="radio" name="topic_link" value="month_name" {if $sPermalinkMode == 'month_name'}checked{/if}/>
                            {$aLang.action.admin.set_links_topics_mode_month_name}
                        </span>
                        <span class="col-sm-12 help-block">
                        {Config::Get('path.root.url')}2013/04/sample-topic/
                        </span>
                        <span id="topic_link_month_name" style="display: none;">%year%/%month%/%topic_url%</span>
                    </label>

                    <div class="form-group">
                        <div class="col-sm-4">
                            <label for="topic_link_url" class="col-sm-12 {if $sPermalinkMode == 'custom'}checked{/if}">
                                <input type="radio" name="topic_link" value="custom"
                                       {if $sPermalinkMode == 'custom'}checked{/if}/>
                                {$aLang.action.admin.set_links_topics_mode_custom}
                            </label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="topic_link_url" value="{$sPermalinkUrl}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">
                <span class="link-dotted"
                      onclick="$('#topic_link_help').slideToggle();">{$aLang.action.admin.set_links_topics_mode_help_title}</span>
            </label>

            <div class="col-sm-8">
                <div class="well" style="display: none;"
                     id="topic_link_help">{$aLang.action.admin.set_links_topics_mode_help_text|nl2br}</div>
            </div>
        </div>
    </div>
    <div class="panel-heading">
        <h3 class="panel-title">{$aLang.action.admin.set_links_drafts}</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label class="col-sm-4 control-label">{$aLang.action.admin.set_links_drafts_enable}</label>

            <div class="col-sm-8">
                <label class="col-sm-12 {if Config::Get('module.topic.draft_link')}checked{/if}">
                    <input type="radio" name="draft_link" value="on"
                           {if Config::Get('module.topic.draft_link')}checked{/if}/>
                    {$aLang.action.admin.word_yes}
                </label>
                <label class="col-sm-12 {if !Config::Get('module.topic.draft_link')}checked{/if}">
                    <input type="radio" name="draft_link" value="off"
                           {if !Config::Get('module.topic.draft_link')}checked{/if}/>
                    {$aLang.action.admin.word_no}
                </label>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $('input[name=topic_link]').change(function () {
                var s = $('#topic_link_' + $(this).val());
                if (s.length && s.text()) {
                    $('input[name=topic_link_url]').val(s.text());
                }
                if ($(this).val() == 'custom') {
                    $('input[name=topic_link_url]').focus();
                }
            });
        });
    </script>
{/block}
{block name="content-body" append}
    <div class="col-md-12">
        <form action="" method="POST" class="form-horizontal" enctype="multipart/form-data">
            <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
            <input type="hidden" name="adm_cmd" value="generate_topics_url"/>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">{$aLang.action.admin.set_links_generate}</h3>
                </div>
                <div class="panel-body">
                    <div class="callout callout-warning">
                        <h4>{$aLang.action.admin.set_links_generate_count} <strong>{$nTopicsWithoutUrl}</strong></h4>

                        <p>{$aLang.action.admin.set_links_generate_text}</p>
                    </div>
                </div>
                <div class="panel-footer clearfix">
                    <input type="submit" name="submit_data_save" value="{$aLang.action.admin.set_links_generate_button}"
                           class="btn btn-primary pull-right"/>
                </div>
            </div>
        </form>
    </div>
{/block}