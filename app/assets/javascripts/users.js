function changeStatus(event) {
  event.preventDefault();
  button = this;
  console.log(event);
  console.log(button);
  
  $.ajax({
    type: "PATCH",
    url: " /users/"+button[0].id+".json",
    contentType: "application/json",
    dataType: "json"
    data: JSON.stringify({ id: button[0].id});
  })
  .done(function(data){
    console.log(data);

  })
  .fail()
};


$(document).ready(function(){
  $(".status-change").bind('submit',);
});
