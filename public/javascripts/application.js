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

// Adapted from http://gist.github.com/58761
// -- Written by David Heinemeier Hansson
var DateHelper = {
  // Takes the format of "Jan 15, 2007 15:45:00 GMT" and converts it
  // to a relative time Ruby strftime: %b %d, %Y %H:%M:%S GMT
  time_ago_in_words_with_parsing: function(from, age) {
    var date = new Date;
    date.setTime(Date.parse(from));
    return this.time_ago_in_words(date, age);
  },

  time_ago_in_words: function(from, age) {
    return this.distance_of_time_in_words(new Date, from, age);
  },

  distance_of_time_in_words: function(to, from, age) {
    var distance_in_seconds = ((to - from) / 1000);
    var distance_in_minutes = (distance_in_seconds / 60).floor();
    if (age && distance_in_minutes > age) { return false; }
    if (distance_in_minutes == 0) { return 'less than a minute ago'; }
    if (distance_in_minutes == 1) { return 'a minute ago'; }
    if (distance_in_minutes < 55) { return distance_in_minutes + ' minutes ago'; }
    if (distance_in_minutes < 90) { return '1 hour ago'; }
    if (distance_in_minutes < 1440) { return (distance_in_minutes / 60).floor() + ' hours ago'; }
    if (distance_in_minutes < 2880) { return '1 day ago'; }
    if (distance_in_minutes < 43200) { return (distance_in_minutes / 1440).floor() + ' days ago'; }
    if (distance_in_minutes < 86400) { return '1 month ago'; }
    if (distance_in_minutes < 525960) { return (distance_in_minutes / 43200).floor() + ' months ago'; }
    if (distance_in_minutes < 1051199) { return 'about 1 year ago'; }

    return 'over ' + (distance_in_minutes / 525960).floor() + ' years ago';
  },

  // Take all of the times embedded in <span time="">time</span>
  convert_all_times_to_words: function(enclosure) {
    var selector = 'span[time]';
    if (enclosure) { selector = enclosure + " " + selector; }
    $$(selector).each(function(e) {
      var time = e.getAttribute('time');
      var words = this.time_ago_in_words_with_parsing(time, 43200);
      if (words) { e.innerHTML = words; }
    }, this);
  }
};
