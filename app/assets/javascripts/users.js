function changeStatus(event) {
  event.preventDefault();
  button = this;
  console.log(event);
  console.log(button);

  $.ajax({
    type: "PATCH",
    url: " /users/"+button.id+".json",
    contentType: "application/json",
    dataType: "json",
    // data: JSON.stringify({ id: button.id})
  })
  .done(function(data){
    console.log(data);
    button = $(`.status-change[id=${data.id}]`);
    console.log(button);
    tableRow = button.parent().parent();
    tableCollumStatus = tableRow.children()[1];
    buttonMessage = data.status == "admin" ? "Demote" : "Promote";
    button[0].innerHTML = buttonMessage;
    tableCollumStatus.innerHTML = data.status;
  })
  .fail();
};


$(document).ready(function(){
  $(".status-change").bind('click',changeStatus);
});
