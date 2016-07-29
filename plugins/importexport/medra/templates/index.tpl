{**
 * plugins/importexport/medra/templates/index.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List of operations this plugin can perform
 *}
{strip}
{include file="common/header.tpl" pageTitle="plugins.importexport.medra.displayName"}
{/strip}

{if !empty($configurationErrors)}
	{assign var="allowExport" value=false}
{else}
	{assign var="allowExport" value=true}
{/if}

<script type="text/javascript">
	// Attach the JS file tab handler.
	$(function() {ldelim}
		$('#importExportTabs').pkpHandler('$.pkp.controllers.TabHandler');
	{rdelim});
</script>
<div id="importExportTabs">
	<ul>
		<li><a href="#settings-tab">{translate key="plugins.importexport.common.settings"}</a></li>
		{if $allowExport}
			{if $exportArticles}
				<li><a href="#exportSubmissions-tab">{translate key="plugins.importexport.common.export.articles"}</a></li>
			{/if}
			{if $exportIssues}
				<li><a href="#exportIssues-tab">{translate key="plugins.importexport.common.export.issues"}</a></li>
			{/if}
			{if $exportRepresentations}
				<li><a href="#exportRepresentations-tab">{translate key="plugins.importexport.common.export.representations"}</a></li>
			{/if}
		{/if}
	</ul>
	<div id="settings-tab">
		{if !$allowExport}
			<div class="pkp_notification" id="medraConfigurationErrors">
				{foreach from=$configurationErrors item=configurationError}
					{if $configurationError == $smarty.const.DOI_EXPORT_CONFIG_ERROR_DOIPREFIX}
						{include file="controllers/notification/inPlaceNotificationContent.tpl" notificationId=medraConfigurationErrors notificationStyleClass=notifyWarning notificationTitle="plugins.importexport.common.missingRequirements"|translate notificationContents="plugins.importexport.common.error.DOIsNotAvailable"|translate}
					{elseif $configurationError == $smarty.const.DOI_EXPORT_CONFIG_ERROR_SETTINGS}
						{include file="controllers/notification/inPlaceNotificationContent.tpl" notificationId=medraConfigurationErrors notificationStyleClass=notifyWarning notificationTitle="plugins.importexport.common.missingRequirements"|translate notificationContents="plugins.importexport.common.error.pluginNotConfigured"|translate}
					{/if}
				{/foreach}
				{if !$exportArticles && !$exportIssues && !$exportRepresentations}
					{include file="controllers/notification/inPlaceNotificationContent.tpl" notificationId=medraConfigurationErrors notificationStyleClass=notifyWarning notificationTitle="plugins.importexport.common.missingRequirements"|translate notificationContents="plugins.importexport.common.error.noDOIContentObjects"|translate}
				{/if}
			</div>
		{/if}	
			
		{url|assign:medraSettingsGridUrl router=$smarty.const.ROUTE_COMPONENT component="grid.settings.plugins.settingsPluginGridHandler" op="manage" plugin="MedraExportPlugin" category="importexport" verb="index" escape=false}
		{load_url_in_div id="medraSettingsGridContainer" url=$medraSettingsGridUrl}
	</div>

	{if $allowExport}
		{if $exportArticles}
			<div id="exportSubmissions-tab">
				<script type="text/javascript">
					$(function() {ldelim}
						// Attach the form handler.
						$('#exportSubmissionXmlForm').pkpHandler('$.pkp.controllers.form.FormHandler');
					{rdelim});
				</script>
				<form id="exportSubmissionXmlForm" class="pkp_form" action="{plugin_url path="exportSubmissions"}" method="post">
					<input type="hidden" name="tab" value="exportSubmissions-tab" />
					{fbvFormArea id="submissionsXmlForm"}
						{url|assign:submissionsListGridUrl router=$smarty.const.ROUTE_COMPONENT component="grid.pubIds.PubIdExportSubmissionsListGridHandler" op="fetchGrid" plugin="medra" category="importexport" escape=false}
						{load_url_in_div id="submissionsListGridContainer" url=$submissionsListGridUrl}
						{if !empty($actionNames)}
							<ul class="pubids_export_actions">
								{foreach from=$actionNames key=action item=actionName}
									<li class="pubids_export_action">
										{fbvElement type="submit" label="$actionName" id="$action" name="$action" value="1" class="$action" translate=false inline=true}
									</li>
								{/foreach}
							</ul>
						{/if}
					{/fbvFormArea}
				</form>
				<p>{translate key="plugins.importexport.medra.workOrProduct"}</p>
			</div>
		{/if}
		{if $exportIssues}
			<div id="exportIssues-tab">
				<script type="text/javascript">
					$(function() {ldelim}
						// Attach the form handler.
						$('#exportIssueXmlForm').pkpHandler('$.pkp.controllers.form.FormHandler');
					{rdelim});
				</script>
				<form id="exportIssueXmlForm" class="pkp_form" action="{plugin_url path="exportIssues"}" method="post">
					<input type="hidden" name="tab" value="exportIssues-tab" />
					{fbvFormArea id="issuesXmlForm"}
						{url|assign:issuesListGridUrl router=$smarty.const.ROUTE_COMPONENT component="grid.pubIds.PubIdExportIssuesListGridHandler" op="fetchGrid" plugin="medra" category="importexport" escape=false}
						{load_url_in_div id="issuesListGridContainer" url=$issuesListGridUrl}
						{if !empty($actionNames)}
							<ul class="pubids_export_actions">
								{foreach from=$actionNames key=action item=actionName}
									<li class="pubids_export_action">
										{fbvElement type="submit" label="$actionName" id="$action" name="$action" value="1" class="$action" translate=false inline=true}
									</li>
								{/foreach}
							</ul>
						{/if}
					{/fbvFormArea}
				</form>
				<p>{translate key="plugins.importexport.medra.workOrProduct"}</p>
			</div>
		{/if}
		{if $exportRepresentations}
			<div id="exportRepresentations-tab">
				<script type="text/javascript">
					$(function() {ldelim}
						// Attach the form handler.
						$('#exportRepresentationXmlForm').pkpHandler('$.pkp.controllers.form.FormHandler');
					{rdelim});
				</script>
				<form id="exportRepresentationXmlForm" class="pkp_form" action="{plugin_url path="exportRepresentations"}" method="post">
					<input type="hidden" name="tab" value="exportRepresentations-tab" />
					{fbvFormArea id="representationsXmlForm"}
						{url|assign:representationsListGridUrl router=$smarty.const.ROUTE_COMPONENT component="grid.pubIds.PubIdExportRepresentationsListGridHandler" op="fetchGrid" plugin="medra" category="importexport" escape=false}
						{load_url_in_div id="representationsListGridContainer" url=$representationsListGridUrl}
						{if !empty($actionNames)}
							<ul class="pubids_export_actions">
								{foreach from=$actionNames key=action item=actionName}
									<li class="pubids_export_action">
										{fbvElement type="submit" label="$actionName" id="$action" name="$action" value="1" class="$action" translate=false inline=true}
									</li>
								{/foreach}
							</ul>
						{/if}
					{/fbvFormArea}
				</form>
				<p>{translate key="plugins.importexport.medra.workOrProduct"}</p>
			</div>
		{/if}
	{/if}
</div>

{include file="common/footer.tpl"}

