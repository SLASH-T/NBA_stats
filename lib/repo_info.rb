require 'http'
require 'yaml'

AUTH = YAML.safe_load(File.read('config/secrets.yml'))

stats_result = {
  'game' => { 'date' => nil },
  'Quaters' => {
    '1' => { 'awayScore' => nil },
    '2' => { 'awayScore' => nil },
    '3' => { 'awayScore' => nil },
    '4' => { 'awayScore' => nil }
  }
}
stats_response = {}

def nba_api_path(season = '2017-playoff', date = '20170416', team = 'GSW')
  'https://api.mysportsfeeds.com/v1.1/pull/nba/' + season\
   + '/scoreboard.json?fordate=' + date\
   + '&team=' + team
end

def call_stats_uri(authorize, uri)
  HTTP.headers('Authorization' => authorize).get(uri)
end

repo_uri = nba_api_path('2017-playoff', '20170416', 'GSW')
stats_response[repo_uri] = call_stats_uri(AUTH['MYSPORTS_AUTH'], repo_uri)
repo = stats_response[repo_uri].parse # turn to hash class

# Information about the current game
game = repo['scoreboard']['gameScore'][0]['game']
stats_result['game']['date'] = game['date']
stats_result['game']['location'] = game['location']
stats_result['game']['awayTeam'] = game['awayTeam']['City']\
 + ' ' + game['awayTeam']['Name']
stats_result['game']['homeTeam'] = game['homeTeam']['City']\
 + ' ' + game['homeTeam']['Name']

# Total Scores
stats_result['awayScore'] = repo['scoreboard']['gameScore'][0]['awayScore']
stats_result['homeScore'] = repo['scoreboard']['gameScore'][0]['homeScore']

# Quarter Summary
quarter = repo['scoreboard']['gameScore'][0]['quarterSummary']['quarter']
# 1st Quarter
stats_result['Quaters']['1']['awayScore'] = quarter[0]['awayScore']
stats_result['Quaters']['1']['homeScore'] = quarter[0]['homeScore']
# 2nd Quarter
stats_result['Quaters']['2']['awayScore'] = quarter[1]['awayScore']
stats_result['Quaters']['2']['homeScore'] = quarter[1]['homeScore']
# 3rd Quarter
stats_result['Quaters']['3']['awayScore'] = quarter[2]['awayScore']
stats_result['Quaters']['3']['homeScore'] = quarter[2]['homeScore']
# 4th Quarter
stats_result['Quaters']['4']['awayScore'] = quarter[3]['awayScore']
stats_result['Quaters']['4']['homeScore'] = quarter[3]['homeScore']

File.write('spec/fixtures/result.yml', stats_result.to_yaml)
