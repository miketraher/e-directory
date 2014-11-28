$(document).ready(function() {
	if( Modernizr.localstorage )
// for testing old browsers	if( 1 === 2 )
	{
	  // Yes! localStorage and sessionStorage support!
		var favourites = true;
		if (typeof localStorage.dir2favs === 'undefined') {
			
			localStorage.dir2favs = "";
		}
		var myfavs = localStorage.dir2favs;
		//console.log(myfavs);
		
	} else {
	  // Sorry! No web storage support..
		var favourites = false;
		var myfavs = "";
	};
	$.ajaxSetup( {cache: false  } );

	
	var delay = (function(){
		  var timer = 0;
		  return function(callback, ms){
		    clearTimeout (timer);
		    timer = setTimeout(callback, ms);
		  };
	})();
	
	// test for cookies enabled
	$.cookie("testCookie","1");
	if ($.cookie("testCookie") != "1") {
		alert("Your browser is blocking cookies for this site and some functions will not work properly");
	} else {
		$.removeCookie("testCookie");
	}


	// if startLetter variable has a value assign it to the search field
	$('#startletter').val(startLetter);
	

	

	var criteria = new Object();
	
	$("#tcglogo").click(function() {
		document.location.href="http://www.collinsongroup.com";
	});
	
	function resetCriteria( criteria ) {
		criteria.defaultCtry = $.cookie("defaultCtry");
		if (criteria.defaultCtry != null) {
			cookieArray = criteria.defaultCtry.split(';');			
			criteria.default_ctry_id = cookieArray[0];
			$('#default_ctry_name option').each(function() {
				if ($(this).text() == cookieArray[1]) {
					$(this).attr('selected','true');
				}
			});
			currentthis = $("#default_ctry_name");
			poss = new Object();
			poss.top = 134;
			poss.left = 572;
		} else {
			criteria.default_ctry_id =0;			
		};
		criteria.startLetter ='';
		criteria.displayType = 'dspGallery';
		criteria.site_id =0;
		criteria.ctry_id = criteria.default_ctry_id;
		criteria.company_id =0;
		criteria.dept_id =0;
		criteria.joiners=0;
		criteria.favs=0;
		criteria.desk_location_id =0;
		$('#dspTable').css('border-bottom','solid #FFFFFF 3px');
		$('#dspGallery').css('border-bottom','solid #96172E 3px');
		$('.phonelink').css('display','inline');
		$('.nophonelink').css('display','none');
		return criteria;
	}
	
	$('#default_ctry_name').change(function() {
		cookieval = $(this).val()+';'+$('#default_ctry_name option:selected').text();
		$.cookie("defaultCtry",cookieval, { expires: 30 });
		criteria = resetCriteria( criteria );
		// reset startletter value if any exists
		criteria.startLetter = $('#startletter').val();
		showDir(criteria);
	})
	
	$('#dspPhoneLinks').click(function() {
		$('.phonelink').toggle().css('color','blue');
		$('.nophonelink').toggle();
		
		
	})
	$(document).ajaxStart(function() {
		$('#loaderImage').show();
	})
	$(document).ajaxStop(function() {
		$('#loaderImage').hide();
	})	

	$("#insertNew").click(function() {
		document.location = "?action=edit.insert";
	})
	
	$("#adminFunctions").click(function() {
		document.location = "?action=admin.menu";
	})
	
	
	criteria = resetCriteria( criteria );
	
	function resetLocation() {
		criteria = resetCriteria( criteria );
		$('#site_name_search').val('');
		$('#site_name_search').attr('data','0');
		$('#desk_location_name_search').val('');
		$('#desk_location_name_search').attr('data',0);
		$('#company_name_search').val('');
		$('#company_name_search').attr('data','0');
		$('#dept_name_search').val('');
		$('#dept_name_search').attr('data','0');
		$('#site_name_search2').val('');
		$('#site_name_search2').attr('data','0');
		$('#ctry_name_search').val('');
		$('#ctry_name_search').attr('data','0');
		// and empty any existing results
		$("#results").empty();
		$("#detailDialog").dialog('close');
		$("#clearSrch1, #clearSrch2, #clearSrch3").hide();
		
	}
	
	$('#dspTable').css('border-bottom','solid #FFFFFF 3px');
	$('#dspGallery').css('border-bottom','solid #96172E 3px');

	$('#dspTable').click(function() {
		criteria.displayType = 'dspTable';
		$('#dspTable').css('border-bottom','solid #96172E 3px');
		$('#dspGallery').css('border-bottom','solid #FFFFFF 3px');
		if ($("#startletter").val().length > 1  || criteria.ctry_id || criteria.joiners || criteria.site_id || criteria.desk_location_id || criteria.company_id || criteria.dept_id) {
			criteria.startLetter = $('#startletter').val();
			showDir(criteria);

		};
	});
	$('#dspGallery').click(function() {
		criteria.displayType = 'dspGallery';
		$('#dspGallery').css('border-bottom','solid #96172E 3px');
		$('#dspTable').css('border-bottom','solid #FFFFFF 3px');
		if ($("#startletter").val().length > 1  || criteria.ctry_id || criteria.joiners || criteria.site_id || criteria.desk_location_id || criteria.company_id || criteria.dept_id) {
			criteria.startLetter = $('#startletter').val();
			showDir(criteria);;

		};
	});
	var searchType = 'srchName';
	clearAllUnderlines();
	$('#srchName').css('color','#96172E');

	$('#srchByName').show();
	$('#srchByAdvanced').hide();
	$('#srchByAdvanced button').button();

	function clearAllUnderlines() {
		$('#srchName').css('color','#616365');
		$('#srchAdvanced1').css('color','#616365');
		$('#srchAdvanced2').css('color','#616365');
		$('#srchAdvanced3').css('color','#616365');
		$('#favsearch').css('color','#616365');
	}
	
	$('#checkstatus').click(function() {
		if (this.checked) {
			$('#status').val('Y');
		} else {
			$('#status').val(' ');
		};
	});


	function showSrchTip (idName, message) {
		$('#'+idName).hover(function() {
			$('#srchtooltip').stop(true).fadeTo('100',0, function() {
				$(this).empty().append(message).stop(true).fadeTo('700',1)
			});
		},function() {
			$('#srchtooltip').stop(true).fadeTo('500',0,function() {$(this).empty()});
		});
	}
	
	
	
	$('#srchName').click(function() {
		var searchType = 'srchName';
		resetLocation();
		clearAllUnderlines();
		$('#srchName').css('color','#96172E');
		$('#srchByName').show();
		$('#srchByAdvanced1').hide();
		$('#srchByAdvanced2').hide();
		$('#empcount').hide();
		if ($("#startletter").val().length > 1) {
			
			showDir(criteria);;

		};
	});
	$('#srchAdvanced1').click(function() {
		var searchType = 'srchAdvanced';
		resetLocation();
		clearAllUnderlines();
		$('#srchAdvanced1').css('color','#96172E');
		$('#srchByName').hide();
		$('#srchByAdvanced1').show();
		$('#srchByAdvanced2').hide();
		$('#empcount').show();
		criteria.startLetter = '';
		$('#startletter').val('');
	});	
	$('#srchAdvanced2').click(function() {
		var searchType = 'srchAdvanced';
		if ($('#site_name_search2').attr('data') == 0 && 
			$('#dept_name_search').attr('data') == 0 &&	
			$('#company_name_search').attr('data') == 0 && 
			$("#ctry_id_search2").attr("data") == 0 ) {
			resetLocation();			
		}
		clearAllUnderlines();
		$('#srchAdvanced2').css('color','#96172E');
		$('#srchByName').hide();
		$('#srchByAdvanced1').hide();
		$('#srchByAdvanced2').show();
		$('#empcount').show();
		criteria.startLetter = '';
		$('#startletter').val('');
		if ($('#site_name_search2').attr('data') != 0 || 
		    $('#dept_name_search').attr('data') != 0 ||	
			$('#company_name_search').attr('data') != 0 || 
			$("#ctry_id_search2").attr("data") != 0 ) {
			criteria.site_id = $('#site_name_search2').attr('data'); 
			criteria.dept_id = $("#dept_name_search").attr("data"); 
			criteria.company_id =$("#company_name_search").attr("data"); 
			criteria.ctry_id =$("#ctry_id_search2").attr("data"); 
			showDir(criteria);
		}
	});	
	$('#srchAdvanced3').click(function() {
		var searchType = 'srchAdvanced';
		if ($("#ctry_id_search2").attr("data") == 0 ) {
			resetLocation();			
		}
		clearAllUnderlines();
		$('#srchAdvanced3').css('color','#96172E');
		$('#srchByName').show();
		$('#srchByAdvanced1').hide();
		$('#srchByAdvanced2').hide();
		$('#empcount').show();
		criteria.startLetter = '';
		criteria.joiners= 1;
		if ($("#ctry_id_search2").attr("data") != 0 ) {
			criteria.ctry_id = $("#ctry_id_search2").attr("data");			
		}

		$('#startletter').val('');
		showDir(criteria);
	});	
	$('#favsearch').click(function() {
		if (favourites) {
			var searchType = 'favsearch';
			resetLocation();
			clearAllUnderlines();
			$('#favsearch').css('color','#96172E');
			$('#srchByName').show();
			$('#srchByAdvanced1').hide();
			$('#srchByAdvanced2').hide();
			$('#empcount').hide();
			criteria.startLetter = '';
			criteria.joiners= 0;
			criteria.favs = 1;
			$('#startletter').val('');
			showDir(criteria);;	
		} else {
			alert('Your browser is old and does not support this feature. Upgrade to Chrome!');
		}
		
	});	
	
	// start search
	$("#startletter").focus();

	if (startLetter && startLetter.length > 1) {
		criteria.startLetter = startLetter;
		$("#startletter").val(criteria.startLetter);
		$("#startletter").removeClass('placeholder');
		showDir(criteria);
	}

	$('#startletter').keyup(function() {
		if (criteria.favs == 1) {
			// fav set but typing in search box - reset to name search
			$('#srchName').click();
		};
		criteria.startLetter = $('#startletter').val();
		var poss = $(this).position();
		if (criteria.startLetter.length > 0){
			$("#clearSrch1").css({'top': poss.top + 4, 'left': poss.left + 225, 'display': 'inline'});
			$("#clearSrch1").attr('data','startletter');
			$("#clearSrch1").attr('targetvar','startLetter');
		} else {
			$("#clearSrch1").css({'top': poss.top + 4, 'left': poss.left + 225, 'display': 'none'});
		}; 
		if (criteria.startLetter.length > 1){
			showDir(criteria);
		};
	});
	// this function sets the grey crosses on the search lookups 
	function setClear ( currentthis, targetvar, number) {
		var poss = $(currentthis).position();
		var thisID = $(currentthis).attr('id');
		// console.log('in set clear');
 		if ($(currentthis).val().length > 0){
			$("#clearSrch"+number).css({'top': poss.top + 4, 'left': poss.left + 225, 'display': 'inline'});
			$("#clearSrch"+number).attr('data',thisID);
			$("#clearSrch"+number).attr('targetvar',targetvar);
		} else {
			$("#clearSrch"+number).css({'top': poss.top + 4, 'left': poss.left + 225, 'display': 'none'});
		} 
		
	}
	// this function sets the grey cross on the default site 
	function setCleardefaultCtry( poss, currentthis, targetvar, number) {
		
		// console.log(poss.top);
		
		var thisID = $(currentthis).attr('id');
		// console.log('in set clear');
 		if ($(currentthis).val().length > 0){
			$("#clearSrch"+number).css({'top': poss.top, 'left': poss.left, 'display': 'inline'});
			$("#clearSrch"+number).attr('data',thisID);
			$("#clearSrch"+number).attr('targetvar',targetvar);
		} else {
			$("#clearSrch"+number).css({'top': poss.top, 'left': poss.left, 'display': 'none'});
		} 
		
	}
	// this function sets the grey crosses on the edit lookups 
	function setClearLookup( poss, currentthis, targetvar, number) {
		
		// console.log(poss.top);
		
		var thisID = $(currentthis).attr('id');
		// console.log('in set clear');
 		if ($(currentthis).val().length > 0){
			$("#clearLookup"+number).css({'top': poss.top, 'left': poss.left, 'display': 'inline'});
			$("#clearLookup"+number).attr('data',thisID);
			$("#clearLookup"+number).attr('targetvar',targetvar);
		} else {
			$("#clearLookup"+number).css({'top': poss.top, 'left': poss.left, 'display': 'none'});
		} 
		
	}	
	$('#site_name_search, #site_name_search2').keyup(function() {
		var currentthis = new Object();
		currentthis = $(this);
		setClear(currentthis,'site_id', 1);
	});
	$('#desk_location_name_search').keyup(function() {
		var currentthis = new Object();
		currentthis = $(this);
		setClear(currentthis,'desk_location_id', 2);

	
	});
	$('#dept_name_search').keyup(function() {
		var currentthis = new Object();
		currentthis = $(this);
		setClear(currentthis,'dept_id', 2);

	
	});
	$('#company_name_search').keyup(function() {
		var currentthis = new Object();
		currentthis = $(this);
		setClear(currentthis,'company_id', 3);
	
	});
	
	
	$("#clearSrch1, #clearSrch2, #clearSrch3").click(function() {
		var targetvar = $(this).attr('targetvar'); 
		criteria[targetvar] = 0;
		var whattoclear = $(this).attr('data');
		if (whattoclear.length) {
			$("#"+whattoclear).val('');
			$("#"+whattoclear).attr('data',0);
			$(this).hide();
			showDir(criteria);	
		}
	})

	$("#clearLookup1, #clearLookup2, #clearLookup3, #clearLookup4, #clearLookup5, #clearLookup6, #clearLookup7").click(function() {
		var targetvar = $(this).attr('targetvar'); 
		var whattoclear = $(this).attr('data');
		$("#"+targetvar).val('');
		if (whattoclear.length) {
			$("#"+whattoclear).val('');
			$(this).hide();
		}
	})	
	
	function isFav(empid) {
		if (myfavs.indexOf(empid) != -1 && favourites) {
			return true;
		}
		return false;
	}
	
	

	function showDir( criteria ) {
		// get startletter to catch up with any subsequently typed letters
		criteria.startLetter = $('#startletter').val();
		if (criteria.displayType == 'dspTable') {
			
			var actionName = 'Summary'
				
		};
		if (criteria.displayType == 'dspGallery') {
			
			var actionName = 'Gallery'
		};
		if (criteria.ctry_id != parseInt(criteria.ctry_id)) { criteria.ctry_id = 0 };
		if (criteria.site_id != parseInt(criteria.site_id)) { criteria.site_id = 0 };
		if (criteria.desk_location_id != parseInt(criteria.desk_location_id)) { criteria.desk_location_id = 0 };
		if (criteria.company_id != parseInt(criteria.company_id)) { criteria.company_id = 0 };
		if (criteria.dept_id != parseInt(criteria.dept_id)) { criteria.dept_id = 0 };
		if (criteria.joiners != parseInt(criteria.joiners)) { criteria.joiners = 0 };
		if (criteria.favs != parseInt(criteria.favs)) { criteria.favs = 0 };
		if (!(criteria.favs && myfavs.length && favourites)) { 
			criteria.favs = 0;
			criteria.myfavs = "";
		} else {
			criteria.favs = 1;
			criteria.myfavs = myfavs
		};
		

		criteria.ctry_id = parseInt(criteria.ctry_id);
		criteria.site_id = parseInt(criteria.site_id);
		criteria.desk_location_id = parseInt(criteria.desk_location_id);
		criteria.company_id = parseInt(criteria.company_id);
		criteria.dept_id = parseInt(criteria.dept_id);
		
		if ( !(criteria.startLetter.length || criteria.ctry_id || criteria.joiners || criteria.favs || criteria.site_id || criteria.desk_location_id || criteria.company_id || criteria.dept_id) ) {
			resetLocation();
			return;
		}
				
		$('#results').load('?action=search.results'+actionName, {startletter: criteria.startLetter, 
																 ctry_id: criteria.ctry_id,
																 site_id: criteria.site_id,
																 desk_location_id: criteria.desk_location_id,
																 company_id: criteria.company_id,
																 dept_id: criteria.dept_id,
																 joiners: criteria.joiners, 
																 favs: criteria.myfavs },
																 function() {

				if (criteria.displayType == 'dspTable') {
					initResults();	
				};
				if (criteria.displayType == 'dspGallery') {
					initGallery();					
				};

				return true;	
				
		});
	};
	
	// end search
	$("#photoUpload").dialog({ 'autoOpen': false, 'modal': false,  'draggable': true, 'resizable': false , 'width': 360,
		'dialogClass': 'alert', 'show': 'fade' });
	$("#photoEdit").dialog({ 'autoOpen': false, 'modal': false,  'draggable': true, 'resizable': true , 'width': 668, 'height': 450,
		'show': 'fade' });

	if (photocrop) {
	   LoadPhotoCrop( empID, CFargs.inputImage, CFargs.imageext , criteria.startLetter );
	   $("#photoEdit").dialog('option','position',[200,200]);
	   $("#photoEdit").dialog('open');
	}

 	function initGallery() {
 		
		$("#detailDialog").dialog({ 'autoOpen': false, 'modal': false, 'position': [300,200], 'draggable': true,
			   'resizable': true , 'width':628, 'title': 'Employee Profile'});
 		
		$(".galleryPic").click(function(e) {
			var thisEmpID = $(this).attr('data');
			var position = new Object();
			position.left = 316;
			position.top = 96;
			LoadDetail(thisEmpID , position);	
			return false;
		})
		
	} 
	
	
	function LoadPhotoCrop( empID, inputImage, imageext ) {
		var inputImage = inputImage;
		var imageext = imageext;
		var cropped_image = '';
		var jcrop_api;
	   $("#photoEdit").load('?action=edit.editphoto&emp_id='+empID+'&newimage='+inputImage+'&imageext='+imageext,function(data) {
		   


		    function showPreview(c ) {
			         CFargs.x = c.x;
			         CFargs.y= c.y;
			         CFargs.width = c.w;
			         CFargs.height = c.h;
			         CFargs.inputImage = inputImage;
			         CFargs.imageext = imageext;			         
			         if (cropped_image.length) {
			            CFargs.oldimage = cropped_image;
			         }
			         // ajax call to crop image image
			         $.post(rootURL+'services/edit.cfc?method=cropPhoto',CFargs,function(data) {
			            cropped_image = data;
			            $('#preview').attr('src',rootURL+'assets/images/temp/'+data);
			            $('#preview').show();
			            $('#previewArea').show();
	
			         });
		      };		
		      $('#tempImage').Jcrop({aspectRatio:.77,
		    	                     boxWidth: 200 , 
		    	                     setSelect: [103,34,672,771],
		    	                     onSelect: showPreview 	
		      						}, function() {
		    	  
		    	  jcrop_api = this;
		    	  
			      $('#savePreview').click(function() {

				         var CFargs = new Object();
				         CFargs.emp_id = $('#photoEditArea').attr('data');
				         CFargs.imageName = cropped_image;
				         CFargs.inputImage = inputImage;
				         CFargs.imageext = imageext;
				         // ajax call to save image against current emp_id
				         $.post(rootURL+'services/edit.cfc?method=savePhoto',CFargs, function() {
				        	 redirectURL = rootURL+'index.cfm?action=edit.edit&emp_id='+CFargs.emp_id;
				        	 document.location.href=redirectURL;
				         });
				         



			      })
			      $('#showPreview').click(function() {showPreview( jcrop_api.tellSelect())} );
			    		  
				      
			      showPreview( jcrop_api.tellSelect() );
		      
		      
		      });// end JCROP 
	   }); // end LOAD photo edit dialog
	}; // end LoadPhotoCrop
 	
	
	// start results
	function initResults() {
		$("#tblresults").tablesorter({
			headers: {
	         0: {sorter: false },
	         4: {sorter: false },
	         5: {sorter: false },
	         6: {sorter: false },
	         7: {sorter: false },
	         8: {sorter: false }

			}
	    });
		
		$("#detailDialog").dialog({ 'autoOpen': false, 'modal': false, 'position': [300,200], 'draggable': true,
		   'resizable': true , 'width':628, 'title': 'Employee Profile'});

		$(".info").click(function(e) {
			var thisEmpID = $(this).attr('data');
			var position = $(".bodyrow:first .ext").position();
			LoadDetail(thisEmpID , position);	
			return false;
		})
	   

		var t = 0;
	   $(".photoIcon").mouseenter(function(e) {
		   $("#photoDialog").dialog('close');
		   var thisEmpID = $(this).attr('data');
		   var thisImageURL = rootURL+'services/search.cfc?method=getPhoto&emp_id='+thisEmpID;
		   $("#photoDialog").append('<img src="'+thisImageURL+'">');
		   $("#photoDialog").dialog('option','position',[e.pageX,e.pageY]);
		   $("#photoDialog").dialog('open');
		   return true;
		   });
	   $(".photoIcon").mouseleave(function() {
		      $("#photoDialog").empty();
			   $("#photoDialog").delay(800).dialog('close');
			   $("#photoDialog").dialog('close');
			   return true;
			   
	   });

	   
	} // end results


		$('#saveEmp').click(function() {
			
			
			// test if logged in 
			alert('save clicked');
			return false;
		});		   	
	   
	    $("#editphotoIcon").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-photo-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-photo-icon.png')}
	    );
	   
		$("#editphoto").click(function() {
			var empID = $(this).attr('data');
			criteria.startLetter = $("#startletter").val();
			$("#photoUpload").load('?action=edit.uploadphoto&emp_id='+empID+'&startletter='+criteria.startLetter);
			$("#photoUpload").dialog('open');
			    		  
		});

	   function showFavMessage(messText) {
		   
		   $('#thisfavmessage').empty().append(messText).stop(true);
		   $('#thisfavmessage').fadeTo(1500,1,function() {$(this).fadeTo(1000,0);});
		   
	   }		  
   	   
	   function LoadDetail( empID , position) {
		   var boolFav = 0;
		   if (isFav(empID)) {
			   boolFav = 1;
		   }
		   $("#detailDialog").load('?action=search.showDetail&emp_id='+empID+'&fav='+boolFav,function(data) {
			   $("#detailDialog").dialog('option','position',[position.left,position.top]);
			   $("#detailDialog").dialog('open');
			   $('#thisfav').click(function() {
				   var boolFav = 0;
				   if (isFav(empID)) {
					   boolFav = 1;
				   }
				   //console.log("before changes favs list:"+myfavs);
				   if (favourites) {
					   if (boolFav) {
						   // currently fav so click means unfav ;(
						   var tempfavs1 = myfavs.replace(","+empID,"");
						   var tempfavs2 = tempfavs1.replace(empID+",","");
						   var tempfavs3 = tempfavs2.replace(empID,"");
						   myfavs = tempfavs3;
						   $('#thisfav').removeClass("fav");
						   $('#thisfav').addClass("emptyfav");
						   showFavMessage('Favourite removed');
						   
						   
					   } else {
						   // currently not fav so fav it :)
						   var tempfavs1 = myfavs.concat(","+empID);
						   myfavs = tempfavs1;
						   $('#thisfav').removeClass("emptyfav");
						   $('#thisfav').addClass("fav");
						   showFavMessage('Favourite added');
					   }
				   } else {
					   showFavMessage('your browser is old upgrade!');
				   }
				   
				   localStorage.dir2favs = myfavs;
				   //console.log("after changes favs list:"+myfavs);
					
			   })

			   $("#gotoEdit").hover(
			    	function() {$(this).attr('src','assets/images/icons/211014-edit-icon-hover.png')},
			    	function() {$(this).attr('src','assets/images/icons/211014-edit-icon.png')}
			   	);

			   $("#gotoEdit").click(function() {
					var empID = $(this).attr('data');
					document.location = '?action=edit.edit&emp_id='+empID;
			   });

			    
		   });
	   }
	   
	   $("#photoDialog").dialog({ 'autoOpen': false, 'modal': false,  'draggable': true, 'resizable': false , 'width': '144px',
		   'dialogClass': 'alert' });

	   $("#editSave").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-save-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-save-icon.png')}
	   	);

	   $("#editSave").click(function() {
		   $("#entryedit").submit();
		   
	   })

	   $("#editDelete").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-delete-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-delete-icon.png')}
	   	);

	    $(".editIcon").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-edit-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-edit-icon.png')}
	   	);
	    $(".deleteIcon").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-delete-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-delete-icon.png')}
	   	);
	    $("#editDelete").click(function() {
		   var empID = $('#emp_id').val();
		   var conf=confirm('Sure you want to delete this record?');
		   if (conf) {
			   document.location = '?action=edit.delete&emp_id='+empID;			   
		   }
		   return false;
		   
	   })
	   
	   $(".userDelete").click(function() {
		   var userID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete user: '+userID);
		   if (conf) {
			   document.location = '?action=users.delete&user_id='+userID;			   
		   }
		   return false;
		   
	   })
	   $(".ctryDelete").click(function() {
		   var ctryID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete ctry: '+ctryID);
		   if (conf) {
			   document.location = '?action=lookups.deletectry&ctry_id='+ctryID;			   
		   }
		   return false;
		   
	   })
	   $(".siteDelete").click(function() {
		   var siteID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete site: '+siteID);
		   if (conf) {
			   document.location = '?action=lookups.deletesite&site_id='+siteID;			   
		   }
		   return false;
		   
	   })
	   $(".deskDelete").click(function() {
		   var deskID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete floor level: '+deskID);
		   if (conf) {
			   document.location = '?action=lookups.deletedesk&desk_location_id='+deskID;			   
		   }
		   return false;
		   
	   })	   
	   $(".divisionDelete").click(function() {
		   var divisionID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete division: '+divisionID);
		   if (conf) {
			   document.location = '?action=lookups.deletedivision&division_id='+divisionID;			   
		   }
		   return false;
		   
	   })	   
	   $(".companyDelete").click(function() {
		   var companyID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete company: '+companyID);
		   if (conf) {
			   document.location = '?action=lookups.deletecompany&company_id='+companyID;			   
		   }
		   return false;
		   
	   })		   
	   $(".deptDelete").click(function() {
		   var deptID = $(this).attr('data');
		   var conf=confirm('Sure you want to delete dept: '+deptID);
		   if (conf) {
			   document.location = '?action=lookups.deletedept&dept_id='+deptID;			   
		   }
		   return false;
		   
	   })	
	   
	   $("#adminCancel").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-back-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-back-icon.png')}
	   	);

	   $("#editCancel").hover(
	    	function() {$(this).attr('src','assets/images/icons/211014-back-icon-hover.png')},
	    	function() {$(this).attr('src','assets/images/icons/211014-back-icon.png')}
	   	);
	   
	   $("#editCancel").click(function() {
		   document.location = '?action=search.search';			   
		   return false;
		   
	   })
		
   // start photoUpload dialog
	function initPhotoUpload() {
		
		
	}
   // end photoUpload dialog
	   
	   // autocomplete activations
	   
		// suggest for report to
		$( "#report_to" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestEmployee",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 2,
		select: function( event, ui ) {
			$('#report_to').val(ui.item.label);
			$('#report_to_emp_id').val(ui.item.value);
			currentthis = $("#report_to");
			var poss =  $("#report_to").offset();
			// used to have some browser positioning issues here but now seems consistent
			poss.top += 4;
			poss.left = 575;			
			setClearLookup(poss, currentthis,'report_to_emp_id', 1);
			
			return false;
		},
		change: function( event, ui ) {}
		});
		// suggest for possible site countries
		$( "#ctry_name" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestCtry",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#ctry_name').val(ui.item.label);
			$('#ctry_id').val(ui.item.value);
			// need to clear site and floor level
			$('#site_name').val('');
			$('#site_id').val('');
			$('#desk_location_name').val('');
			$('#desk_location_id').val('');
			return false;
		},
		change: function( event, ui ) {
			// need to clear site and floor level
			$('#site_name').val('');
			$('#site_id').val('');
			$('#desk_location_name').val('');
			$('#desk_location_id').val('');
		}
		});	
		
		// suggest for possible sites within country
		$( "#site_name" ).autocomplete({ 
			source: function( request, response ) {
			var ctry_id = $('#ctry_id').val();
			$.ajax({
				url: "services/search.cfc?method=suggestSite&ctry_id="+ctry_id,
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#site_name').val(ui.item.label);
			$('#site_id').val(ui.item.value);
			// need to clear floor level
			$('#desk_location_name').val('');
			$('#desk_location_id').val('');
			return false;
		},
		change: function( event, ui ) {
			// need to clear floor level
			$('#desk_location_name').val('');
			$('#desk_location_id').val('');
		}
		});	
		// suggest for possible sites within country
		$( "#desk_location_name" ).autocomplete({ 
			source: function( request, response ) {
			var site_id = $('#site_id').val();
			$.ajax({
				url: "services/search.cfc?method=suggestDesk&site_id="+site_id,
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#desk_location_name').val(ui.item.label);
			$('#desk_location_id').val(ui.item.value);
			return false;
		},
		change: function( event, ui ) {
		}
		});			
		
		// clears value and data on focus, then ensures lookup closes
		$('div.searchParams input').focus(function()
				{
	 		  var self = this;
			  $(self).val('');
			  $(self).attr('data',0);
			  if ($(self).attr('name') != 'startletter') {
				  window.setTimeout(function()
						  {
						    if (self.value.length == 0)
						      $(self).autocomplete('search', '');
						  });				  
			  }

			  // IE needs this return false else the focus event is fired again
			  return false; 
		});	 
		// clears value and data on focus, then ensures lookup closes
		$('div.autocomp input').focus(function()
				{
			  var self = this;
			  //if (self.id == 'company_name') {return};
			  $(self).val('');
			  window.setTimeout(function()
			  {
			    if (self.value.length == 0)
			      $(self).autocomplete('search', '');
			  });
			  return false;
		});  
		// suggest all  possible sites 
		$( "#site_name_search" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestSiteSearch",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 0,
		minLength: 0,
		select: function( event, ui ) {
			$('#site_name_search').val(ui.item.label);
			$('#site_name_search').attr('data',ui.item.value);
			currentthis = $("#site_name_search");
			setClear(currentthis,'site_id', 1);
			criteria.startLetter = '';
			criteria.ctry_id = 0;
			criteria.site_id = $('#site_name_search').attr('data');
			criteria.desk_location_id = 0;
			criteria.company_id = 0;
			criteria.dept_id = 0;
			showDir(criteria);
			return false;
		},
		change: function( event, ui ) {
			// need to clear floor level
			currentthis = $("#site_name_search");
			setClear(currentthis,'site_id', 1);
			$('#desk_location_name_search').val('');
			$('#desk_location_name_search').attr('data',0);
		}
		});	
		// suggest for possible sites within country
		$( "#desk_location_name_search" ).autocomplete({ 
			source: function( request, response ) {
			var site_id_search = $('#site_name_search').attr('data');
			$.ajax({
				url: "services/search.cfc?method=suggestDesk&site_id="+site_id_search,
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#desk_location_name_search').val(ui.item.label);
			$('#desk_location_name_search').attr('data',ui.item.value);
			currentthis = $("#desk_location_name_search");
			setClear(currentthis,'desk_location_id', 2);
			criteria.startLetter = '';
			criteria.ctry_id = 0;
			criteria.site_id = $('#site_name_search').attr('data');
			criteria.desk_location_id = $('#desk_location_name_search').attr('data');
			criteria.company_id = 0;
			criteria.dept_id = 0;
			showDir(criteria);			
			return false;
		},
		change: function( event, ui ) {
			currentthis = $("#desk_location_name_search");
			setClear(currentthis,'desk_location_id', 2);
		}
		});	
		// suggest for possible companies
		$( "#company_name_search" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestCompany",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#company_name_search').val(ui.item.label);
			$('#company_name_search').attr('data',ui.item.value);
			currentthis = $("#company_name_search");
			setClear(currentthis,'company_id', 3);
			criteria.startLetter = '';
			criteria.ctry_id = $('#ctry_id_search').val();
			criteria.site_id = $('#site_name_search2').attr('data');
			criteria.desk_location_id = 0;
			criteria.company_id = ($('#company_name_search').attr('data'));
			criteria.dept_id = $('#dept_name_search').attr('data');
			showDir(criteria);						
			return false;
		},
		change: function( event, ui ) {
			currentthis = $("#company_name_search");
			setClear(currentthis,'company_id', 3);
		}
		});			

		// suggest for possible sites within country
		$( "#site_name_search2" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestSiteSearch",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#site_name_search2').val(ui.item.label);
			$('#site_name_search2').attr('data',ui.item.value);
			currentthis = $("#site_name_search2");
			setClear(currentthis,'site_id', 1);
			criteria.startLetter = '';
			criteria.ctry_id = 0;
			criteria.site_id = $('#site_name_search2').attr('data');
			criteria.desk_location_id = 0;
			criteria.company_id = $('#company_name_search').attr('data');
			criteria.dept_id = $('#dept_name_search').attr('data');
			showDir(criteria);						
			return false;
		},
		change: function( event, ui ) {
			currentthis = $("#site_name_search2");
			setClear(currentthis,'site_id', 1);
		}
		});			

		// suggest for possible divisions
		$( "#division_name" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestDivision",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#division_name').val(ui.item.label);
			$('#division_id').val(ui.item.value);
			return false;
		},
		change: function( event, ui ) {
		}
		});	
		// suggest for possible company
	    function split( val ) {
	      return val.split( /,\s*/ );
	    }
	    function extractLast( term ) {
	      return split( term ).pop();
	    }
	    function processCompanies () {
        	// reset company_id list
        	$('#company_id').val('');
        	// walk through set chosen so far and populate company_id with a list of ids
        	var companyIdList = "";
        	$('#companies li').each(function(i,e){
        		companyIdList += $(this).attr('data')+',';
        	});
        	$('#company_id').val(companyIdList);
        	$('#company_name').val('').blur();
        	var poss = $("#dept_name").offset();
			// used to have some browser positioning issues here but now seems consistent
			poss.top += 4;
			poss.left = 575;
			setClearLookup(poss, currentthis,'dept_id', 7);	
	    };
	    $(document).on('click','#companies li img', function() {
	    	$(this).parent().remove();
	    	processCompanies();
	    })


		$( "#company_name" )
		.bind( "keydown", function( event ) {
	        if ( event.keyCode === $.ui.keyCode.TAB &&
	            $( this ).autocomplete( "instance" ).menu.active ) {
	          event.preventDefault();
	        }
	    })
		.autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestCompany",
				dataType: "json",
				data: {
					term: extractLast(request.term)
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							var selectedCompanies = $('#company_id').val().split(",");
							var a = 0;
							for (a in selectedCompanies ) {
    							selectedCompanies[a] = parseInt(selectedCompanies[a], 10); 
							}
							//console.log('selectedCompanies after split'+selectedCompanies);
							//console.log('selectedCompanies.indexOf(item[0]) where item[0]='+item[0]+' is '+selectedCompanies.indexOf(item[0]));
							if (selectedCompanies.indexOf(item[0]) == -1 ) {
								return {
									value: item[0],
									label: item[1]
								}

							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
        	// show companies as a list
	    	if ($('#company_id').length) {
	    		$('#companies').show();
	    	}
	    	// add the selected company as a LI with id in data and label showing
        	$('#companies').append("<li name='company' data='"+ui.item.value+"'>"+ui.item.label+"&nbsp;<img id='clear"+ui.item.value+"' src='assets/images/icons/clear.png'>"+"</li>");

        	processCompanies();

		    return false;
        },
		change: function( event, ui ) {
		}
		});	
		
				
		// suggest for possible department
		$( "#dept_name" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestDept",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#dept_name').val(ui.item.label);
			$('#dept_id').val(ui.item.value);
			var poss = $("#dept_name").offset();
			// used to have some browser positioning issues here but now seems consistent
			poss.top += 4;
			poss.left = 575;
			setClearLookup(poss, currentthis,'dept_id', 7);	
			return false;
		},
		change: function( event, ui ) {
		}
		});	
		// suggest for possible department
		$( "#dept_name_search" ).autocomplete({ 
			source: function( request, response ) {
			$.ajax({
				url: "services/search.cfc?method=suggestDept",
				dataType: "json",
				data: {
					term: request.term
				},
				success: function( data ) {
					if (data.SUCCESS) {
						response( $.map( data.entries.DATA, function( item ) {
							return {
								value: item[0],
								label: item[1]
							}
						}));
					} 
				}
			});
		},
		delay: 10,
		minLength: 0,
		select: function( event, ui ) {
			$('#dept_name_search').val(ui.item.label);
			$('#dept_name_search').attr('data',ui.item.value);
			currentthis = $("#dept_name_search");
			setClear(currentthis,'dept_id', 2);
			criteria.startLetter = '';
			criteria.ctry_id = 0;
			criteria.site_id = $('#site_name_search2').attr('data');
			criteria.desk_location_id = 0;
			criteria.company_id = $('#company_name_search').attr('data');
			criteria.dept_id = $('#dept_name_search').attr('data');
			showDir(criteria);				
			return false;
		},
		change: function( event, ui ) {
			currentthis = $("#dept_name_search");
			setClear(currentthis,'dept_id', 2);
		}
		});		
		
		// if the edit page is loaded set the clear images
		if ($("#report_to").length>0 && $("#editCancel").length>0) {
			currentthis = $("#report_to");
			var poss =  $("#report_to").offset();
			// used to have some browser positioning issues here but now seems consistent
			poss.top += 4;
			poss.left = 575;
			setClearLookup(poss, currentthis,'report_to_emp_id', 1);			
		}
		// if the edit page is loaded set the clear images
		if ($("#dept_name").length>0 && $("#editCancel").length>0) {
			currentthis = $("#dept_name");
			var poss = $("#dept_name").offset();
			// used to have some browser positioning issues here but now seems consistent
			poss.top += 4;
			poss.left = 575;
			setClearLookup(poss, currentthis,'dept_id', 7);			
		}

		
		
})



