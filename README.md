# NBA_stats
Web API for the NBA_stats application

[ ![Codeship Status for SLASH-T/NBA_stats](https://app.codeship.com/projects/13655d70-ac28-0135-872f-52818934e923/status?branch=master)](https://app.codeship.com/projects/256904)

#### use api to get score of the game

### lib
- NBA_result.rb: use to record correct answer in yaml
- game_info.rb: record date location team data and call Scores class to save score
- scores.rb: record score by quarter
- msf_api.rb: use api to get data

### spec
- nba_stats_spec.rb: test data, use VCR and test coverage
- spec_helper.rb: save canstant and relative model

### Arcitecture
