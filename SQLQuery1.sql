--What grades are stored in the database?
SELECT g.[Name]
FROM Grade g

--What emotions may be associated with a poem?
SELECT e.[Name]
FROM Emotion e

--How many poems are in the database?
SELECT COUNT(p.Id) AS NumberOfPoems
FROM Poem p

--Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 [Name]
FROM Author
ORDER BY [Name] 

--Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 a.[Name] AS AuthorName, g.[Name] AS GradeName
FROM Author a
LEFT JOIN Grade g ON g.Id=a.GradeId
ORDER BY a.[Name]

--Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 a.[Name] AS Author, g.[Name] AS Grade, gen.[Name] AS Gender
FROM Author a
LEFT JOIN Grade g ON g.Id=a.GradeId
LEFT JOIN Gender gen ON gen.Id=GenderId
ORDER BY a.[Name]

--What is the total number of words in all poems in the database?
SELECT SUM(WordCount) AS SumOfAllWords
FROM Poem

--Which poem has the fewest characters?
SELECT TOP 1 Title, CharCount 
FROM Poem
ORDER BY CharCount 

--Which poem has the fewest characters?
SELECT TOP 76 a.[Name] AS AuthorName, g.[Name] AS GradeName
FROM Author a
LEFT JOIN Grade g ON g.Id=a.GradeId
WHERE g.[Name]='3rd Grade' 
ORDER BY a.[Name]

--How many total authors are in the first through third grades?
SELECT TOP 76 a.[Name] AS AuthorName, g.[Name] AS GradeName
FROM Author a
LEFT JOIN Grade g ON g.Id=a.GradeId
WHERE g.[Name]='3rd Grade' OR g.[Name]='2nd Grade' OR g.[Name]='1st Grade'
ORDER BY a.[Name]

--What is the total number of poems written by fourth graders?
SELECT SUM(p.Id) AS TotalNumPoems,  g.[Name] AS Grade
FROM Poem p
LEFT JOIN Author a ON a.Id=p.AuthorId
LEFT JOIN Grade g ON g.Id=a.GradeId
WHERE g.[Name]='4th Grade'
GROUP BY g.[Name]

--How many poems are there per grade?
SELECT SUM(p.Id) AS TotalNumPoems,  g.[Name] AS Grade
FROM Poem p
LEFT JOIN Author a ON a.Id=p.AuthorId
LEFT JOIN Grade g ON g.Id=a.GradeId
GROUP BY g.[Name] 
ORDER BY g.[Name]

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT  g.[Name] AS Grade, SUM(p.Id) AS TotalNumPoems, SUM(a.Id) AS TotalNumAuthors
FROM Poem p
LEFT JOIN Author a ON a.Id=p.AuthorId
LEFT JOIN Grade g ON g.Id=a.GradeId
GROUP BY g.[Name] 
ORDER BY g.[Name]

--What is the title of the poem that has the most words?
SELECT TOP 1 Title AS LongestPoemTitle, WordCount AS WordCount
FROM Poem
ORDER BY WordCount DESC


--Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT DISTINCT TOP 5 a.Name, MAX(p.Id) AS PoemCount
FROM Author a
LEFT JOIN Poem p ON a.Id=p.AuthorId
GROUP BY a.Name
ORDER BY PoemCount DESC

--How many poems have an emotion of sadness?
SELECT Count(p.Id) AS NumSadPoems
FROM Poem p
LEFT JOIN PoemEmotion pE ON p.Id=pE.PoemId
LEFT JOIN Emotion e ON pE.EmotionId=e.Id
WHERE e.Name='Sadness'
--or: WHERE e.Id=3;

--How many poems are not associated with any emotion? MEANS:PoemEmotion's Emotion ID is NULL*******************
SELECT Count(p.Id) AS NumNoEmotionPoems
FROM Poem p
LEFT JOIN PoemEmotion pE ON p.Id=pE.PoemId
WHERE pE.EmotionId IS NULL; --PoemEmotion.EmotionId is not nullable but EmotionId is NULL
--or:WHERE pe.PoemId IS NULL; ---for cases where PoemEmotion.PoemId is nullable


--Which emotion is associated with the least number of poems?
SELECT TOP 1 e.Name, COUNT(pE.EmotionId) AS EmotionCount
FROM Emotion e
LEFT JOIN PoemEmotion pE ON e.Id=pE.EmotionId
GROUP BY e.Name
ORDER BY EmotionCount


--Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1  e.Name AS Emotion, COUNT(pE.EmotionId) AS EmotionCount, g.Name
FROM Grade g
LEFT JOIN Author a ON a.GradeId=g.Id
LEFT JOIN Poem p ON p.AuthorId=a.Id
LEFT JOIN PoemEmotion pE ON pE.PoemId=p.Id
LEFT JOIN  Emotion e ON e.Id=pE.EmotionId
GROUP BY g.Name, e.Name HAVING e.Name='joy'
ORDER BY EmotionCount DESC

--Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1  e.Name AS Emotion, COUNT(pE.EmotionId) AS EmotionCount, g.Name
FROM Gender g
LEFT JOIN Author a ON a.GenderId=g.Id
LEFT JOIN Poem p ON p.AuthorId=a.Id
LEFT JOIN PoemEmotion pE ON pE.PoemId=p.Id
LEFT JOIN  Emotion e ON e.Id=pE.EmotionId
GROUP BY g.Name, e.Name HAVING e.Name='fear'
ORDER BY EmotionCount 

