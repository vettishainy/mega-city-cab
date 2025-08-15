document.addEventListener("DOMContentLoaded", function () {
    var map = L.map('map').setView([7.8731, 80.7718], 7); // Sri Lanka center
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

    // Fetch locations from bookingConfirmation.jsp (or backend API)
    var locations = [
        { lat: 9.6615, lon: 80.0255, name: "Jaffna" }, // Example Pickup
        { lat: 7.8731, lon: 80.7718, name: "Stop 1" },  // Example Stop
        { lat: 6.9271, lon: 79.8612, name: "Colombo" }  // Example Destination
    ];

    var route = [];
    locations.forEach(loc => {
        L.marker([loc.lat, loc.lon]).addTo(map).bindPopup(loc.name);
        route.push([loc.lat, loc.lon]);
    });

    // Draw polyline for route
    L.polyline(route, { color: 'blue' }).addTo(map);
});
