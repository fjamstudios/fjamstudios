<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>JWChat - Bericht</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <script src="shared.js"></script>
    <script src="browsercheck.js"></script>
    <script src="switchStyle.js"></script>
    <script src="jsjac.js"></script>
    <script>
      <!--
var jid;
var srcW; // the source window with necessary data
var msgbox;

function sendMSG() {
  var body = msgbox.value;
  
  if (body == '') // don't send empty message
    return false;

	var aMessage = new JSJaCMessage();
	aMessage.setTo(jid);
  aMessage.setBody(body);

  if(document.forms[0].subject.value != '')
		aMessage.setSubject(document.forms[0].subject.value);

	srcW.con.send(aMessage);
  
	// archive message
  /* [TODO] [zeank] 20051028
   * disabled by now as not compliant with latest version of jep
   */
//	if (srcW.enableLog && typeof(srcW.loghost) != 'undefined') {
//		var aIQ = new JSJaCIQ();
//		aIQ.setType('set');
//		aIQ.setTo(srcW.loghost);
// 		var aNode = aIQ.getNode().appendChild(aIQ.getDoc().createElement('archive'));
// 		aNode.setAttribute('xmlns','http://jabber.org/protocol/archive');
// 		aNode.appendChild(aMessage.getNode().cloneNode(true));
//		srcW.con.send(aIQ); 
// 	}
  
  if (!opener.roster && srcW.roster.getUserByJID(jid).messages.length == 0)
    opener.close();
  window.close();
  return false;
}

function init() {
  // determine source window
  if (opener.roster)
    srcW = opener.top;
  else
    srcW = opener.opener.top;
  
  msgbox = document.forms[0].msgbox;
  msgbox.focus();
			
  getArgs();

  jid = passedArgs['jid'];
  
  if (passedArgs['body']) { // quote messages
    var body = passedArgs['body'];
    body = body.replace(/^/g,"> ");
    body = body.replace(/\n/g,"\n> ");
    body += "\n";
    msgbox.value = body;
  }
  
  document.title = "Bericht verzenden naar "+srcW.roster.getUserByJID(jid).name;
}

function keyPressed(e) {
  if (e.ctrlKey && e.keyCode == 13)
    return sendMSG();
  else if (e.keyCode == 27)
    close();
}

onkeydown = keyPressed;
onload = init;
      //-->
    </script>
    <script for="document" event="onkeydown()" language="JScript">
      <!--
       if (window.event.ctrlKey && window.event.keyCode == 13)
         return sendMSG();
       if (window.event.keyCode == 27)
          window.close();
      //-->
    </script>
  </head>
  <body style="margin:8px;">
    <form name="msg" style="border:0;padding:0;margin:0;" onSubmit="return sendMSG();">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="margin-bottom: 8px;">
          <tr width="100%">
            <td>Onderwerp:&nbsp;</td><td width="100%"><input type="text" name="subject" size="20" style="width:100%;" tabindex="1"></td></tr>
          <tr height="100%"><td colspan="2" style="padding-top: 4px;"><textarea id="msgbox" wrap="physical" class="msgBox" tabindex="2"></textarea></td></tr>     
      
          <tr><td colspan="2"><hr noshade size="1" size="100%"></td></tr>
          <tr><td colspan="2" id="buttonbox" align="right"><button type="button" onClick="window.close();" tabindex="4">Annuleren</button>&nbsp;<button type="submit" tabindex="3">Verzenden</button></td></tr>
      </table>
    </form>
  </body>
</html>
