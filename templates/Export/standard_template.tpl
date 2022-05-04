{*-------------------------------------------------------+
| SYSTOPIA Donation Receipts Extension                   |
| Default Template                                       |
| Copyright (C) 2013-2016 SYSTOPIA                       |
| Author: N.Bochan (bochan -at- systopia.de)             |
| http://www.systopia.de/                                |
+--------------------------------------------------------+
| License: AGPLv3, see LICENSE file                      |
+--------------------------------------------------------+
| Angepasst von ECOPLAN GmbH 2022	                     |
| Variablen:									         |
| unterschrifturl (H 50px), logourl (H 50px),            |
| unterzeichnername, finamt, stnr, finamt2, stnr2        |
| datum2, datum3, zeitraum,  				             |
| zwecke, zwecke2b, zwecke2b2,                  		 |
| beitragabzug (X bei nicht abzugfähigem Beitrag)	     |
| freistellung (X, wenn Freistellungsbescheid vorliegt)  |
| gesondert (X, wenn Voraussetzungen nach §60AO gilt)  	 |
+--------------------------------------------------------+

*}<?xml version="1.0" encoding="UTF-8"?>
<html>
<style>
{literal}
body {
  font-family: Helvetica,sans-serif !important;
  font-size: 8pt!important;
  margin: 0;
}

.box {
  padding: 0 0;
}

table {
  width: 100%;
  border-collapse: collapse;
  font-size: inherit!important;    /* Not sure why this is necessary when testing in Firefox... dompdf seems to work pefectly fine without it for a change. */
}

td, th {
  border: none;
  text-align: left;
}

/* Tables with headers appearing merged into content cells. */

table.merged th {
  font-size: 7pt!important;
  vertical-align: bottom;
  text-align: left;
  border-bottom: none;
  padding-bottom: 0!important;
}

table.merged td {
  vertical-align: top;
  text-align: left;
  border-top: none;
}

/* Variable content inserted into template. */
.var {
  font-size: 10pt!important;
}

.party th {
  font-weight: normal;
  text-align: left;
}

.party td {
  padding-top: .5em;
}

h1 {
  font-size: 12pt!important;
  font-style: normal!important;
  text-align: left!important;
  margin: 10px 0 10px 0 !important;
}

#crm-container {
    margin: 0 !important;
    font-family: Helvetica,sans-serif !important;
}

h2 {
  font-size: 10pt!important;    /* Same size as main heading, like in the official forms. */
}

h3 {
  font-size: 10pt!important;    /* Same size as main heading, like in the official forms. */
  text-align: right;
  margin-top: 1.5em;
  font-weight: normal;
}

#amounts {
  margin-top: 2em;
}

#amounts table {
  table-layout: fixed;    /* Doesn't actually work in dompdf... Need to explicitly set widths for each column if it's important :-( */
}

#amounts th {
  font-weight: normal;
  text-align: left;
}

#amounts td {
  padding-top: 1em;
}

#amounts #total {
  text-align: left;
}

#checks {
  margin-top: 3em;
}

#exempt {
  margin-top: 1.5em;
}

#exempt img {
  float: left;
  margin-right: -16px;    /* Workaround for dompdf's failure to overlap the following block's margin with the float, unless the float has exactly 0 layout width... */
}

#exempt #text {
  margin-left: 0;
  display: block;
}

.logoblock_linksoben {
	position: absolute;
	top: -20px;
	left: 0px;
}

.absenderblock_rechts {
  margin-left: 46em;
}


.footer {
  position: absolute;
  {/literal}
  {if $wk_enabled}top: 810px;{else}top: 855px;{/if}
  {literal}
  font-size: 7pt!important;
}

.firstpage {
    padding-top:10px;
    height:883px;
}

.main {
  position: absolute;
  top: 56mm;
}

.sender {
    font-size: 7pt!important;
	top: 60mm;
}

.notice {
    {/literal}
    {if $wk_enabled}
      {if !$items}font-size: 120%!important;{else}font-size: 110%!important;{/if}
    {else}
      font-size: 90%!important;
    {/if}
    {literal}
}

.signature {
  position: absolute;
  {/literal}
  {if !$items || $wk_enabled}top: 663px;{else}top: 688px;{/if}
  {literal}
}

.newpage {
  page-break-before: always;
}

#listing td.amount {
  text-align: left;
}

#listing #totals td, #listing #totals th {
  padding-top: 2em;
  border: none;
  text-align: left;
}

#listing #totals th {
  text-align: left;
}

#listing #totals .value {
  text-decoration: underline;
}

#listing .unit {
}

#listing #totals .unit {
  visibility: inherit;
}
{/literal}
</style>
<body>
<div class="logoblock_linksoben"><img alt="Logo" src="{$logourl}" style="height: 50px;" /></div>
<div class="firstpage">
<br/>
<div class="absenderblock_rechts">{$organisation.display_name}<br/> {$organisation.street_address}<br/>{if $organisation.supplemental_address_1}{$organisation.supplemental_address_1}<br/>{/if}{if $organisation.supplemental_address_2}{$organisation.supplemental_address_2}<br/>{/if}{$organisation.postal_code} {$organisation.city}<br/></div>
<p class="sender">
<u>{$organisation.display_name} · {$organisation.street_address} · {$organisation.postal_code} {$organisation.city}</u>
<br /><br />
{$addressee.display_name}<br />
{$addressee.street_address}<br />
{if $addressee.supplemental_address_1}{$addressee.supplemental_address_1}<br/>{/if}
{if $addressee.supplemental_address_2}{$addressee.supplemental_address_2}<br/>{/if}
{$addressee.postal_code} {$addressee.city}<br/>
{$addressee.country}<br/>
</p>
<br /><br /><br />

<div class="main">
<h1>{if $items}Sammelbestätigung{else}Bestätigung{/if} über Geldzuwendungen/Mitgliedsbeitrag [{$receipt_id}]</h1><br />
<p class="notice">im Sinne des § 10 b des Einkommensteuergesetztes an eine der in § 5 Abs. 1 Nr. 9 des
Körperschaftsteuergesetzes bezeichneten Körperschaften, Personenvereinigungen und Vermögensmassen</p>

<p class="notice">Name und Anschrift des Zuwendenden:<br /></p>
    {$contributor.display_name}<br />
    {$contributor.street_address}<br />
    {$contributor.postal_code} {$contributor.city}<br />
    {if $contributor.supplemental_address_1}{$contributor.supplemental_address_1}<br/>{/if}
    {if $contributor.supplemental_address_2}{$contributor.supplemental_address_2}<br/>{/if}
</p>
<br /><br />
<table class='merged'>
  <tr>
    <th>{if $items}Gesamtbetrag{else}Betrag{/if} der Zuwendung{if $items}<br/>{/if} - in Ziffern -</th>
    <th>- in Buchstaben -</th>
    <th>{if $items}Zeitraum der Sammelbestätigung{else}Tag der Zuwendung{/if}:</th>
  </tr>
  <tr class='var'>
    <td id='total'>**{$total|crmMoney:EUR}</td>
    <td>{$totaltext}</td>
    <td>
        {if $items}
            {$date_from|crmDate:'%d.%m.%Y'} - {$date_to|crmDate:'%d.%m.%Y'}
        {else}
            {* absolutly not elegant *}
            {foreach from=$lines item=item}
                {$item.receive_date|crmDate:'%d.%m.%Y'}
            {/foreach}
        {/if}
    </td>
  </tr>
</table>


{if !$items}
<h2>
Es handelt sich um den Verzicht auf die Erstattung von Aufwendungen Ja [ ] Nein [x]</h2>
{/if}

<p class="notice">
[{$freistellung}] Wir sind wegen {$zwecke} nach dem Freistellungsbescheids bzw. nach der Anlage zum Körperschaftsteuerbescheid des Finanzamtes {$finamt}, StNr. {$stnr} vom {$datum2} für den letzten Veranlagungszeitraum {$zeitraum} nach § 5 Abs. 1 Nr. 9 des Körperschaftsteuergesetzes von der Körperschaftsteuer und nach § 3 Nr. 6 des Gewerbesteuergesetzes von der Gewerbesteuer befreit. <br />
<br />
[{$gesondert}] Die Einhaltung der satzungsmäßigen Voraussetzungen nach den §§ 51, 59, 60 und 61 AO wurde vom {$finamt2}, StNr. {$stnr2} mit Bescheid vom {$datum3} nach § 60a AO gesondert festgestellt. Wir fördern nach unserer Satzung {$zwecke2b}.
<br /><p>
Es wird bestätigt, dass die Zuwendung nur für den Zweck der {$zwecke2b2} verwendet wird. 
<br />
<b>Nur für steuerbegünstigte Einrichtungen, bei denen die Mitgliedsbeiträge steuerlich nicht abziehbar sind: </b><br />
[{$beitragabzug}] Es wird bestätigt, dass es sich nicht um einen Mitgliedsbeitrag handelt, dessen Abzug nach § 10b Abs. 1 des Einkommensteuergesetzes ausgeschlossen ist.<br />

{if $items}
<br />
Ob es sich um den Verzicht auf Erstattung von Aufwendungen handelt, ist der Anlage zur Sammelbestätigung zu entnehmen.
{/if}
</p>

</div>
</div>
<div class="signature">
  {$organisation.city}, den {$today|crmDate:$config->dateformatFull}
    <p>
<img alt="Unterschrift" src="{$unterschrifturl}" style="height: 50px;" /></p>
<p>
{$unterzeichnername}</p>
</div>

<div class="footer">
  <p>
    <strong>Hinweis:</strong><br/>
    Wer vorsätzlich oder grob fahrlässig eine unrichtige Zuwendungsbestätigung
    erstellt oder veranlasst, dass Zuwendungen nicht zu den in der
    Zuwendungsbestätigung angegebenen steuerbegünstigten Zwecken verwendet
    werden, haftet für die entgangene Steuer (§&nbsp;10b&nbsp;Abs.&nbsp;4&nbsp;EStG,
    §9&nbsp;Abs.&nbsp;3&nbsp;KStG, §&nbsp;9&nbsp;Nr.&nbsp;5&nbsp;GewStG). Diese
    Bestätigung wird nicht als Nachweis für die steuerliche Berücksichtigung der
    Zuwendung anerkannt, wenn das Datum des Freistellungsbescheides länger als 5
    Jahre bzw. das Datum der Feststellung der Einhaltung der satzungsmäßigen
    Voraussetzungen nach §&nbsp;60a&nbsp;Abs.&nbsp;1&nbsp;AO länger als 3 Jahre
    seit Ausstellung des Bescheides zurückliegt (§&nbsp;63&nbsp;Abs.&nbsp;5&nbsp;AO). 034122 (2013) 
	<br/>Die maschinelle Erstellung und elektronische Übermittlung dieser Zuwendungsbescheinigung ist dem Finanzamt angezeigt.
  </p>
</div>

{if $items}
<div class="newpage">
<h2 class='box'>Anlage zur Sammelbestätigung vom {$today|crmDate:'%d.%m.%Y'} für {$contributor.display_name}</h2>
<table>
  <tr><th>Datum der Zuwendung</th><th>Art der Zuwendung</th><th>Verzicht auf die Erstattung von Aufwendungen</th><th>Betrag</th></tr>
  {foreach from=$items item=item}
    <tr><td>{$item.receive_date|date_format:"%d.%m.%Y"}</td><td>{$item.financial_type}</td><td>Nein</td><td class='amount'>{$item.total_amount|crmMoney:EUR}</td></tr>
  {/foreach}
  <tr id='totals'><th colspan='3'>Gesamtsumme</th><td class='amount'><span class='value'><b>**{$total|crmMoney:EUR}</b></span></span></td></tr>
</table>
</div>
{/if}
</body>
</html>
