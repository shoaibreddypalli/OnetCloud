<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>


<html>
<head>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
.overlay {
	border: 1px solid transparent;
}

.overlay:focus {
	outline: none;
	border-color: #000000;
}

.buttonload {
	background-color: #000000; /* #04AA6D;  Green background */
	border: none; /* Remove borders */
	color: white; /* White text */
	padding: 10px 20px; /* Some padding */
	font-size: 16px; /* Set a font-size */
}

.button5 {
	border-radius: 50%;
} /*round*/
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
	font-family: -apple-system, sans-serif;
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

@media ( min-width : 768px) {
	.button-73 {
		font-size: 1.5rem;
		padding: .75rem 2rem;
	}
}
</style>
<style type="text/css">
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
	background-color: LightGray;
}
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/randomcolor/0.6.1/randomColor.min.js"
	integrity="sha512-vPeZ7JCboHcfpqSx5ZD+/jpEhS4JpXxfz9orSvAPPj0EKUVShU2tgy7XkU+oujBJKnWmu4hU7r9MMQNWPfXsYw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">

function shuffle(array) {
	  for (let i = array.length - 1; i > 0; i--) {
	    let j = Math.floor(Math.random() * (i + 1)); // random index from 0 to i
	    [array[i], array[j]] = [array[j], array[i]];
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
	  shuffle(fullColorList);

	  return fullColorList;
	}
	
function init(){
	
	var PAIRS_COUNT=8;
	  // Query elements
	  const colorItemList = document.querySelectorAll('.overlay');
	  randomColorList = getRandomColorPairs(PAIRS_COUNT);
		console.log(randomColorList);
	    // Binding events
	    colorItemList.forEach((item, idx) => {
	    	 item.style.backgroundColor = randomColorList[idx];
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
	element.style.backgroundColor = "#f2360b24";
	element.parentElement.style.pointerEvents = 'none'
		element.parentElement.setAttribute("isCellFree", "true");
	setTimeout(function() {
        resetColor(element)
    }, 1000);

	
}

function resetColor(element){
	element.style.backgroundColor = "LightGray";
}

var firstColor ="";
var firstElement;
var firstIndex=-1;
function selectSquare(item,idx){
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
	}else if(firstIndex!=idx){
		
		if(firstColor==overlayElement.style.backgroundColor){
			
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
	
  }
  
				 }});
			
			
			
			}else {
				console.log('different')
			}
		firstColor="";
		firstIndex=-1;
	}
		else {
			firstColor="";
			firstIndex=-1;
			console.log('same same')
}
}
</script>



<script>
<!--
<%
String clock = request.getParameter( "clock" );
if( clock == null ) clock = "180";
%>
var timeout = <%=clock%>;
function timer()
{
if( --timeout > 0 )
{
document.forma.clock.value = timeout;
window.setTimeout( "timer()", 1000 );
}
else
{
document.forma.clock.value = "Time over";
///disable submit-button etc
}
}
//-->
</script>

<script type="text/javascript">
var myVar=setInterval(function () {myTimer()}, 1000);
var counter = 0;
function myTimer() {
    var date = new Date();
    document.getElementById("demo").innerHTML = date.toUTCString();
}
</script>



<script type="text/javascript">
function start(){
	init();
	playAudio();
	
}

</script>

<meta charset="ISO-8859-1">
<title>OnetConnectLive</title>

</head>
<style>
div {
	background-color: LightGray;
}

h1 {
	text-shadow: 2px 2px red;
}
</style>
<body onload="start()">

	<!-- <audio id="audio" src="./audio/button.mp3"></audio> -->

	<script>
      function playAudio(){
         document.body.addEventListener("click", play)
       }
      function play() {
        var audio = document.getElementById("audio");
       // audio.play();
      }
</script>
	<center>
		<p>
		<h1>
			Welcome to Onet Connect Puzzle Game<br />
		</h1>
		</p>
	</center>
	<span id="demo"></span>
	</align>
	<br>
	<br>
	<!-- <button onClick="window.location.href=window.location.href">Play </button> -->

	<button onClick="window.location.reload();"
		class="buttonload button-73">
		Play <i class="fa-solid fa-house"></i>
	</button>

	<form action="<%=request.getRequestURL()%>" name="forma">
		<br> Time remaining: <input type="text" name="clock"
			value="<%=clock%>" style="border: 0px solid white">

	</form>
	<script>
<!--
timer();
//-->
</script>

	<div class="game__board">
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
</body>
</html>
