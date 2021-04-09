$(function() {
  function buildChildHTML(children) {
    let html = `
      <a class="children-category" id="${children.id}" href="/">
        ${children.name}
      </a>
    `;
    return html;
  }

  $('.parent-category').on('mouseover', function() {
    let id = this.id;
    $('.children-category').remove();
    $('.grandchildren-category').remove();
    $.ajax({
      type: 'GET',
      url: '/get_category/new',
      data: {
        parent_id: id,
      },
      dataType: 'json',
    }).done(function(children) {
      children.forEach(function(child) {
        let html = buildChildHTML(child);
        $('.children-list').append(html);
      });
    });
  });

  function buildGrandChildHTML(children) {
    let html = `
      <a class="grandchildren-category" id="${children.id}" href="/">
        ${children.name}
      </a>
    `;
    return html;
  }

  $(document).on('mouseover', '.children-category', function() {
    let id = this.id;
    $.ajax({
      type: 'GET',
      url: '/get_category/new',
      data: {
        parent_id: id,
      },
      dataType: 'json',
    }).done(function(children) {
      children.forEach(function(child) {
        let html = buildGrandChildHTML(child);
        $('.grandchildren-list').append(html);
      });
      $(document).on('mouseover', '.children-category', function() {
        $('.grandchildren-category').remove();
      });
    });
  });
});