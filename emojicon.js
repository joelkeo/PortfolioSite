const outputElement = document.getElementById('blinky');
    const l = ["0.0", "O.O", "o.o", "...", "o.o", "O.O"];
    
    function printToTerminal() {
      let index = 0;
      setInterval(function() {
        outputElement.textContent = l[index];
        index = (index + 1) % l.length;
      }, 250);
    }

    // Start the animation
    printToTerminal();

