
function matchSubmitButton(event){
  event.preventDefault();
  let generateDay   = $("#match_day").val();

  $.ajax({
    type: "POST",
    url: "/api/matches",
    data: JSON.stringify({
      day:generateDay
    }),
    contentType: "application/json",
    dataType: "json"
  })
  .success(function(data) {
    console.log(data.matches.name);
  });
}


function createMatchesTable(generateDay){
  $("#generate_match").after(

  )
}

$(document).ready(function() {
  $('#generate_match').bind('click', matchSubmitButton);
});
