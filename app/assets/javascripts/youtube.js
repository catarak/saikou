$(document).ready(function(){

  // user clicks button with cursor
  $(".song").click(function(){
    var query = $(this).text();
    videoSearch(query);
  });

  function videoSearch(query){
    $.ajax({
      type: "GET", 
      url: "/play_song", 
      data: {search_keyword: query}
    }).done(function(results){
      debugger;
      $("#search-results").html(results);
    });
  };

});


