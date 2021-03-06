
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
    let tableArea = $("#generated_list");
    let message = $(`<p>${data.message}<p>`);
    let matches = data.matches
    let matchTable = $(`<ul class="nobullets"></ul>`);
    let students = data.students

    $.each(matches,function(index,value){
      let student1  =  getStudent(students,value.studenta_id);
      let student2  =  getStudent(students,value.studentb_id);
      let match = $(`<li>${student1} is matched with ${student2}</li>`);
      matchTable.append(match);
    })
    tableArea.append(message);
    tableArea.append(matchTable);
  });
}
function getStudent(students,studentId){
  $.each(students, function(index,value){  value.id == studentId ? name = value.name: null; });
  return name;
};

$(document).ready(function() {
  $('#generate_match').bind('click', matchSubmitButton);
});
