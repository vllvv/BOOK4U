function sleep(ms) {
  const loopTime = Date.now() + ms;
  while (Date.now() < loopTime) {}
}

while(true){
const button = document.getElementById('button');
	button.addEventListener('click', () => {
	  const input = document.getElementById('files');
	  putFile(input.files[0]);
	  sleep(500);
	})
		break;	
}