account = Account.find_or_create_by! phone_number: "254771437706", auth_token: "044a0fe3ae478104c344e5be8d4e3ea5", name: "Pampers"

wizard = Wizard.find_or_create_by start_keyword: "Pampers", account_id: account.id, name: "Pampers", reset_keyword: "reset"

step1 = Step.find_or_create_by(name: "Register", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step2 = Step.find_or_create_by(name: "Expectant", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step1.update(next_step_id: step2.id)
step3 = Step.find_or_create_by(name: "Weeks", account_id: account.id, wizard_id: wizard.id, step_type: "profile")
step2.update(next_step_id: step3.id)
step4 = Step.find_or_create_by(name: "Name", account_id: account.id, wizard_id: wizard.id, step_type: "profile")
step3.update(next_step_id: step4.id)
step5 = Step.find_or_create_by(name: "Advice", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step4.update(next_step_id: step5.id)
step6 = Step.find_or_create_by(name: "Tips", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step5.update(next_step_id: step6.id)
step7 = Step.find_or_create_by(name: "Pregnancy Tips", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step6.update(next_step_id: step7.id)
step8 = Step.find_or_create_by(name: "Relieve Stress", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step.7update(next_step_id: step8.id)
step9 = Step.find_or_create_by(name: "Staying Healthy", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step8.update(next_step_id: step9.id)
step10 = Step.find_or_create_by(name: "Staying Healthy 2", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step9.update(next_step_id: step10.id)
step11 = Step.find_or_create_by(name: "How many weeks", account_id: account.id, wizard_id: wizard.id, step_type: "free-text")
step10.update(next_step_id: step11.id)
step12 = Step.find_or_create_by(name: "Week 4", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step11.update(next_step_id: step12.id)
step13 = Step.find_or_create_by(name: "More on week 4", account_id: account.id, wizard_id: wizard.id, step_type: "menu")
step12.update(next_step_id: step13.id)
step14 = Step.find_or_create_by(name: "Username", account_id: account.id, wizard_id: wizard.id, step_type: "profile")

Command.find_or_create_by! name: "help", action_path: "/help"
Command.find_or_create_by! name: "menu", action_path: "/menu", step_id: step6
Command.find_or_create_by! name: "diet", action_path: "/diet", step_id: step10
Command.find_or_create_by! name: "shower", action_path: "/shower"
Command.find_or_create_by! name: "chat", action_path: "/chat", step_id: step14
Command.find_or_create_by! name: "spin", action_path: "/spin"

question1 = Question.find_or_create_by! text: "Welcome to the Pampers Village, Please register your baby and yourself to get helpful tips and offers from Pampers", account_id: account.id, step_id: step1
question2 = Question.find_or_create_by! text: "Are you expectant or is your baby born?", account_id: account.id, step_id: step2
question3 = Question.find_or_create_by! text: "How long have you been pregnant in weeks. Don’t worry you don’t have to be precise?", account_id: account.id, step_id: step3
question4 = Question.find_or_create_by! text: "Great, now please enter your name to finish the registration.", account_id: account.id, step_id: step4
question5 = Question.find_or_create_by! text: "Thanks for registering {{mother_name}}. Please choose an option below:", account_id: account.id, step_id: step5
question6 = Question.find_or_create_by! text: "Expecting a baby? We'll guide you through every step of this beautiful journey, from finding out you're pregnant to holding your little one for the first time", account_id: account.id, step_id: step6
question7 = Question.find_or_create_by! text: "Learn how to spot early symptoms, choose the right doctor, and stay relaxed during these first few weeks.", account_id: account.id, step_id: step7
question8 = Question.find_or_create_by! text: "Pregnancy can be stressful as your body undergoes many changes. Here are a few tips to help you relax\t\r\n - Talk to your boss about reducing your work hours\r\n - Ask a friend or family member to help with some daily chores\r\n - Postpone any large travel plans or events.\r\n - Talk to someone about how you are feeling", account_id: account.id, step_id: step8
question9 = Question.find_or_create_by! text: "Your health and well-being are the foundation for your baby's growth and development. Pick up tips on nutrition, exercise, and safety during pregnancy", account_id: account.id, step_id: step9
question10 = Question.find_or_create_by! text: "Now you’re pregnant, eating for two doesn’t actually mean doubling your food intake.  In fact, most pregnant women only need about 300 additional calories per day\r\n\r\nWith this in mind, maintain a balanced diet for a healthy pregnancy across the 5 main food groups:\r\nFruits\r\nVegetables\r\nGrains\r\nprotein foods\r\nDairy", account_id: account.id, step_id: step10
question11 = Question.find_or_create_by! text: "Week by week, your baby grows and develops in wonderful ways. Use our tool to keep track and stay informed throughout your pregnancy.\r\n\r\nGet started by entering how many weeks you have been pregnant.", account_id: account.id, step_id: step11
question12 = Question.find_or_create_by! text: "Your Baby at week 4\v:\r\n\r\nThe great divide. Once implanted in the side of your uterus, the fertilized egg divides into layers of cells and officially becomes an embryo. These cell layers will grow into specialized parts of your little one's body, such as the nervous system, skeleton, muscles, and organs. \v\vSupport system under way. The placenta, the disk-like organ that connects your circulation to the embryo's, begins to form and attaches to the uterine wall where the egg is implanted. ", account_id: account.id, step_id: step12
question13 = Question.find_or_create_by! text: "The umbilical cord comes out of one side of the placenta. The amniotic fluid, which will cushion your little one throughout the pregnancy, is already forming inside an encircling sac. \v\vMeasuring up. By the end of the week, the embryo measures around 0.04 inch — about the size of a poppy seed.", account_id: account.id, step_id: step13
question14 = Question.find_or_create_by! text: "You need to create a username for you to use the chat feature. Please reply with your preferred username.", account_id: account.id, step_id: step14

Option.find_or_create_by! key: "1", text: "Register Your Baby", question_id: question1, account_id: account.id, next_step_id: step2
Option.find_or_create_by! key: "2", text: "About Pampers", question_id: question1, account_id: account.id
Option.find_or_create_by! key: "1", text: " I am expectant", question_id: question2, account_id: account.id
Option.find_or_create_by! key: "2", text: " My baby has been born", question_id: question2, account_id: account.id
Option.find_or_create_by! key: "1", text: "Pregnancy advice", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "2", text: "Newborn baby advice", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "3", text: "Baby advice", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "4", text: "Toddler advice", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "5", text: "Pampers Offers", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "6", text: "About Pampers", question_id: question5, account_id: account.id
Option.find_or_create_by! key: "1", text: "Early pregnancy tips", question_id: question6, account_id: account.id
Option.find_or_create_by! key: "2", text: "Staying Healthy", question_id: question6, account_id: account.id, next_step_id: step9
Option.find_or_create_by! key: "3", text: "Help with Giving Birth", question_id: question6, account_id: account.id
Option.find_or_create_by! key: "4", text: "Pregnancy Calendar", question_id: question6, account_id: account.id, next_step_id: step11
Option.find_or_create_by! key: "5", text: "Baby Shower tips", question_id: question6, account_id: account.id
Option.find_or_create_by! key: "6", text: "Home", question_id: question6, account_id: account.id, next_step_id: step5
Option.find_or_create_by! key: "1", text: "How to relieve stress", question_id: question7, account_id: account.id
Option.find_or_create_by! key: "2", text: "How to make the announcement", question_id: question7, account_id: account.id
Option.find_or_create_by! key: "3", text: "How to choose a good doctor", question_id: question7, account_id: account.id
Option.find_or_create_by! key: "4", text: "Surviving morning sickness", question_id: question7, account_id: account.id
Option.find_or_create_by! key: "5", text: "More tips", question_id: question7, account_id: account.id
Option.find_or_create_by! key: "6", text: "Home", question_id: question7, account_id: account.id, next_step_id: step5
Option.find_or_create_by! key: "1", text: "Continue reading", question_id: question8, account_id: account.id
Option.find_or_create_by! key: "2", text: "Back to Early Pregnancy tips", question_id: question8, account_id: account.id, next_step_id: step7
Option.find_or_create_by! key: "3", text: "Home", question_id: question8, account_id: account.id, next_step_id: step5
Option.find_or_create_by! key: "1", text: "Pregnancy Diet", question_id: question9, account_id: account.id, next_step_id: step10
Option.find_or_create_by! key: "2", text: "Exercise during pregnancy", question_id: question9, account_id: account.id
Option.find_or_create_by! key: "3", text: "Managing your moods", question_id: question9, account_id: account.id
Option.find_or_create_by! key: "4", text: "Surviving morning sickness", question_id: question9, account_id: account.id
Option.find_or_create_by! key: "5", text: "More tips", question_id: question9, account_id: account.id
Option.find_or_create_by! key: "6", text: "Home", question_id: question9, account_id: nil, next_step_id: step5
Option.find_or_create_by! key: "1", text: "Continue reading", question_id: question10, account_id: account.id
Option.find_or_create_by! key: "2", text: "Back to Early Pregnancy tips", question_id: question10, account_id: account.id, next_step_id: step7
Option.find_or_create_by! key: "3", text: "Home", question_id: question10, account_id: account.id, next_step_id: step5
Option.find_or_create_by! key: "1", text: "Continue reading", question_id: question12, account_id: account.id
Option.find_or_create_by! key: "2", text: "Back to Early Pregnancy tips", question_id: question12, account_id: account.id, next_step_id: step7
Option.find_or_create_by! key: "3", text: "Home", question_id: question12, account_id: account.id, next_step_id: step5
Option.find_or_create_by! key: "1", text: "Back to Early Pregnancy tips", question_id: question13, account_id: account.id, next_step_id: step7
Option.find_or_create_by! key: "2", text: "Home", question_id: question13, account_id: account.id, next_step_id: step5

Tip.find_or_create_by! name: "Week 4", body: "You are now in week 4", week: 4
Tip.find_or_create_by! name: "Week 8", body: "You are now in week 8. ", week: 8
Tip.find_or_create_by! name: "Week 12", body: "You are now in week 12. Can't wait to sell you Pampers. ;)", week: 12
