Feature: Site connectivity
	In order to access the site
	As a web user
	I want to make sure the site is available

	Scenario Outline: Key URLs
		Given the site url "<url>"
		When requesting that url
		Then the HTTP response code should be "<code>"
	
	Examples:
		| url                    | code |
		| http://www.google.com  | 200  |
		| http://docs.google.com | 302  |
		| http://www.gmail.com   | 301  |
