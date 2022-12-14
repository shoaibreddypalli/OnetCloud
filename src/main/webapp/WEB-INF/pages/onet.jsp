<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>


<html>
<head>
<link rel="stylesheet" 
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.buttonload {
  background-color: #000000;  /* #04AA6D;  Green background */
  border: none; /* Remove borders */
  color: white; /* White text */
  padding: 10px 20px; /* Some padding */
  font-size: 16px; /* Set a font-size */
}
.button5 {border-radius: 50%;} /*round*/
.button-73 {
  appearance: none;
  background-color: #FFFFFF;
  border-radius: 40em;
  border-style: none;
  box-shadow: #ADCFFF 0 -12px 6px inset;
  box-sizing: border-box;
  color: #000000;
  cursor: pointer;
  display: inline-block;
  font-family: -apple-system,sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  letter-spacing: -.24px;
  margin: 0;
  outline: none;
  padding: 1rem 1.3rem;
  quotes: auto;
  text-align: center;
  text-decoration: none;
  transition: all .15s;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
}

.button-73:hover {
  background-color: #FFC229;
  box-shadow: #FF6314 0 -6px 8px inset;
  transform: scale(1.125);
}

.button-73:active {
  transform: scale(1.025);
}

@media (min-width: 768px) {
  .button-73 {
    font-size: 1.5rem;
    padding: .75rem 2rem;
  }
}


</style>
<style type="text/css">
div {
  background-color: #8960b1;
}
h1 {
  text-shadow: 2px 2px red;
}
.color-list {
	display: flex;
	flex-flow: row wrap;
	width: 500px;
	margin: 0 auto;
}

.color-list>li {
	position: relative;
	width: 65px;
	height: 65px;
	border-radius: 4px;
	margin: 5px;
	overflow: hidden;
	background-color: #ccc;
	transition: all 0.25s ease 0s;
	cursor: pointer;
}

.color-list>li .overlay {
	content: "";
	position: absolute;
	left: 0;
	bottom: 0;
	right: 0;
	height: 100%;
	max-height: 100%;
	transition: all 0.25s;
	background-color: black;
}

.color-list>li .matrixBorder {
	content: "";
	position: absolute;
	left: 0;
	bottom: 0;
	right: 0;
	height: 100%;
	max-height: 100%;
	transition: all 0.25s;
	background-color: 8960b1;
	pointer-events: none;
}
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/randomcolor/0.6.1/randomColor.min.js"
	integrity="sha512-vPeZ7JCboHcfpqSx5ZD+/jpEhS4JpXxfz9orSvAPPj0EKUVShU2tgy7XkU+oujBJKnWmu4hU7r9MMQNWPfXsYw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
var isMuteSound = false;
function shuffle(array, array2) {
	  for (let i = array.length - 1; i > 0; i--) {
	    let j = Math.floor(Math.random() * (i + 1)); // random index from 0 to i
	    [array[i], array[j]] = [array[j], array[i]];
	    [array2[i], array2[j]] = [array2[j], array2[i]];
	  }
}
	
function getRandomColorPairs (count) {
	  const hueList = ['red', 'yellow', 'green', 'blue', 'pink', 'black', 'white', 'apricot']
	  
	  const colorList = [];

	  for (let i = 0; i < count; i++) {
	    const color = randomColor({
	      luminosity: 'dark',
	      hue: hueList[i % hueList.length],
	    });

	    colorList.push(color);
	  }

	  // double current color list
	  const fullColorList = [...colorList, ...colorList];

	  // Shuffle color list
	 // shuffle(fullColorList);

	  return fullColorList;
	}
	
function init(){
	
	var PAIRS_COUNT=8;
	  // Query elements
	  const colorItemList = document.querySelectorAll('.overlay');
	  randomColorList = getRandomColorPairs(PAIRS_COUNT);
	  
	  const imageList = ['0','1','2','3','4','5','6','7']
	  const fullImageList = [...imageList, ...imageList];
	  shuffle(randomColorList,fullImageList);
	  
		console.log(randomColorList);
	    // Binding events
	    colorItemList.forEach((item, idx) => {
	    	item.style.backgroundColor = randomColorList[idx];
	    	
	    	 $(item).prepend("<img  src='/images/"+fullImageList[idx]+".png' style = 'max-width:100%; height: 100%;' />")
	    	 item.parentElement.addEventListener('click', () => selectSquare(item.parentElement, idx));
	    });
	    
	  /*  colorItemList.forEach((item, idx) => {

	    	 const overlayElement = item.querySelector('.overlay');
		      if (overlayElement) {
		        overlayElement.style.backgroundColor = randomColorList[idx];
		      }
		      item.addEventListener('click', () => selectSquare(item, idx));

	    });*/
}

function disableSquare(element){
	console.log('I am inside to make white')
	element.style.backgroundColor = "#8960b1";
	element.parentElement.style.pointerEvents = 'none'
		element.parentElement.setAttribute("isCellFree", "true");
	setTimeout(function() {
        resetColor(element)
    }, 1000);
	$(element).html("");

	
}

function resetColor(element){
	element.style.backgroundColor = "#8960b1";
}

var firstColor ="";
var firstElement;
var firstIndex=-1;
var matchCount=0;
function selectSquare(item,idx){
	if(!isMuteSound){
	var audio = new Audio('/audio/click.wav');
	audio.play();
	}
	const overlayElement = item.querySelector('.overlay');
	console.log(overlayElement)
	console.log(overlayElement.style.backgroundColor)
	console.log(overlayElement)
	console.log(idx)
	//firstColor = overlayElement.style.backgroundColor;
	if (firstColor==""){
		firstIndex=idx;
		firstColor = overlayElement.style.backgroundColor;
		firstElement= overlayElement;
		$(overlayElement).addClass("border border-danger border-5");
		
	}else if(firstIndex!=idx){
		
		if(firstColor==overlayElement.style.backgroundColor){
			$(overlayElement).addClass("border border-danger border-5");
			//Payload generation
			
			 const colorItemList = document.querySelectorAll('.overlay');
			matrix = []
			matrix.push(-1)
			 colorItemList.forEach((item,idx) => {
				 if(item.parentElement.hasAttribute("isCellFree")){
					 matrix.push(idx);
				 }
					
			 });
			
			
			console.log('same'+firstIndex +":"+ idx)
			console.log(matrix)
			
			//Find it reaches within 2 turns
			
			 $.ajax({
				 url: "${pageContext.request.contextPath}/onet/checkValid", 
				 type: "POST",
				 data : {
					 "source" : firstIndex,
					 "destination" : idx,
					 "matrix" : matrix
				 },
				 success: function(result){
    
  console.log(result);
  if(result.length > 0){
	  
  disableSquare(overlayElement);
	disableSquare(firstElement);
	result.forEach((item)=>{
		  document.getElementById(item).style.backgroundColor= "#f2360b24"
			  setTimeout(function() {
			        resetColor(document.getElementById(item));
			    }, 1000);
		  
	  });
	matchCount= matchCount+1;
	
	if(matchCount == 8){
		console.log("You Win");
		$("#gameMessage").text("YOU WIN!!!")
		$("#banner").show();
		$("#gameSpace").hide();
		//var myModal = new bootstrap.Modal(document.getElementById('popUpInfo'))
		//myModal.show();
		var duration = 5 * 1000;
		var end = Date.now() + duration;

		(function frame() {
		  
		  confetti({
		    particleCount: 7,
		    angle: 60,
		    spread: 55,
		    origin: { x: 0 }
		  });
		  
		  confetti({
		    particleCount: 7,
		    angle: 120,
		    spread: 55,
		    origin: { x: 1 }
		  });

		  // keep going until we are out of time
		  if (Date.now() < end) {
		    requestAnimationFrame(frame);
		  }
		}());
		confetti();
	}
	
  }
  
				 }});
			
			
			
			}else {
				console.log('different')
			}
		firstColor="";
		firstIndex=-1;
		$(firstElement).removeClass("border border-danger border-5");
		$(overlayElement).removeClass("border border-danger border-5");
	}
		else {
			firstColor="";
			firstIndex=-1;
			console.log('same same')
			$(firstElement).removeClass("border border-danger border-5");
			$(overlayElement).removeClass("border border-danger border-5");

}
}

var timeoutHandle;
function countdown(minutes, seconds) {
    function tick() {
        var counter = document.getElementById("timer");
        counter.innerHTML =
            minutes.toString() + ":" + (seconds < 10 ? "0" : "") + String(seconds);
        seconds--;
        if (seconds >= 0) {
            timeoutHandle = setTimeout(tick, 1000);
        } else {
            if (minutes >= 1) {
                // countdown(mins-1);   
                setTimeout(function () {
                    countdown(minutes - 1, 59);
                }, 1000);
            }else{
            	console.log("reached!!!!!")
            	if(matchCount != 8){
            	$("#gameMessage").text("TIME UP!!");
            	
            	$("#banner").show();
            	$("#gameSpace").hide();
            	}
            }
        }
    }
    tick();
}
</script>









<script type="text/javascript">
function start(){
	init();
	countdown(2, 00);
	/* playAudio();
 */	
	
}

function muteSound(){
	if(isMuteSound){
		
		$("#muteButton").html("<i class='fa-solid fa-volume-high'></i>");
		isMuteSound=false;
	}else{
		$("#muteButton").html("<i class='fa-solid fa-volume-xmark'></i>");
		isMuteSound=true;
	}
}

</script>

<meta charset="ISO-8859-1">
<title>OnetConnectLive</title>



</head>
<body onload="start()">


<center><p><h1>Welcome to Onet Connect Puzzle Game<br /></h1></p></center>	


<div class="container vh-100" style="width: 650px;">
<div class = "panel panel-default"  style="
    margin-right : 10%; margin-left: 10%;
">
<center>
 <button onclick="window.location.reload();" class="btn btn-dark" style="
    margin-top: 2%;
"> <i class="fa-solid fa-play"></i></button>
 
<button  class="btn btn-dark" style="
    margin-top: 2%;
" > <i class="fa-regular fa-clock"></i> <span id="timer" class="timer"></span> </button>

<button  class="btn btn-dark" onclick="muteSound()" style="
    margin-top: 2%;
" id="muteButton"> <i class="fa-solid fa-volume-high"></i></button>


 </center>
</div>
	<div class="game__board" id="gameSpace" style="
    margin-right : 10%; margin-left: 10%
">
		<ul id="colorList" class="color-list">
		
			<li>
				<div class="matrixBorder" id="0,0"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="0,1"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="0,2"></div>
			</li>
			
			<li>
				<div class=" matrixBorder" id="0,3"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="0,4"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="0,5"></div>
			</li>
			
			
			<li>
				<div class="matrixBorder" id="1,0"></div>
			</li>
			<li>
				<div class="overlay" id="1,1"></div>
			</li>
			<li>
				<div class="overlay" id="1,2"></div>
			</li>
			<li>
				<div class="overlay" id="1,3"></div>
			</li>
			<li>
				<div class="overlay" id="1,4"></div>
			</li>
			<li>
				<div class="matrixBorder" id="1,5"></div>
			</li>
			
			
			<li>
				<div class="matrixBorder" id="2,0"></div>
			</li>
			<li>
				<div class="overlay" id="2,1"></div>
			</li>
			<li>
				<div class="overlay" id="2,2"></div>
			</li>
			<li>
				<div class="overlay" id="2,3"></div>
			</li>
			<li>
				<div class="overlay" id="2,4"></div>
			</li>
			<li>
				<div class="matrixBorder" id="2,5"></div>
			</li>
			
			
			<li>
				<div class="matrixBorder" id="3,0"></div>
			</li>
			<li>
				<div class="overlay" id="3,1"></div>
			</li>
			<li>
				<div class="overlay" id="3,2"></div>
			</li>
			<li>
				<div class="overlay" id="3,3"></div>
			</li>
			<li>
				<div class="overlay" id="3,4"></div>
			</li>
			<li>
				<div class="matrixBorder" id="3,5"></div>
			</li>
			
			
			<li>
				<div class="matrixBorder" id="4,0"></div>
			</li>
			<li>
				<div class="overlay" id="4,1"></div>
			</li>
			<li>
				<div class="overlay" id="4,2"></div>
			</li>
			<li>
				<div class="overlay" id="4,3"></div>
			</li>
			<li>
				<div class="overlay" id="4,4"></div>
			</li>
			<li>
				<div class="matrixBorder" id="4,5"></div>
			</li>
			
			
			
			<li>
				<div class="matrixBorder" id="5,0"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="5,1"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="5,2"></div>
			</li>
			
			<li>
				<div class=" matrixBorder" id="5,3"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="5,4"></div>
			</li>
			
			<li>
				<div class="matrixBorder" id="5,5"></div>
			</li>
		</ul>
		



	</div>
	<div style="display : none; margin-top: 50% " class = "panel panel-default" id="banner" >
 <center><h1 ><span id="gameMessage"></span></h1>
 
 
 
 <button onclick="window.location.reload();" class="btn btn-dark" style="
    margin-top: 2%;
"> <i class="fa-solid fa-rotate-right"></i></button>
 
 </center>
</div>
</div>
</body>
</html>
