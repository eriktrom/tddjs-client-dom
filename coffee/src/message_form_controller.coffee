do ->

  chat = tddjs.namespace("chat")

  chat.messageFormController =
    Object.create(chat.formController)