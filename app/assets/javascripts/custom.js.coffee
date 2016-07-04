@add_fields = (link, association, content) ->
  new_id = (new Date).getTime()
  regexp = new RegExp('new_' + association, 'g')
  element = $('.choice .nested-fields:last')
  $(content.replace(regexp, new_id)).insertAfter(element)

@remove_fields = (link) ->
  ip = $(link).parent().find('input[type=\'hidden\']')
  $(ip).val 'true'
  $(link).closest('.nested-fields').hide()

$(document).on 'ready page:load', ->
  $('#question_question_type').change ->
    if $('#question_question_type').val() == 'text'
      $('.choice').hide()
      $('.text').show()
    else
      $('.check_box_answer').attr 'checked', false
      $('.text').hide()
      $('.choice').show()

  $(document).on 'click', '.check_box_answer', ->
    if $('#question_question_type').val() == 'single_choice'
      $('.check_box_answer').not(this).attr 'checked', false
      $(this).attr 'checked', true

  $(document).on 'click', '#create_question', ->
    if $('#question_question_type').val() != 'text'
      form = $('.choice .nested-fields:visible')
      if form.length <= 0
        alert 'Need at least one answer'
        return false
      else
        not_correct_flag = true
        form.each ->
          if $(this).find('.answer_form').val() != '' && $(this).find('.check_box_answer').is(':checked')
            not_correct_flag = false
            return true
        if not_correct_flag
          alert 'Need at least one answer with correct'
          return false
    else
      if $('.text .nested-fields:visible').find('.answer_form').val() == ''
        alert 'Need fill blank box'
        return false
      return true
