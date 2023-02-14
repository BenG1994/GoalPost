# GoalPost

GoalPost is an app that allows the user to add long-term or short-term goals and add a tally to them until they are completed. Users can then delete the goal to make room for more.

## Introduction

GoalPost is from a tutorial by Devslopes with the focus on working with CoreData and saving user input data.

## Skills used

* CoreData
* TableView actions

## Process and challenges

Although I had some prior experience using CoreData and it's funcitonality, I wanted further practice and implementaiton of it and found this a very good use case. A goal-type app is a simple way of incorporating saving user data. The UI is clean and simple, which makes the app feel streamlined and professional.

The first step of setup was creating the main tableview for the main screen. The process was straightforward and the same as adding any tableview. What was different was to get the text showing if the table had no entries. To do that, the label was placed on top of the tableview, but was programmatically hidden and unhidden depending on the number of goals a person had entered. In addition to beginning the app's UI, I created the CoreData entity to store all the data. Attritbutes included the descirption (the text the user puts in), the type (short-term or long-term), the total goal (how many times the user wants to do the goal to complete it), and then the progress to track if the goal is complete or not.

Once that was complete, the next step was creating a view where user entered the text for their goal, what they wanted to accomplish, and if it was a short-term or long-term goal. All these elements are simple labels and buttons that one would expect. The short-term and long-term buttons were programmed to change colors on whether one is selected or not. 

The third view controller was to input the number of times a user would like to do the goal for. Using an init function on this view controller, I was able to pass in the data from the second view controller where users wrote their goals down to save them using CoreData in the final view controller. An interesting hiccup I found in this step was originally the data wasn't passing from the second view controller to the final on to save properly in CoreData. What I found out through some searching and trial and error, I found that if you segue between view controllers, data is not saved as it's a completely new instance of the view, but if you simply present the following view, everything worked as it was intended.

After figuring out the transition errors and creating a reference to the CoreData context to save the data, everything was ready to test. To finish up adding a goal, I used an unwind segue to return back to the main tableview with the newly added goal visible after reloading the data.

![Simulator Screen Recording - iPhone 14 Pro - 2023-02-13 at 19 20 05](https://user-images.githubusercontent.com/113778995/218615587-d3065edd-588c-4449-aa09-6219881a2082.gif)

Now to allow users to delete their goals, I added an action to the tableview. The action included two fucntions, one to delete the goal by deleting it from the context, and the second to reload the data to show that it's been removed and save it. After that, I added another action to add a count to each of the goals that go towards their progress. It was as simple as adding 1 to the goal count until it was equal to the total count the user set while adding the goal initially.

![Simulator Screen Recording - iPhone 14 Pro - 2023-02-13 at 19 20 50](https://user-images.githubusercontent.com/113778995/218616682-67d81137-49fa-44db-a080-0182a495ba36.gif)

The final thing I added to the goals where to show when the goal was completed. Similarly to the blank tableview, I added a colored view on top of the tableview that was programmatically hidden and unhidden for each cell depending on if it hits the completion goal or not. It is slightly transparent so you can read what goal was completed.

![Simulator Screen Recording - iPhone 14 Pro - 2023-02-13 at 19 21 29](https://user-images.githubusercontent.com/113778995/218617018-700e1296-310f-4b6f-a764-d146880c459e.gif)

Something that was added that was interesting as well was a function that allow the next button to move up and down when the keyboard was show. As an extension of UIView and by grabbing the starting and ending frame, I was able to essentially lock the button the top of the keyboard whenever it was accessed.

![Simulator Screen Recording - iPhone 14 Pro - 2023-02-13 at 19 50 31](https://user-images.githubusercontent.com/113778995/218617830-5466673d-6508-4867-862c-9f01a20849c2.gif)


## Reflection

While the app might seem simple and straightforward, and certain parts of it were, it was good practice and implementation of skills and tools that are standard for any kind of apps made today. This tutorial shows that even a simple app idea with clean code and UI can be finished and released quickly. It's a good way to practice the fundamentals while adjusting elements as you want to try something different as well.




