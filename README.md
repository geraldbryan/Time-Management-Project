# Time Management Indicator

**Time management indicator** is an app created to help you assess your time management quality, and also give you some recommendation to make it better.

It already deployed to shiny, just click this link to be the better you:  https://gerald.shinyapps.io/Time-Management-Indicator/

## Table of Contents 
[1. Introduction](#Intro)

[2. Exploratory Data Analysis](#EDA)

[3. Clustering](#Cluster)

[4. Association Rules](#Arules)

[5. About Application](#App)

<a name="Intro"></a>
## Introduction
**Time** is one of the things you cannot buy in life. Everyone has the same amount of time each day, but how we spend our time is up to us. There is a quote that inspires me to make this time management app:
<br>
> **"Time is what we want the most, but what we use worst."** <br> - William Penn

The quote speaks for itself, we always say that we need more time to do something or we wish that we can turn back time because we regret not doing something in the past.
<br>

Because of those reasons, we decided to make this app so you and hopefully all people will be a 'good' time manager for your time. :wink:

<a name="EDA"></a>
## Exploratory Data Analysis

We use the datasets from [Kaggle's Students Time Management Datasets](https://www.kaggle.com/xiaowenlimarketing/international-student-time-management) for this project.

Before we use it to make a model for assess your time management quality and the recommendation, it is very important to take a little look how is the data. Therefore I will start this project with the 'EDA' part.

The author of the dataset create this dataset using a questionnaire,therefore we'll strat the EDA part with the common parameters, which are age and gender.

![gender_age](image/age_gender.png)

 From the plot above, we can see that the order of the group of age from many to least are:
 1. The group age of 21-25 years old  
 2. The group age of 18-21 years old 
 3. The group age above 25 years old 
 
 It may be a slightly setbacks because the data did not have a large range of age, so we decided to group it and use that grouping of age to make the model. 
 
 In the matter of gender, it seems the number of female and male respondents are pretty equal. So, if we make the model use this data it is not gender's bias and can be a pretty good model.

 After talking about the gender and age of the respondents, next we'll move into the question's part. We have done some feature engineer to the data and make one additional variable, which is **score**. The questions have a likert scale answers, in the scale of 1-5. We use the scale to make the 'score' variable by adding all the answers, which will get us a maximum score of 60 and minimum score of 12 and here is the distribution:

![score_dist](image/score_dist.png) 

Fortunately, the distribution is quite good, so we can use this data to build the model. :partying_face:
<br>
It seems the data is normally distributed, but there is an outlier (a score above 50).

For the last EDA part, we will check the boxplot of the score based on age and gender.

![gender_age_score](image/age_gender_score.png)

* The plot above looks like that female slightly has a higher score than the male in every group of age,
* The worst score is in the age of 18-20,
* The highest score of female is in the group age of 21-25 and male in the group age above 25.

 **For the conclusion of this part we will give you three important points:**
* Age and Gender affect time management scores
* The score distribution is normally distributed
* There is an equal number of each gender

<a name="Cluster"></a>
## Clustering

For the clustering part, we used **K-Prototypes** to determine the time management quality.

We use **K-Prototypes** method because the algorithm is similiar with the famous clustering method (K-means), but the advantage of this method is, it can be used for mixed type data which what our data look likes now.


Before do the clustering part, we try to determine the number of clusters using the Elbow Method. **Elbow Method** consists of plotting the explained variation as a function of the number of clusters, the number of cluster is on he elbow of the curve.

![elbow](image/elbow.png)

We decide that there is a sharp elbow of the curve is on number 3. Thus, we set the number of clusters into three time management qualities: 

 - Good Time Management Quality
 
 - Normal Time Management Quality
 
 - Bad Time Management Quality

After obtaining the number of clusters, we begin to cluster the data, and this is the result that we get,

![clust_ori](image/clust_ori.png)

From the graph, if you look at the group of **Good Time Management Quality**, it has a higher scores (above 40), and it seems that the higher the scores, the better the time management quality.

But that is not the case, we were clustering or grouping the data not only depending on the scores but also the answer to each question for the grouping. That will explain how some data with lower scores get the **Good Time Management Quality** and some data with higher scores get **Bad Time Management Quality** or **Normal Time Management Quality**.

We determine the name of the group based on the boxplot of scores according to the group cluster to determine the group name

![clust_ori](image/clust_box.png)

We manually name it from the boxplot above from higher score to lower score as:
* Group number 2 (has the highest scores) as a group of **'Good Time Management Quality'**. 
* group number 3 (has score between grou 1 and 3) as a group of **'Normal Time Management Quality.'**
* Group number 1 (has the lowest scores) as a group of **'Bad Time Management Quality'**.

<a name="Arules"></a>
## Association Rules 

You must wonder why we use the association rules method into the data. Are there any transactions in this data? doesn't its goal is determining what is the next product that the customer will buy if they already buy one specific item? **Yes, that is true!** We will use that association rules algorithm differently. In this project, association rules determine what aspect leads to a **'Good Time Management Quality'** or **'Bad Time Management Quality.'** If you think it confusing to decide on the transaction data in this dataset, I will tell you it is not, **absolutely not.** We use the row as the transaction or one respondent as one transaction and the twelve questions, gender, and age as the items.

#### Bad Time Management Quality
![bad_arules](image/bad_arules.png)

If you try the survey and fill the question shown above, you will produce a **Bad Time Management Quality**. And the plot below is the interactive visualization that you can try in the shiny app.

![bad_arules_vis](image/bad_arules_vis.png)

#### Good Time Management Quality
![good_arules](image/good_arules.png)

If you try the survey and fill the question shown above, you will produce Good Time Management Quality. And the plot below is the interactive visualization that you can try in the app!

![good_arules_vis](image/good_arules_vis.png)

I will not explain more about the association rules algorithms because it is beyond the scope of time management topic. If you want to understand how I use the association rules without transaction datasets, you can see here: [Rpubs by me](https://rpubs.com/geraldbryan_/690426). Overall, we use the association rules because we want to show you what action leads to bad or good time management quality. Then, you can eliminate any actions that will lead to bad time management quality and keep doing the activities that will lead to good time management quality.

<a name="App"></a>
## About Application

#### Landing Page
![landing](image/landing_page.png)

Here is the landing page of the **Time Management Indicator** app. What you can do in the home page?
* **About** menu (in the top right corner) : See the summary, purpose, and sources of this app. 
* **Messages** : Welcoming messages from us to welcome you. 
* **Statistics** : See what it shown in statistics menu.
* **Survey** : See what it shown in survey menu.

#### Survey
![survey](image/survey.png)

Fill your details in the main page's lift side and then click 'Start Test,' and then it will bring you to the survey part.

![question](image/question.png)

After finishing, fill out the twelve questions:

1. Click the OK button.

2. Remember to be honest when you fill it so that you can get your actual result.

3. Don't be hesitate to fill it, because we do not keep your data. After you close the app, the data will be gone.

4. Your result will be shown as a ' * ' shape. See the example below,

![result](image/result.png)

#### Recommendation
![recommendation](image/recommendation.png)

There are three parts to this menu:
* **Recommendation**
  In the recommendation part, we use the recommendation from the expert (you can see the detail from this [page](https://quickbooks.intuit.com/r/employee-management/time-   management-tips/#:~:text=If%20you%20want%20to%20improve%20your%20time%20management,compare%20actual%20time%20spent%20and%20estimated%20time%20spent.)) to make you have the better time manager. There are some example of recommendations or tips like 'create a daily task', 'prioritize your task', and 'avoid multitasking' that will improve your time management quality. 
* **Question List**
  The question list in this menu is to support the 'Factor that Impact your Time Management Quality' part. In this part we provide the question descriptions behind hte variable 'X1' through 'X12'.
  
* **Factor that Impact your Time Management Quality**.  
  In this part, we use the association rules model to encourage you what the answer will bring you to be in a 'Good Time Management Quality' or 'Bad Time Management Quality'. Besides that, it can be used as the recommendation too.
  
  This is how you read the result : In the 'LHS' column is what the action that will trigger you to get the result in 'RHS' column.  
  
  I will explain it step by step:
  1. See the 'LHS' part, in the first example it has 'X6 : Strong Disagree' and 'X8 : Agree',
  2. Go the the Question list and check what the question decsription between 'X6' and 'X8',
  3. See the 'RHS' part, we get the result of 'Good'. (It means that if we agree on 'X8' and Strong Disagree on 'X6', we will more likely to have a good time management quality)
  4. Implement it in real life! (It is a must :wink:)

#### Statistics
In this menu we divide it into two big menu which are [clustering](#Cluster) and [Association rules](#Arules). It consist all of what we have been explained in the clustering and Association rules part.

## Enjoy!
I do not want you to take more time to read this, so just head to the shiny app, take the survey, and most important, improve your time management quality no matter what groups you belong to based on our survey.


Lastly, I want to provide you with another quote that I like:

> **"The bad news is time flies. The good news is you are the pilot"** <br> -Michael Altshuler

Thank you for reading and use the app. If you have any feedback, feel free to contact me. Cheers to the better us! :)
