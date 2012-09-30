<cfcontent reset="true"><?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>	
			<link rel="stylesheet" type="text/css" href="/looping/style/looping.css" />
			<script type="text/javascript" src="/looping/js/jquery-1.7.2.min.js"></script>			
			<script type="text/javascript" >
					$(document).ready(function(){
						$("#sqlDisplay").find(".content").hide();
						$('.show').show();
						$('.hide').hide();
						$('.show,.hide').on({
							mouseenter: function () {
								$(this).addClass('hover');
							}, //notice the comma..
							mouseleave: function () {
							  $(this).removeClass('hover');
							},
							click: function () {
							$('.hide,.show,.content').toggle();
								
							}
						})
						
						}) //(document).ready
			</script>
		</head>
		<body>
<h1>NCDevCon Looping and Grouping Session</h1>
<hr />
<a href="/looping/index.cfm">Home</a> 
:: <a href="/looping/index.cfm?reset">Reset</a>

<br />
<hr />
