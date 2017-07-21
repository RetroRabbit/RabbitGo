//
//  Global.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Firebase
import FirebaseStorage

var RABBITEERS = "rabbiteers"
var QUESTIONS = "questions"
var SCORE = "score"
var UNIVERSITIES = "universities"
var DEGREES = "degrees"
var RABBITS = "rabbits"
var RABBIT_BOARD = "rabbit_board"
var RABBIT_TEAM_BOARD = "rabbit_team_board"
var PROFILE_PICS = "profile_pics"

var auth = Auth.auth()
var ref = Database.database().reference()
var refRabbiteers = ref.child(RABBITEERS)
var refQuestions = ref.child(QUESTIONS)
var refUniversities = ref.child(UNIVERSITIES)
var refDegrees = ref.child(DEGREES)
var refRabbits = ref.child(RABBITS)
var refRabbitTeamBoard = ref.child(RABBIT_TEAM_BOARD)
var refRabbitBoard = ref.child(RABBIT_BOARD)
func currentUserId() -> String { return auth.currentUser!.uid }
func refCurrentUser() -> DatabaseReference { return refRabbiteers.child(currentUserId()) }
func refCurrentUserQuestions() -> DatabaseReference { return refCurrentUser().child(QUESTIONS) }
func refQuestion(questionId: String) -> DatabaseReference { return refQuestions.child(questionId) }
func refRabbitBoard(rabbitCode: String) -> DatabaseReference { return refRabbitBoard.child(rabbitCode) }
func refRabbitTeamBoard(team: String) -> DatabaseReference { return refRabbitTeamBoard.child(team) }
func isRabbit(user: User?) -> Bool { return user?.email?.contains("@retrorabbit.co.za") ?? false }

var storeRef = Storage.storage().reference()
var profilePicsRef = storeRef.child(PROFILE_PICS)
var currentUserProfilePic = profilePicsRef.child("${currentUserId()}.jpg")

class Player {
    var email: String? = nil
    var displayName: String? = nil
    //var questions: HashMap<String, PlayerQuestion>? = nil
    var score = 0
    var university = ""
    var degree = ""
    var year = 1900
    
    init(email: String?, displayName: String?) {
        self.email = email
        self.displayName = displayName
    }
}

class Rabbit {
    var email: String? = nil
    var displayName: String? = nil
    var code: String? = nil
    var team: String? = nil
}

class Question {
    var text: String? = nil
    var multiple: [String]? = nil
    var free: String? = nil
    var answer: Int? = nil
}

class PlayerQuestion {
    var state: Int? = nil
    var answer: String? = nil
    var rabbitCode: String? = nil
    
    
    init(state: Int?) {
        self.state = state
    }
    
    init(state: Int?, answer: String?, rabbitCode: String?) {
        self.state = state
        self.answer = answer
        self.rabbitCode = rabbitCode
    }
}

class AutoComplete {
    var name: String? = nil
    var nick: String? = nil
    
    func toString() -> String {
        return "\(name) \(nick)"
    }
}

enum QuestionState: Int {
    case locked = 0
    case unlocked = 1
    case done = 2
}
