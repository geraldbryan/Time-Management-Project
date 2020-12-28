# Time Management Indicator

**Time management indicator** is an app that are created with R and have the purpose to help poeple out there to make the best of their time.
It already deployed on shiny app https://gerald.shinyapps.io/Time-Management-Indicator/, check it out and hope it will help you to improve your time management :) 

## Table of Contents 
[1. Introduction](#Intro)
[2. Exploratory Data Analysis](#EDA)
[3. Clustering](#Cluster)
[4. Association Rules](#Arules)
[5. About Application](#App)

<a name="Intro"></a>
### Introduction
**Time** is one of the things you cannot buy in life, everyone has the same amount of time each day but how we spend the time we have is up to ourselves. There is a quote that inspire me to make this time management app:
<br>
> **"Time is what we want the most, but what we use worst."** <br> - William Penn

The quote speaks for itself, we always say that we need more time to do something or we wish that we can turn back time because we regret not doing anything in the past. Fortunately we have a soft skills called **time management**, if we masters it there is a higher chance we can us time more wisely than before.

**Time management** is one of the most important soft skills that everyone must have. According to [mindtools team](https://www.mindtools.com/pages/article/newHTE_00.htm), time management is the process of organizing and planning how to divide your time between specific activities. The most important thing taht many people misunderstood is **Being busy is not same as being effective**, with a good time management skills we must do the work smarter not harder.

There are some benefit when we try to learn about time management such as greater productivity and efficiency, better professional reputation, less stress, increased opportunities for advancement, greater opportunities to achieve important life and career goals. Also, there are some things that we can eliminate such as missed deadlines, inefficient work flow, poor work quality, poor professional reputation and a stalled career.

<a name="EDA"></a>
### Exploratory Data Analysis
This project use the dataset from [Kaggle's Students Time Management Datasets](https://www.kaggle.com/xiaowenlimarketing/international-student-time-management). The datasets were collected using questionnaire by the author, there are 12 questions that are related about time management. Also that are other variables like age and gender that we used in this project. 

From the datasets the 12 question is answer by the likert scale of 1 to 5, where 1 is the worst and 5 is the best. At first we checked the **score distribution** to make sure it has a normal assumptions. __Score dist ss__

From the distribution above, we can see the the distribution is normal with an outlier with score above 50 and we decided that it is okay to use this dataset for our as our model to determine the time management quality.

After knowing the distribution of score, now let's see the age and gender statistics.

__age based on gender ss__

In the plot above we can see that the number of male and female is likely to be equal, but there are some significant difference in the matter of age. The majority of the respondent in the age of 21-25 and the least respondents are in the age above 25.

Let's see the gender and age of respondents based on the score of their questionnaire,

__age, gender, based on score__

From the plot above, it look like that female is slightly has the higher score than the male in every group of age. The worst score is in the group of age 18-20, it is a obvious thing because generally teens will tend to spend their time more carelessly.

From the data exploratoryof the datasets above we can conclude that **age and gender affect the time management score of person**, but it is not a exact condition. There are a lot of factor that can affect time management quality besides ages and genders. So, if you in the group of age and gender which tend to get lower time management quality do not be insecure becasue it not defined who you are.

<a name="Cluster"></a>
### Clustering

For the clustering to deterimine the time management quality, we used **K-Prototypes**. **K-Prototypes** is a clustering method which can handle a mixed type data, we used these algorithms instead of the famous K-means algorithms because most of our data is not numeric. The algorithms measures distance between numerical features using Euclidean distance (like K-means) but also measure the distance between categorical features using the number of matching categories.

Before we use the K-Prototypes algorithms, we try to determine the number of cluster using **Elbow Method**. **Elbow Method** consists of plotting the explained variation as a function of the number of clusters, and picking the elbow of the curve as the number of clusters to use.

__elbow plot__

From the result of the elbow method, we decide that the elbow of the curve is on number 3. Thus, we set the number cluster of 3 and translate it to the time management quality which are **'Good Time Management Quality'**, **'Normal Time Management Quality'**, and **'Bad Time Management Quality'**.

After obtaining the number of cluster, we begin to cluster the data and this is the result that we get,

__ss cluster ori__

From the graph, The majority of group **Good Time Management Quality** have scores above 40 and it so obvious thatthe higher the scores the better the time management quality. Unfortunaltely, how we clustering or grouping the data is not only by the scores that matters but also the answer of each question is matter for the grouping. That will explained how there are some data with lower scores get the **Good Time Management Quality** and some data with higher scores get **Bad Time Management Quality** or **Normal Time Management Quality**

If you wonder how we determine the name of group, we will answer the question now. It is so obvious after see the questionnaires and how it is score by likert scale that the higher your scores, the higher your time management quality. Because of that we made a boxplot of scores based on the group cluster, and we obtained this

__ss boxplot cluster__

We can see above that the group number 2 has the higher scores than the other 2 groups, so we decided that the group number 2 as group of **'Good Time Management Quality'**.
Also, we can see that group number 1 has the lowest score among all, so we decided that the group number 1 as group of **'Bad Time Management Quality'**. Last but not least, the group number 3 as group of **'Normal Time Management Quality'**

<a name="Arules"></a>
### Association Rules 

You must wonder why we use the association rules in this kind of data,What is the transaction of this data? doesn't it use to determine what product the customer will buy if they already buy one specific items? **Yes, that absolutely true**, we will use that association rules algorithm and use it differently. In this project we use association rules to determine what aspect tend to make you have a **'Good Time Management Quality'** or **'Bad Time Management Quality'**. If you think it confusing to determine the transaction in this kind of data, i will tell you it is not, **absolutely not**, we use the row as the transaction or 1 respondent as 1 transaction and the 12 questions, gender, and age as the items. We will divide this into two group **'Good Time Management Quality'** or **'Bad Time Management Quality'**.

#### Bad Time Management Quality
__ss bad time arules__

If you try the survey and fill the question like what it has shown above you will definitely will produce a **Bad Time Management Quality**. And the plot below is the interactive visualization that you can try in the shiny apps

__ss vis plotly bad__

#### Good Time Management Quality
__ss good time arules__

If you try the survey and fill the question like what it has shown above you will definitely will produce a **Good Time Management Quality**. And the plot below is the interactive visualization that you can try in the shiny apps

__ss vis plotly good__

I will not explain more about the association rules algorithms because it will be out of the topic. If you want to understand about how I use the association rules without transaction datasets you can see this [Rpubs by me](https://rpubs.com/geraldbryan_/690426). Overall why I use the association rules is just want to show you what action lead to bad and good time management quality. So, all of you can eliminate the action that will lead to bad time management quality and keep doing the action that will lead to good time management quality.

<a name="App"></a>
### About Application

#### Landing Page
__App landing page ss__

This is the landing page of **Time Management Indicator** app, in this landing page you can see there is an about menu in the top right corner. You can clik to it and see the summary, purpose, and sources of this app. Next to it, is the messages from us to welcome you in the app. In the main page there are two buttons that if you clik, it will show you what can you expect or what can you do in each menu.

#### Survey
__survey landing page__

Do not be afraid that the app is error or cannot work, **It is not**. It shown an error because the input data haven't been input yet show the plot is not shown. Fill your details in the lift side of the main page and the clik **'Start Test'**, and the it will bring you to the survey part.

__survey questionnarie__

After finishing fill out the 12 questions click **OK** button. Remember to be honest when you fill it, so you can get your actual result. Don't be hesitate to fill it, because we **do not keep your data**, After you close the app the data will be gone.

__plot result__

After you fill it and click ok button, then your result is shown in the plot. Your result will be shon in the shape of star, and whether you have good, normal, or bad time management quality can be determine by the colour of your star.

#### Recomendation
__ss recommendation__

There are three parts in this menu which is **Recommendation**, **Question List**, and **Association Rules**. For the recommendation part we scrap the action that we can do to have a good time management quality, for more details you can visit this [page](https://quickbooks.intuit.com/r/employee-management/time-management-tips/#:~:text=If%20you%20want%20to%20improve%20your%20time%20management,compare%20actual%20time%20spent%20and%20estimated%20time%20spent.). The **question list** part is the supporting part of **Association Rules**, the association rules only shown like 'X6' or 'X8' so we provide the answer behind those variables. We include the association rules in reccomendation because we try to inform you action that lead to bad time management quality that you must avoid and action that lead to good time management quality that you must maintain.

#### Statistics
In the statistics menu it will explain about the dataset itself which we already explain it in **Exploratory Data Analysis**, **Clustering**, and **Association Rules** parts. So I will not explain it more to avoid redundancy.

### Enjoy
I do not want you to take more time to read this, so just head to the shiny app, take the survey, and most important **Improve your time management quality** no matter of what groups you belong based on our survey. 
<br>
Lastly i want to provide you with another quote that i like:
> **"The bad news is time flies. The good news is you are the pilot"** <br> -Michael Altshuler

Thank you for read and use the apps, if you have any feedback feel free to contact us, cheers to the better us! :)
