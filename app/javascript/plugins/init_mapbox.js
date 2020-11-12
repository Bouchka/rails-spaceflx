import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.long, marker.lat ]));
 map.fitBounds(bounds, { padding: 100, maxZoom: 12, duration: 2000 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  // only build a map if there's a div#map
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    // Add markers to map
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.long, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });

    // Fit Map to Markers
    fitMapToMarkers(map, markers)

  }
};

export { initMapbox };
