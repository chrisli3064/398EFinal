install.packages("RMySQL")
install.packages("tidyverse")
library(RMySQL)
library(tidyverse)

##################################################################################################################################
#                                         Setting a MySQLWorkbench Connection Password
##################################################################################################################################

# Select a connection
# Go to "administration" on the top of the left side panel
# Under administration, select "users and privileges"
# Select root as user and set password
# Close connection
# Enter password and use connection as usual


##################################################################################################################################
#                                                   Connecting MYSQL to R
##################################################################################################################################

# For MySQLWorkbench dbname will be the name of your schema NOT your database connection
# DO NOT CHANGE host, port, or user unless you intentionally changed those variables when creating your db
# If you set a password input your password, otherwise leave delete the parameter
mysqlconnection = dbConnect(RMySQL::MySQL(),
                            dbname='final',
                            host='127.0.0.1',
                            port=3306,
                            user='root',
                            password='awesomedude')
# mysqlconnection = dbConnect(RMySQL::MySQL(),
#                            dbname='final',
#                           host='localhost',
#                            port=3306,
#                            user='root',
#                            password='Cmsc389ePassword_!')
# Shows all tables in schema
dbListTables(mysqlconnection)
# Allows you to pull a query using the sql connection
# If you use double quotes in your query, convert them to single quotes to prevent errors
query = "


-- CTE to combine data from champions and runner-ups csvs
WITH CleanedData AS (
    SELECT
        COALESCE(c.Year, r.Year) AS Year,
        c.Team AS ChampionTeam,
        r.Team AS RunnerupTeam,
        -- Columns for Champion Data
        COALESCE(c.Game, r.Game) AS Game,
        COALESCE(c.Win, 0) AS ChampionWin,
        COALESCE(c.Home, 0) AS ChampionHome,
        COALESCE(c.MP, 0) AS ChampionMP,
        COALESCE(c.FG, 0) AS ChampionFG,
        COALESCE(c.FGA, 0) AS ChampionFGA,
        COALESCE(c.FGP, 0) AS ChampionFGP,
        COALESCE(c.TP, 0) AS ChampionTP,
        COALESCE(c.TPA, 0) AS ChampionTPA,
        COALESCE(c.TPP, 0) AS ChampionTPP,
        COALESCE(c.FT, 0) AS ChampionFT,
        COALESCE(c.FTA, 0) AS ChampionFTA,
        COALESCE(c.FTP, 0) AS ChampionFTP,
        COALESCE(c.ORB, 0) AS ChampionORB,
        COALESCE(c.DRB, 0) AS ChampionDRB,
        COALESCE(c.TRB, 0) AS ChampionTRB,
        COALESCE(c.AST, 0) AS ChampionAST,
        COALESCE(c.STL, 0) AS ChampionSTL,
        COALESCE(c.BLK, 0) AS ChampionBLK,
        COALESCE(c.TOV, 0) AS ChampionTOV,
        COALESCE(c.PF, 0) AS ChampionPF,
        COALESCE(c.PTS, 0) AS ChampionPTS,
        -- columns for Runner up statistics
        COALESCE(r.Win, 0) AS RunnerupWin,
        COALESCE(r.Home, 0) AS RunnerupHome,
        COALESCE(r.MP, 0) AS RunnerupMP,
        COALESCE(r.FG, 0) AS RunnerupFG,
        COALESCE(r.FGA, 0) AS RunnerupFGA,
        COALESCE(r.FGP, 0) AS RunnerupFGP,
        COALESCE(r.TP, 0) AS RunnerupTP,
        COALESCE(r.TPA, 0) AS RunnerupTPA,
        COALESCE(r.TPP, 0) AS RunnerupTPP,
        COALESCE(r.FT, 0) AS RunnerupFT,
        COALESCE(r.FTA, 0) AS RunnerupFTA,
        COALESCE(r.FTP, 0) AS RunnerupFTP,
        COALESCE(r.ORB, 0) AS RunnerupORB,
        COALESCE(r.DRB, 0) AS RunnerupDRB,
        COALESCE(r.TRB, 0) AS RunnerupTRB,
        COALESCE(r.AST, 0) AS RunnerupAST,
        COALESCE(r.STL, 0) AS RunnerupSTL,
        COALESCE(r.BLK, 0) AS RunnerupBLK,
        COALESCE(r.TOV, 0) AS RunnerupTOV,
        COALESCE(r.PF, 0) AS RunnerupPF,
        COALESCE(r.PTS, 0) AS RunnerupPTS
    FROM
        champions c
    LEFT JOIN
        runnerups r ON c.Year = r.Year AND c.Game = r.Game

    UNION

    SELECT
        COALESCE(c.Year, r.Year) AS Year,
        c.Team AS ChampionTeam,
        r.Team AS RunnerupTeam,
        COALESCE(c.Game, r.Game) AS Game,
        COALESCE(c.Win, 0) AS ChampionWin,
        COALESCE(c.Home, 0) AS ChampionHome,
        COALESCE(c.MP, 0) AS ChampionMP,
        COALESCE(c.FG, 0) AS ChampionFG,
        COALESCE(c.FGA, 0) AS ChampionFGA,
        COALESCE(c.FGP, 0) AS ChampionFGP,
        COALESCE(c.TP, 0) AS ChampionTP,
        COALESCE(c.TPA, 0) AS ChampionTPA,
        COALESCE(c.TPP, 0) AS ChampionTPP,
        COALESCE(c.FT, 0) AS ChampionFT,
        COALESCE(c.FTA, 0) AS ChampionFTA,
        COALESCE(c.FTP, 0) AS ChampionFTP,
        COALESCE(c.ORB, 0) AS ChampionORB,
        COALESCE(c.DRB, 0) AS ChampionDRB,
        COALESCE(c.TRB, 0) AS ChampionTRB,
        COALESCE(c.AST, 0) AS ChampionAST,
        COALESCE(c.STL, 0) AS ChampionSTL,
        COALESCE(c.BLK, 0) AS ChampionBLK,
        COALESCE(c.TOV, 0) AS ChampionTOV,
        COALESCE(c.PF, 0) AS ChampionPF,
        COALESCE(c.PTS, 0) AS ChampionPTS,
        COALESCE(r.Win, 0) AS RunnerupWin,
        COALESCE(r.Home, 0) AS RunnerupHome,
        COALESCE(r.MP, 0) AS RunnerupMP,
        COALESCE(r.FG, 0) AS RunnerupFG,
        COALESCE(r.FGA, 0) AS RunnerupFGA,
        COALESCE(r.FGP, 0) AS RunnerupFGP,
        COALESCE(r.TP, 0) AS RunnerupTP,
        COALESCE(r.TPA, 0) AS RunnerupTPA,
        COALESCE(r.TPP, 0) AS RunnerupTPP,
        COALESCE(r.FT, 0) AS RunnerupFT,
        COALESCE(r.FTA, 0) AS RunnerupFTA,
        COALESCE(r.FTP, 0) AS RunnerupFTP,
        COALESCE(r.ORB, 0) AS RunnerupORB,
        COALESCE(r.DRB, 0) AS RunnerupDRB,
        COALESCE(r.TRB, 0) AS RunnerupTRB,
        COALESCE(r.AST, 0) AS RunnerupAST,
        COALESCE(r.STL, 0) AS RunnerupSTL,
        COALESCE(r.BLK, 0) AS RunnerupBLK,
        COALESCE(r.TOV, 0) AS RunnerupTOV,
        COALESCE(r.PF, 0) AS RunnerupPF,
        COALESCE(r.PTS, 0) AS RunnerupPTS
    FROM
        champions c
    RIGHT JOIN
        runnerups r ON c.Year = r.Year AND c.Game = r.Game
)
-- CTE to aggreatgate series statistics
, SeriesAggregated AS (
    SELECT
        Year,
        ChampionTeam,
        RunnerupTeam,
        AVG(CASE WHEN ChampionTeam IS NOT NULL THEN ChampionTOV ELSE 0 END) AS TotalChampionTOV,
        AVG(CASE WHEN RunnerupTeam IS NOT NULL THEN RunnerupTOV ELSE 0 END) AS TotalRunnerupTOV,
        SUM(CASE WHEN ChampionTeam is NOT NULL THEN ChampionFG ELSE 0 END) AS TotalChampionFGM,
        SUM(CASE WHEN RunnerupTeam is NOT NULL THEN RunnerupFG ELSE 0 END) AS TotalRunnerupFGM,
        AVG(CASE WHEN ChampionTeam is NOT NULL THEN ChampionORB + ChampionDRB ELSE 0 END) AS AVGChampionREB,
        AVG(CASE WHEN RunnerupTeam is NOT NULL THEN RunnerupORB + RunnerupDRB ELSE 0 END) AS AVGRunnerupREB,
        SUM(CASE WHEN ChampionTeam IS NOT NULL THEN ChampionFT ELSE 0 END) AS AVGChampionFTP,
        SUM(CASE WHEN RunnerupTeam IS NOT NULL THEN RunnerupFT ELSE 0 END) AS AVGRunnerupFTP
    FROM
        CleanedData
    GROUP BY
        Year,
        ChampionTeam,
        RunnerupTeam
)
-- final select statement to retrieve aggregated series statistics
SELECT
    Year,
    ChampionTeam,
    RunnerupTeam,
    TotalChampionTOV,
    TotalRunnerupTOV,
    ROUND(TotalChampionTOV - TotalRunnerupTOV, 3) as TOVDifference,
    TotalChampionFGM,
    TotalRunnerupFGM,
    TotalChampionFGM - TotalRunnerupFGM as FGMDifference,
    ROUND(AVGChampionREB - AVGRunnerupREB, 3) as REBDifference,
    AVGChampionFTP - AVGRunnerupFTP as FTMDifference
FROM
    SeriesAggregated;


"

result = dbSendQuery(mysqlconnection, query) 
# Stores resulting table as dataframe
df = fetch(result)
print(df)

print(ggplot(df, aes(x = df$Year, y = df$TOVDifference)) +
        geom_point() +
        labs(title = "Average Turnover Difference between Champions and Runner-Ups from each year",
             x = "Year",
             y = "Turnover Difference"))
summary(lm(df$TOVDifference ~ df$Year, data = df))

print(ggplot(df, aes(x = df$Year, y = df$FGMDifference)) +
        geom_point() +
        labs(title = "Field Goals Made Difference between Champions and Runner-Ups from each year",
             x = "Year",
             y = "Field Goal Made Difference"))
summary(lm(df$FGMDifference ~ df$Year, data = df))

print(ggplot(df, aes(x = df$Year, y = df$REBDifference)) +
        geom_point() +
        labs(title = "Average Rebounding Difference between Champions and Runner-Ups from each year",
             x = "Year",
             y = "Rebounding Difference"))
summary(lm(df$REBDifference ~ df$Year, data = df))

print(ggplot(df, aes(x = df$Year, y = df$FTMDifference)) +
        geom_point() +
        labs(title = "Free Throw Difference between Champions and Runner-Ups from each year",
             x = "Year",
             y = "Free Throw Difference"))
summary(lm(df$FTMDifference ~ df$Year, data = df))
