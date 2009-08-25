// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function edit_board_layout(table_id, data_id) {
  var tbody = $(table_id);
  var data_field = $(data_id);
  var layout = eval(data_field.value);

  // Iterate over the layout array and build a table
  try {
    for (var i = 0; i < layout.length; ++i) {
      var row = layout[i];
      var tr = new Element("tr");
      tbody.appendChild(tr);
      for (var j = 0; j < row.length; ++j) {
        var name = row[j];
        var id = "l_" + i + "_" + j;
        var td = new Element("td", {id: id});
        td.idx_i = i;
        td.idx_j = j;
        tr.appendChild(td);
        td.update(name);
        Droppables.add(id, {
          onDrop: function(drag) {
            var name = drag.id.replace(/board_/, '');
            layout[this.element.idx_i][this.element.idx_j] = name;
            data_field.value = layout.toSource();
            this.element.update(name);
          }
        });
      }
    }
  } catch (ex) {
    alert("Board layout: " + ex);
    debugger;
  }
  return true;
}