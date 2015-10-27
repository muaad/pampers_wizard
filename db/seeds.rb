account = Account.create!(phone_number: "254771437706", auth_token: "044a0fe3ae478104c344e5be8d4e3ea5", name: "Pampers")

wizard = Wizard.create!(start_keyword: "Pampers", account_id: account.id, name: "Pampers", reset_keyword: "reset")

register = Step.create!(name: "Register", account_id: account.id, wizard_id: wizard.id, next_step_id: expectant.id, step_type: "menu")
expectant = Step.create!(name: "Expectant", account_id: account.id, wizard_id: wizard.id, next_step_id: weeks.id, step_type: "menu")
weeks = Step.create!(name: "Weeks", account_id: account.id, wizard_id: wizard.id, next_step_id: name.id, step_type: "profile")
name = Step.create!(name: "Name", account_id: account.id, wizard_id: wizard.id, next_step_id: advice.id, step_type: "profile")
advice = Step.create!(name: "Advice", account_id: account.id, wizard_id: wizard.id, next_step_id: tips.id, step_type: "menu")
tips = Step.create!(name: "Tips", account_id: account.id, wizard_id: wizard.id, next_step_id: pregnancy_tips.id, step_type: "menu")
pregnancy_tips = Step.create!(name: "Pregnancy Tips", account_id: account.id, wizard_id: wizard.id, next_step_id: relieve_stress.id, step_type: "menu")
relieve_stress = Step.create!(name: "Relieve Stress", account_id: account.id, wizard_id: wizard.id, next_step_id: staying_healthy.id, step_type: "menu")
staying_healthy = Step.create!(name: "Staying Healthy", account_id: account.id, wizard_id: wizard.id, next_step_id: staying_healthy2, step_type: "menu")
staying_healthy2 = Step.create!(name: "Staying Healthy 2", account_id: account.id, wizard_id: wizard.id, next_step_id: how_many_weeks.id, step_type: "menu")
how_many_weeks = Step.create!(name: "How many weeks", account_id: account.id, wizard_id: wizard.id, next_step_id: week4.id, step_type: "free-text")
week4 = Step.create!(name: "Week 4", account_id: account.id, wizard_id: wizard.id, next_step_id: more.id, step_type: "menu")
more = Step.create!(name: "More on week 4", account_id: account.id, wizard_id: wizard.id, step_type: "menu")

Command.create!([
  {name: "help", action_path: "/help"},
  {name: "menu", action_path: "/menu", step_id: tips.id},
  {name: "diet", action_path: "/diet", step: staying_healthy2},
  {name: "shower", action_path: "/shower"}
])

question1 = Question.create! text: "Welcome to the Pampers Village, Please register your baby and yourself to get helpful tips and offers from Pampers", account_id: account.id, step: register
question2 = Question.create! text: "Are you expectant or is your baby born?", account_id: account.id, step_id: expectant.id
question3 = Question.create! text: "How long have you been pregnant in weeks. Don’t worry you don’t have to be precise?", account_id: account.id, step_id: weeks.id
question4 = Question.create! text: "Great, now please enter your name to finish the registration.", account_id: account.id, step_id: name.id
question5 = Question.create! text: "Thanks for registering {{mother_name}}. Please choose an option below:", account_id: account.id, step_id: advice.id
question6 = Question.create! text: "Expecting a baby? We'll guide you through every step of this beautiful journey, from finding out you're pregnant to holding your little one for the first time", account_id: account.id, step_id: tips.id
question7 = Question.create! text: "Learn how to spot early symptoms, choose the right doctor, and stay relaxed during these first few weeks.", account_id: account.id, step_id: pregnancy_tips.id
question8 = Question.create! text: "Pregnancy can be stressful as your body undergoes many changes. Here are a few tips to help you relax\t\r\n - Talk to your boss about reducing your work hours\r\n - Ask a friend or family member to help with some daily chores\r\n - Postpone any large travel plans or events.\r\n - Talk to someone about how you are feeling", account_id: account.id, step_id: relieve_stress.id
question9 = Question.create! text: "Your health and well-being are the foundation for your baby's growth and development. Pick up tips on nutrition, exercise, and safety during pregnancy", account_id: account.id, step_id: staying_healthy.id
question10 = Question.create! text: "Now you’re pregnant, eating for two doesn’t actually mean doubling your food intake.  In fact, most pregnant women only need about 300 additional calories per day\r\n\r\nWith this in mind, maintain a balanced diet for a healthy pregnancy across the 5 main food groups:\r\nFruits\r\nVegetables\r\nGrains\r\nprotein foods\r\nDairy", account_id: account.id, step: staying_healthy2
question11 = Question.create! text: "Week by week, your baby grows and develops in wonderful ways. Use our tool to keep track and stay informed throughout your pregnancy.\r\n\r\nGet started by entering how many weeks you have been pregnant.", account_id: account.id, step: how_many_weeks
question12 = Question.create! text: "Your Baby at week 4\v:\r\n\r\nThe great divide. Once implanted in the side of your uterus, the fertilized egg divides into layers of cells and officially becomes an embryo. These cell layers will grow into specialized parts of your little one's body, such as the nervous system, skeleton, muscles, and organs. \v\vSupport system under way. The placenta, the disk-like organ that connects your circulation to the embryo's, begins to form and attaches to the uterine wall where the egg is implanted. ", account_id: account.id, step: week4
question13 = Question.create! text: "The umbilical cord comes out of one side of the placenta. The amniotic fluid, which will cushion your little one throughout the pregnancy, is already forming inside an encircling sac. \v\vMeasuring up. By the end of the week, the embryo measures around 0.04 inch — about the size of a poppy seed.", account_id: account.id, step: more

Option.create!([
  {key: "1", text: "Register Your Baby", question_id: question1, account_id: account.id, next_step_id: expectant.id},
  {key: "2", text: "About Pampers", question_id: question1, account_id: account.id},
  {key: "1", text: " I am expectant", question_id: question2, account_id: account.id},
  {key: "2", text: " My baby has been born", question_id: question2, account_id: account.id},
  {key: "1", text: "Pregnancy advice", question_id: question5, account_id: account.id},
  {key: "2", text: "Newborn baby advice", question_id: question5, account_id: account.id},
  {key: "3", text: "Baby advice", question_id: question5, account_id: account.id},
  {key: "4", text: "Toddler advice", question_id: question5, account_id: account.id},
  {key: "5", text: "Pampers Offers", question_id: question5, account_id: account.id},
  {key: "6", text: "About Pampers", question_id: question5, account_id: account.id},
  {key: "1", text: "Early pregnancy tips", question_id: question6, account_id: account.id},
  {key: "2", text: "Staying Healthy", question_id: question6, account_id: account.id, next_step_id: staying_healthy.id},
  {key: "3", text: "Help with Giving Birth", question_id: question6, account_id: account.id},
  {key: "4", text: "Pregnancy Calendar", question_id: question6, account_id: account.id, next_step_id: how_many_weeks.id},
  {key: "5", text: "Baby Shower tips", question_id: question6, account_id: account.id},
  {key: "6", text: "Home", question_id: question6, account_id: account.id, next_step_id: advice.id},
  {key: "1", text: "How to relieve stress", question_id: question7, account_id: account.id},
  {key: "2", text: "How to make the announcement", question_id: question7, account_id: account.id},
  {key: "3", text: "How to choose a good doctor", question_id: question7, account_id: account.id},
  {key: "4", text: "Surviving morning sickness", question_id: question7, account_id: account.id},
  {key: "5", text: "More tips", question_id: question7, account_id: account.id},
  {key: "6", text: "Home", question_id: question7, account_id: account.id, next_step_id: advice.id},
  {key: "1", text: "Continue reading", question_id: question8, account_id: account.id},
  {key: "2", text: "Back to Early Pregnancy tips", question_id: question8, account_id: account.id, next_step_id: pregnancy_tips.id},
  {key: "3", text: "Home", question_id: question8, account_id: account.id, next_step_id: advice.id},
  {key: "1", text: "Pregnancy Diet", question_id: question9, account_id: account.id, next_step_id: staying_healthy2},
  {key: "2", text: "Exercise during pregnancy", question_id: question9, account_id: account.id},
  {key: "3", text: "Managing your moods", question_id: question9, account_id: account.id},
  {key: "4", text: "Surviving morning sickness", question_id: question9, account_id: account.id},
  {key: "5", text: "More tips", question_id: question9, account_id: account.id},
  {key: "6", text: "Home", question_id: question9, next_step_id: advice.id},
  {key: "1", text: "Continue reading", question_id: question10, account_id: account.id},
  {key: "2", text: "Back to Early Pregnancy tips", question_id: question10, account_id: account.id, next_step_id: pregnancy_tips.id},
  {key: "3", text: "Home", question_id: question10, account_id: account.id, next_step_id: advice.id},
  {key: "1", text: "Continue reading", question_id: question12, account_id: account.id},
  {key: "2", text: "Back to Early Pregnancy tips", question_id: question12, account_id: account.id, next_step_id: pregnancy_tips.id},
  {key: "3", text: "Home", question_id: question12, account_id: account.id, next_step_id: advice.id},
  {key: "1", text: "Back to Early Pregnancy tips", question_id: question13, account_id: account.id, next_step_id: pregnancy_tips.id},
  {key: "2", text: "Home", question_id: question13, account_id: account.id, next_step_id: advice.id}
])