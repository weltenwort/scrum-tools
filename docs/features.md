# Potential Features

- a scrum master can...
    - [ ] create retrospectives
    - [ ] add activities to a retrospective, e.g.
        - timeline
        - mad/sad/glad
    - [ ] change the basic properties of an activity e.g.
        - name
        - layout
    - [ ] set the currently active activity
    - [ ] freeze/export the retrospective including all content afterwards
- a scrum team member can...
    - [ ] set a name
    - [ ] join a retrospective given an id (no login required)
    - [ ] view the currently active activity
    - [ ] interact with the currently active activity, e.g.
        - add items
        - vote on items

## User Identification

- When joining a retrospective for the first time, each user is given an id so
  she can re-join later. The id is stored in the browser and displayed to the user.
- When re-joining the retrospective, the app recovers the id from the local
  storage or asks the user to enter his id.
- For a given retrospective the creator is considered to be the scrum master.
- Anyone else joining the retrospective is considered to be a team member.

## Retrospectives

- A retrospective has a
    - creator (scrum master)
    - list of team members
    - name
    - creation date
    - list of activities

- An activity has a
    - type
    - name
    - list of currently active team members
