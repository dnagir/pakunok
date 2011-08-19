updateTemplate = ->
  $('#haml-placeholder').html JST.sample {time: new Date().toString()}
  
f = -> alert 'Hi'

jQuery ->
  updateTemplate()
  $('#haml-update').click updateTemplate
