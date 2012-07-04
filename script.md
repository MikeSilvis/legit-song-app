tracks = trackList[document.location.href]
jQuery.post('http://severe-rain-7115.herokuapp.com/uploader', {
  tracks: tracks
});

tracks = trackList[document.location.href]
jQuery.post('http://localhost:3000/uploader', {
  tracks: tracks
});