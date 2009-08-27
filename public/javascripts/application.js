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
        td.className = name;
        td.idx_i = i;
        td.idx_j = j;
        tr.appendChild(td);
        if (name == "start") { td.update(name.humanize()); }
        Droppables.add(id, {
          onDrop: function(drag) {
            var name = drag.id.replace(/board_/, '');
            layout[this.element.idx_i][this.element.idx_j] = name;
            data_field.value = layout.toSource();
            this.element.className = name;
            if (name == "start") { this.element.update(name.humanize()); }
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

  String.prototype.humanize = function() {
    var str = this.replace(/[_-]+/g, ' ');
    var initial = this.charAt(0).toUpperCase();
    return initial + str.substr(1);
  }