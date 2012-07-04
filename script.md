tracks = trackList[document.location.href]
jQuery.post('http://severe-rain-7115.herokuapp.com/uploader', {
  tracks: tracks
  });
