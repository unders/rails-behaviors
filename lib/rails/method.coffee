# Allow links to be followed with an alternate method
# using `data-method`.
#
#     <a href="/posts/1" data-method="delete">Delete</a>
#
# To fake this, a hidden form element is created on the fly
# and is submitted.
#
# In older versions of Rails, `link_to` would generated a
# bunch of inline JS to accomplish this.
#
#     <%= link_to "Delete", "/posts/1", :method => :delete %>
#

$(document).delegate 'a[data-method]', 'click', (event) ->
  element = $(this)

  # Don't handle remote requests
  return if element.is 'a[data-remote]'

  # Create a dummy form
  form = document.createElement 'form'
  form.method = 'POST'
  form.action = element.attr 'href'
  form.style.display = 'none'

  # Set `_method` to simulate other methods like PUT and DELETE.
  input = document.createElement 'input'
  input.setAttribute 'type', 'hidden'
  input.setAttribute 'name', '_method'
  input.setAttribute 'value', element.attr 'data-method'
  form.appendChild input

  # Add it to the document and fire it off
  document.body.appendChild form
  $(form).submit()

  # Prevent default action so we don't follow the link
  event.preventDefault()
  false