Feature: control one openflow switch using learning switch (Ruby)

  As a Trema user
  I want to control one openflow switch using learning-switch.rb
  So that I can send and receive packets


  Scenario: Send and receive packets
    Given I try trema run "./src/examples/learning_switch/learning-switch.rb" with following configuration (backgrounded):
      """
      vswitch("learning") { datapath_id "0xabc" }

      vhost("host1")
      vhost("host2")

      link "learning", "host1"
      link "learning", "host2"
      """
      And wait until "LearningSwitch" is up
    When I send 1 packet from host1 to host2
      And I try to run "./trema show_stats host1 --tx" (log = "host1.LearningSwitch.log")
      And I try to run "./trema show_stats host2 --rx" (log = "host2.LearningSwitch.log")
    Then the content of "host1.LearningSwitch.log" and "host2.LearningSwitch.log" should be identical