document.addEventListener('turbo:load', function() {
  if (!sessionStorage.getItem('reloaded')) {
    sessionStorage.setItem('reloaded', 'true');
  } else {
    sessionStorage.removeItem('reloaded');
  }

  const mapContainer = document.getElementById('map');
  if (!mapContainer) return;

  mapboxgl.accessToken = 'pk.eyJ1IjoiamF5ZGVudGhlbHdlbGwwMiIsImEiOiJjbTZ0cndyaTgwNXhiMmpzaDhjdncwaDVwIn0.vwESy6q4sxuGiNrK-GbC7g';

  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/jaydenthelwell02/cm9kdczkw00wo01s82pcfe2fo',
    center: [-0.016, 51.576],
    zoom: 11,
    interactive: false
  });

  const locations = [
    { name: 'Wanstead', coords: [0.0250, 51.5768] },
    { name: 'Snaresbrook', coords: [0.022238, 51.58507] },
    { name: 'Aldersbrook', coords: [0.0335, 51.5628] },
    { name: 'South Woodford', coords: [0.0265, 51.5913] },
    { name: 'Whipps Cross', coords: [0.0001, 51.5815] },
    { name: 'Leytonstone', coords: [0.006519258113126995, 51.56969257331007] },
    { name: 'Leyton', coords: [-0.0140, 51.570910] },
    { name: 'Woodford Green', coords: [0.020895381189515065, 51.609893526988145] },
    { name: 'Woodford', coords: [0.0325, 51.6042] },
    { name: 'Walthamstow', coords: [-0.0179, 51.5839] },
    { name: 'Upper Clapton', coords: [-0.0542, 51.5664] },
    { name: 'Hackney', coords: [-0.0550, 51.5450] },
    { name: 'Stratford', coords: [0.0025, 51.5416] },
    { name: 'Forest Gate', coords: [0.0261, 51.5498] }
  ];

  locations.forEach(location => {
    new mapboxgl.Marker()
      .setLngLat(location.coords)
      .setPopup(new mapboxgl.Popup().setHTML(`<h3>${location.name}</h3>`))
      .addTo(map);
  });
});
