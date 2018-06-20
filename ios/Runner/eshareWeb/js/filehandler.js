function deleteForm(objForm) {
	var label = objForm;	
	while(label.hasChildNodes()) 
	{ 
        label.value = ""; 
		label.removeChild(label.lastChild); 
	}
    
    document.body.removeChild(objForm);
}

function jsPost(method,action,values) {
    var waitdiv = document.createElement("div");
  	waitdiv.id = "loadingflag";
  	waitdiv.style.display = "none";
    document.body.appendChild(waitdiv);
    
    var postForm = document.createElement("form");
    postForm.id = "subform";
    postForm.setAttribute('method', method);   
    postForm.setAttribute('action', action); 
    postForm.style.display = "none"; 
    postForm.enctype = "application/x-www-form-urlencoded";
    
    for (var key in values) {
        var input = document.createElement("input");
        input.setAttribute("name", key);
        input.setAttribute("value", values[key]);  
        postForm.appendChild(input);
    }
    
    document.body.appendChild(postForm); 
    postForm.submit();

    window.event.returnValue = false;
    postForm.disabled = true;
    //deleteForm(postForm);
}

function getRelativePath(sRelative) {
	var sUrl = document.URL;
	sUrl = sUrl.replace(/^.*?\:\/\/[^\/]+/, "").replace(/[^\/]+$/, "");
	if(!sRelative){return sUrl;}
	if(!/\/$/.test(sUrl)){sUrl += "/";}
	if(/^\.\.\//.test(sRelative)) {
       var Re = new RegExp("^\\.\\.\\/"), iCount = 0;
       while(Re.exec(sRelative)!=null)  {
       sRelative = sRelative.replace(Re, "");
       iCount++;
       }   
       
       for(var i=0; i<iCount; i++) {
       sUrl = sUrl.replace(/[^\/]+\/$/, "");
       }
       
       if(sUrl=="") return "/";  
       return sUrl+sRelative;
       }	   
       sRelative = sRelative.replace(/^\.\//, ""); 
       return sUrl+sRelative;
}

function fileSize(fileLen) {
    var sizeStr = '';
		
	if (fileLen == 0)
    {
        return "";
    }
    else if (fileLen < 1024)
    {
        sizeStr = fileLen + ' B';
    }
    else if (fileLen < 1024*1024)
    {
        sizeStr = Math.round((fileLen/1024.0*10)/10) + ' KB'
    }
    else {
        sizeStr = Math.round((fileLen/1024.0/1024*10)/10) + ' MB';
    }

    return sizeStr;
}

function fileDate()
{
	var d = new Date();   
	var month = d.getMonth() + 1;
	return d.getFullYear() + "-" + month 
		+ "-" + d.getDate() + " " + d.getHours() 
		+ ":" + d.getMinutes(); 		
}

function addFile(name, fileLen)
{
	var relpath = getRelativePath() + name;
	var objTable = document.getElementById("filelist");
  	
	varrow = objTable.insertRow(objTable.rows.length);
	varcell = varrow.insertCell(0);
	varcell.setAttribute("height","48");
	varcell.setAttribute("scope", "row");

	if (fileLen < 0)
	{
		varcell.innerHTML ='<div align="left"><a href="' + relpath 
		+ '">&nbsp;<img src="/.eshareWeb/image/fileicon/directory.png" width="48" height="48"/>&nbsp;' 
        + name + '</a></div>';
 	
     	varcell = varrow.insertCell(1);
 			varcell.innerHTML = '<div align="right"></div>';
	
			varcell = varrow.insertCell(2);
			varcell.innerHTML = '<div align="right"></div>';
	}
	else
	{
			varcell.innerHTML ='<div align="left"><a href="' + relpath 
				+ '">&nbsp;<img src="/.eshareWeb/image/fileicon/unknown.png" width="48" height="48"/>&nbsp;' 
    		+ name + '</a></div>';
 	
			varcell = varrow.insertCell(1);
			varcell.innerHTML = '<div align="right">' + fileSize(fileLen) + '</div>';
            
                                     /*
             varcell = varrow.insertCell(2);
             varcell.innerHTML ='<div align="left"><input type="image" src="/rfiles/image/download.png" onclick="downfile(\''
             + name + '\');" title="Download"/></div>';
                                      */
	}
	
}

function deletefile(filename)
{
    var txt = '<div style="word-break:break-all;width:350px;">';
    txt += v_delfile + ":'" + filename + "'?</div>";
    
    $.prompt(txt,{
		buttons:[
			{title: v_ok, value:true},
			{title: v_cancel, value:false}
		], 
    
    show:'slideDown',
    top: '35%',
    zIndex: '0',
       
		submit: function(e,v,m,f)
		{
			if (v == true)
			{
             //location.href="&op=del&name=" + filename;
             jsPost('post','',{
                    'op': 'del',
                    'name': filename
                    });
             return true;
			}
	  } 
	});
}

function deletefiles()
{
    //window.location.replace(filename + '?op=dl');
    var all=document.getElementsByName("selfiles");
    var filenames = new Array();
    filenames['op']= 'del';
    var flag = false;
    for(var i=0;i<all.length;i++) {
        if (all[i].checked==true) {
            flag = true;
            var key = 'name' + i;
            filenames[key]=all[i].value;
        }
    }
    
    if (flag == false) {
        noSelectFile();
        return false;
    }

    var txt = '<div style="word-break:break-all;width:350px;">';
    txt += v_delfile + "?</div>";

    $.prompt(txt,{
		buttons:[
			{title: v_ok, value:true},
			{title: v_cancel, value:false}
		], 

    show:'slideDown',
    top: '35%',
    zIndex: '0',
    submit: function(e,v,m,f)
    {
        if (v == true) {
             jsPost('post','', filenames);
             return true;
        }
    }});
}

function renamefile(oldname) 
{ 
	var txt = '<div style="word-break:break-all;width:350px;">';
  txt += v_curfile + "'" + oldname + "'<br />" + v_newfile + "<br/>";
	txt += '<input type="text" id="newName" name="newName" value=""/></div>';

	$.prompt(txt,{
		buttons:[
			{title: v_ok, value:true},
			{title: v_cancel, value:false}
		], 
        
    show:'slideDown',
    top: '35%',
    zIndex: '0',
    submit: function(e,v,m,f)
	{
		if (v == true && f.newName != '')
		{
        //location.href="&op=rn&old=" + oldname + "&new=" + f.newName;
        jsPost('post','',{
               'op': 'rn',
               'old': oldname,
               'new': f.newName
        });
        return true;
        }
	  }
	});
} 

function createfolder() 
{ 
	var txt = '<div style="word-break:break-all;width:350px;">';
    txt += v_newfolder + "<br/>";
	txt += '<input type="text" id="newFolder" name="newFolder" value=""/></div>';

	$.prompt(txt,{
		buttons:[
			{title: v_ok, value:true},
			{title: v_cancel, value:false}
		], 

    show:'slideDown',
    top: '35%',
    zIndex: '0',
    
		submit: function(e,v,m,f)
		{
			if (v == true && f.newFolder != '')
			{
             //location.href="&op=cf&name=" + f.newFolder; 
             jsPost('post','',{
                    'op': 'cf',
                    'name': f.newFolder
                    });
             return true;
			}
		}
	});
} 

function downfile(filename)
{
    //window.location.replace(filename + '?op=dl');
                                     
     jsPost('post','',{
            'op': 'dl',
            'path': getRelativePath(),
            'name': filename
            });
                             
                                     
    return true;
}

function downfiles()
{
    var all=document.getElementsByName("selfiles");
    var filenames = new Object();
    filenames['op']= 'dl';
    var flag = false;
    for(var i=0;i<all.length;i++) {
        if (all[i].checked==true) {
            flag = true;
        	var key = 'name' + i;
            filenames[key]=all[i].value;
        }
    }
    
    if (flag == false) {
        noSelectFile();
        return false;
    }
        
    var txt = '<div style="word-break:break-all;width:350px;">';
    txt += v_muldown + "</div>";

    $.prompt(txt,{
		buttons:[
			{title: v_ok, value:true},
			{title: v_cancel, value:false}
		], 

    show:'slideDown',
    top: '35%',
    zIndex: '0',
    submit: function(e,v,m,f)
    {
        if (v == true) {
            //loadingMsg(1);
            //window.onload = function() {load();};
            jsPost('post','', filenames);
            /*$.post("", filenames, function() {
                loadingMsg(0);
                return true;
            })
            .success(function() { loadingMsg(0); return true;})
            .error(function() { loadingMsg(0); return false;})
            .complete(function() { loadingMsg(0); return false; });*/
             
            return true;
        }
    }});
}

function selectall(flag)
{
	var all=document.getElementsByName("selfiles");
    var filenames = new Array();
    
    for(var i=0;i<all.length;i++) {
        all[i].checked = flag;
    }
}

function noSelectFile()
{
	var txt = '<div style="word-break:break-all;width:350px;">';
    txt += v_nofile + "</div>";
    $.prompt(txt,{
		buttons:[
			{title: v_ok, value:true}
		], 
        show:'slideDown',
        top: '35%',
        zIndex: '0'
    });
}

function clickfile(para) 
{
    if (para.checked){
    }
    else {
    }
}

function loadingMsg(show)
{
    var v = document.getElementById("wloading");
    if (v) {
    if (show == 1) {
    v.style.display = 'block';
    }
    else {
    v.style.display = 'none';
    }}
}

function addFavorite(sURL, sTitle)
{
	if (document.all) {
		try {
		window.external.AddFavorite(sURL, sTitle);
		}
		catch (e) {
		}
	}
	else if (window.sidebar) {
		try {
		window.sidebar.addPanel(sTitle, sURL, "");
		}
		catch (e) {
		}
	}
	else if (window.opera && window.print)
	{
    	try {
			var mbm = document.getElementById('addFavor');
			mbm.setAttribute('rel','sidebar');
			mbm.setAttribute('href',url);
			mbm.setAttribute('title',title);
			mbm.click();
        }
        catch (e) {
		}
	}  
}
        
function LocalInfo()
{
	var v = document.getElementById("footer");
    if (v) {
    	v.innerHTML = '<p>&nbsp;</p><p>' + v_copyinfo + '</p>';
    }
  	v = document.getElementById("fname1");
    if (v) {
    	v.innerHTML = '&nbsp;&nbsp;' + v_name;
    }
	v = document.getElementById("fmodify1");
    if (v) {
    	v.innerHTML = '&nbsp;' + v_lastModify;
    }
	v = document.getElementById("fsize1");
    if (v) {
    	v.innerHTML = '&nbsp;' + v_size;
	}
    v = document.getElementById("fav");
    if (v) {
    	v.innerHTML = v_fav;
    }
}
function LoadOperateNoAdd()
{
    v = document.getElementById("tdbtuuon");
    if (v) {
         v.innerHTML =
         '&nbsp;&nbsp;&nbsp;'+
         '<a onclick="javascript:;" href="../" title="Upward directory"><img src="/.eshareWeb/image/back.png" height="42px" width="42px"/></a>&nbsp;' +
         '<a onclick="javascript:;" href="" title="Refresh"><img src="/.eshareWeb/image/refresh.png" height="42px" width="42px"/></a>&nbsp;';
    }
}
function LoadOperate()
{
    v = document.getElementById("tdbtuuon");
    if (v) {
        v.innerHTML =
        '&nbsp;&nbsp;&nbsp;'+
        '<a onclick="javascript:;" href="../" title="Upward directory"><img src="/.eshareWeb/image/back.png" height="42px" width="42px"/></a>&nbsp;' +
        '<a onclick="javascript:;" href="" title="Refresh"><img src="/.eshareWeb/image/refresh.png" height="42px" width="42px"/></a>&nbsp;'+
        '<a onclick="createfolder();" href="javascript:;" title="Create Folder"><img src="/.eshareWeb/image/newfolder.png" height="42px" width="42px"/></a>&nbsp;' ;
    }
}
