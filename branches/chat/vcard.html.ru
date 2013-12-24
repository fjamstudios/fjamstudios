<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>JWChat - Визитная карточка - </title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <script src="shared.js"></script>
    <script src="switchStyle.js"></script>
    <script src="xmlextras.js"></script>
    <script src="jsjac.js"></script>
    <script>
      <!--
var jid , vcard;
var srcW; // the source window with necessary data

function sendSub() {
  var iq = new JSJaCIQ();
  iq.setType('set');
  
  var vCard = iq.appendNode('vCard', {'xmlns': 'vcard-temp'});
  
  for (var i=0; i<document.forms[0].elements.length; i++) {
    var item = document.forms[0].elements[i];
    if (item.id == '') continue;
    if (item.value == '' ) continue;
    if (item.id.indexOf('.') != -1) {
      var tagname = item.id.substring(0,item.id.indexOf('.'));
      var aNode;
      if (vCard.getElementsByTagName(tagname).length > 0)
	aNode = vCard.getElementsByTagName(tagname).item(0);
      else
	aNode = vCard.appendChild(iq.getDoc().createElement(tagname));
      aNode.appendChild(iq.getDoc().createElement(item.id.substring(item.id.indexOf('.')+1))).appendChild(iq.getDoc().createTextNode(item.value));
    } else {
      vCard.appendChild(iq.getDoc().createElement(item.id)).appendChild(iq.getDoc().createTextNode(item.value));
    }
  }
  srcW.Debug.log(iq.xml(),3);
  srcW.con.send(iq);
  window.close();
}

function init() {
  srcW = opener.top;
  
  getArgs();
  
  jid = passedArgs['jid'];
  document.title += jid;
  
  for (var i=0; i<document.forms[0].elements.length;i++) {
    if (document.forms[0].elements[i].id == '') continue;
    if (cutResource(jid) != srcW.cutResource(srcW.jid)) {
      document.forms[0].elements[i].className = "vcardBox";
      document.forms[0].elements[i].readOnly = true;
    }
  }
  
  if (cutResource(jid) != srcW.cutResource(srcW.jid))
    document.getElementById("savebox").style.display = 'none';
  
  // request vcard
  
  var iq = new JSJaCIQ();
  iq.setType('get');
  if (cutResource(jid) != srcW.cutResource(srcW.jid)) // not me
    iq.setTo(jid);
  iq.appendNode('vCard', {'xmlns': 'vcard-temp'});
  me = this;
  srcW.con.send(iq,me.handleVCard);
}

function handleVCard(iq) {
  if (!iq) {
    srcW.Debug.log('got empty iq result',1);
    return;
  }
  
  srcW.Debug.log(iq.xml(),3);
  
  if (iq.getNode().getElementsByTagName('vCard').item(0)) {
    for (var i=0; i<iq.getNode().getElementsByTagName('vCard').item(0).childNodes.length; i++) {
      var token = iq.getNode().getElementsByTagName('vCard').item(0).childNodes.item(i);
      tokenname = token.nodeName;
      if (token.firstChild && token.firstChild.nodeType != 3) { // found a container
	for (var j=0; j<token.childNodes.length; j++) {
	  if (typeof(document.forms[0].elements[tokenname+"."+token.childNodes.item(j).nodeName]) != 'undefined' && token.childNodes.item(j).firstChild)
	    document.forms[0].elements[tokenname+"."+token.childNodes.item(j).nodeName].value = token.childNodes.item(j).firstChild.nodeValue;
	}
	
      } else
	if (typeof(document.forms[0].elements[tokenname]) != 'undefined' && token.firstChild)
	  document.forms[0].elements[tokenname].value = token.firstChild.nodeValue;
    }
  }
}

function keyPressed(e) {
  if (e.keyCode == 27)
    window.close();
}
onkeydown = keyPressed;
		onload = init;
//-->
</script>
<script for="document" event="onkeydown()" language="JScript">
<!--
 if (window.event.keyCode == 27)
  window.close();
//-->
</script>
<style type="text/css">
/*<![CDATA[*/
 th { 
  font-family: sans-serif;
  font-size: 12px;
    text-align: right;
}
/*]]>*/
</style>
</head>
<body style="margin:8px">
<form>
    <fieldset>
      <legend>Имя</legend>
      <table>
          <tr><th nowrap>Полное имя:</th><td width="100%"><input type=text id="FN" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Фамилия:</th><td width="100%"><input type=text id="N.FAMILY" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Имя:</th><td width="100%"><input type=text id="N.GIVEN" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Ник:</th><td width="100%"><input type=text id="NICKNAME" class="vcardBoxEditable"></td></tr>
      </table>
    </fieldset>
    
    <fieldset>
      <legend>Информация</legend>
      <table>
          <tr><th nowrap>E-mail:</th><td width="100%"><input type=text id="EMAIL" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Сайт:</th><td width="100%"><input type=text id="URL" class="vcardBoxEditable"></td></tr>
      </table>
    </fieldset>
    
    <fieldset>
      <legend>Адрес</legend>
      <table>
          <tr><th nowrap>Адрес:</th><td width="100%"><input type=text id="ADR.STREET" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Адрес2:</th><td width="100%"><input type=text id="ADR.EXTADD" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Город:</th><td width="100%"><input type=text id="ADR.LOCALITY" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Штат:</th><td width="100%"><input type=text id="ADR.REGION" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Почтовый индекс:</th><td width="100%"><input type=text id="ADR.PCODE" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Страна:</th><td width="100%"><input type=text id="ADR.CTRY" class="vcardBoxEditable"></td></tr>
      </table>
    </fieldset>

    <fieldset>
      <legend>Организация</legend>
      <table>
          <tr><th nowrap>Имя:</th><td width="100%"><input type=text id="ORG.ORGNAME" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Подразделение:</th><td width="100%"><input type=text id="ORG.ORGUNIT" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Должность:</th><td width="100%"><input type=text id="TITLE" class="vcardBoxEditable"></td></tr>
          <tr><th nowrap>Роль:</th><td width="100%"><input type=text id="ROLE" class="vcardBoxEditable"></td></tr>
      </table>
    </fieldset>

    <fieldset>
      <legend>Информация</legend>
      <table width="100%">
          <tr><th>День рождения:</th><td width="100%"><input type=text id="BDAY" class="vcardBoxEditable"></td></tr>
		<tr><td colspan=2>&nbsp;</td></tr>
          <tr><th>Описание:</th><td width="100%">&nbsp;</td></tr>
          <tr><td colspan=2 width="100%"><textarea id="DESC" class="vcardBoxEditable" style="width:100%;" rows=4 wrap=virtual></textarea></td></tr>
      </table>
    </fieldset>
    <div id="savebox">
		<hr noshade size="1" size="100%">
		<div align="right">
			<button onClick="window.close();">Отменить</button>&nbsp;<button onClick="return sendSub();">Сохранить</button>
		</div>
      </div>
    </form>
	</body>
</html>
