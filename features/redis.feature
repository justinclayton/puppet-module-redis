Feature: Redis
  In order to use caching in my application
  As a developer
  I want a redis server created and configured

Scenario Outline: Provision redis server
  Given a <os_name> machine
  When I apply the redis module
  Then I should be able to connect to the redis server
  And I should be able to store data in redis
  And I should be able to retrieve data from redis
    Examples:
      | os_name  |
      | centos6  |
      | ubuntu12 |