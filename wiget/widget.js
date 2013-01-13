var _GETS={};
var _URL="";
function _GetDIR(s)
{
	var t=s.toLowerCase();
	if(!t.indexOf("file:/") || !t.indexOf("http://") || !t.indexOf("https://"))
		return s.substr(0,s.lastIndexOf("/")+1);
	else return ""
}
function _GetRequest(l)
{
		var s=l.substr(l.indexOf('?')+1);
		var as=s.split("&"),re=/([^=]*)=(.*)/,r;
		for(var i=0;i<as.length;i++)
		{
			r=re.exec(as[i]);
			if(r)
				_GETS[r[1]]=r[2];
		}
}
function _GetJSRequest()
{
		var jsp,ss,jsr;
		if(document.getElementsByTagName)
			ss=document.getElementsByTagName("script");
		else if(document.all.tags)
			ss=document.all.tags("script");
		for(var j=ss.length-1;j>=0;j--)
		{
			jsr=ss[j].src;
			if(jsr&&jsr.indexOf("widget.js")!=-1)
			{
				_GetRequest(jsr);
				_URL=_GetDIR(jsr);
				break;
			}
		}
}
function showWidget()
{
	var s="<iframe"+
			" src=\""+_URL+_GETS["name"]+
			"?bgClr="+_GETS["bgClr"]+
			"\" width="+_GETS["width"]+
			"  height="+_GETS["height"]+
			" frameborder=0"+
			" style='border:"+_GETS["bdWid"]+"px solid "+_GETS["bdClr"]+";'"+
			" SCROLLING="+(_GETS["scrollbar"]==1?"yes":"no")+"></iframe>";
	document.write(s);
}
_GetJSRequest();
showWidget();