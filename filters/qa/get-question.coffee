func_question = __F 'question'
func_comment = __F 'comment'
module.exports = (req,res,next)->
  func_question.getById req.params.id,(error,question)->
    if error then next error
    else if not question then next new Error '不存在的问题'
    else
      res.locals.question = question
      func_comment.getAllByTargetId 'question_'+question.id,1,10,null,(error,comments)->
        res.locals.question_comments = comments
        next()