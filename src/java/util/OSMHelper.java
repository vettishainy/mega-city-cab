package com.mc_cab.util;

public class OSMHelper {

    // Generates the JavaScript code to display the map with Leaflet.js
    public static String generateOSMMapScript(double lat, double lon) {
        return "<script>" +
                "var map = L.map('map').setView([" + lat + ", " + lon + "], 13);" +
                "L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {" +
                "    attribution: '&copy; OpenStreetMap contributors'" +
                "}).addTo(map);" +
                "</script>";
    }
}
