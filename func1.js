function valid_check()
{

	if (document.frm1.userid.value == "")
	{
		alert("아이디를 입력하여 주시기 바랍니다.");
		document.frm1.userid.focus();
		return false;
	}

	if (document.frm1.userid.value.length < 4)
	{
		alert("아이디는 4자 이상입니다.");
		document.frm1.userid.focus();
		return false;
	}

	if (document.frm1.usernm.value == "")
	{
		alert("이름을 입력하여 주시기 바랍니다.");
		document.frm1.usernm.focus();
		return false;
	}

	if (document.frm1.passwd.value == "")
	{
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		document.frm1.passwd.focus();
		return false;
	}
	
	if (document.frm1.userid.value.length > 18)
	{
		alert("아이디는 18자 이하입니다.");
		document.frm1.userid.focus();
		return false;
	}

	if (document.frm1.passwd.value != document.frm1.passwd2.value)
	{
		alert("비밀번호확인과 일치하지 않습니다.");
		document.frm1.passwd.focus();
		return false;
	}

	if (document.frm1.jumin1.value.length != 6)
	{
		alert("주민번호 앞 자릿수는 6자입니다.");
		document.frm1.jumin1.focus();
		return false;
	}

	if (document.frm1.jumin2.value.length != 7)
	{
		alert("주민번호 뒷 자릿수는 7자입니다.");
		document.frm1.jumin2.focus();
		return false;
	}

	document.frm1.submit();

}

function KeyNumber(event)
{
	event = event || window.event;
	
	var keyID = event.keyCode;
	
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
	{
		return;
	}
	else
	{
		return false;
	}
}

function removeChar(event) 
{
	event = event || window.event;
	
	var keyID = event.keyCode;
	
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
	{
		return;
	}
	
	else
	{
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
}

function cursor_move(a)
{

	if ( a == 1 )
	{
		var str = document.frm1.jumin1.value.length;
		if (str == 6) 
			document.frm1.jumin2.focus();
	}	
	else if ( a == 2 )
	{
		var str = document.frm1.jumin2.value.length;
		if (str == 7) 
			document.frm1.mailrcv.focus();
	}

}

function check_id()
{
	var JSPName = "id_check.jsp";
	browsing_window = window.open(JSPName, "_idcheck", "height=220, width=520, menubar=no, directories=no, resizable=no, status=yes, scrollbars=no, toolbar=no");
	browsing_window.focus();
}