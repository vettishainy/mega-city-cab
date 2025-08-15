document.getElementById("add-stop").addEventListener("click", function() {
    let stopContainer = document.getElementById("stop-container");
    let stopInput = document.createElement("input");
    stopInput.type = "text";
    stopInput.name = "stops[]";
    stopInput.className = "stop-input";
    stopContainer.appendChild(stopInput);
});
