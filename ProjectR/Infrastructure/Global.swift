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
var AutoCompleteS = "autocomplete"

var auth = Auth.auth()
var ref = Database.database().reference()
var refRabbiteers = ref.child(RABBITEERS)
var refQuestions = ref.child(QUESTIONS)
var refUniversities = ref.child(UNIVERSITIES)
var refDegrees = ref.child(DEGREES)
var refRabbits = ref.child(RABBITS)
var refRabbitTeamBoard = ref.child(RABBIT_TEAM_BOARD)
var refRabbitBoard = ref.child(RABBIT_BOARD)
var refAutoComplete = ref.child(AutoCompleteS)
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
    var email: NSString? = nil
    var displayName: NSString? = nil
    //var questions: HashMap<String, PlayerQuestion>? = nil
    var score: NSNumber = 0
    var university: NSString = ""
    var degree: NSString = ""
    var year: NSString = ""
    
    init(email: String?, displayName: String?) {
        if let _email = email as NSString? { self.email = _email }
        if let _displayName = displayName as NSString? { self.displayName = _displayName }
    }
    
    init(email: String?, displayName: String?, university: String?, degree: String?, year: String?) {
        if let _email = email as NSString? { self.email = _email }
        if let _displayName = displayName as NSString? { self.displayName = _displayName }
        if let _university = university as NSString? { self.university = _university }
        if let _degree = degree as NSString? { self.degree = _degree }
        if let _year = year as NSString? { self.year = _year }
    }
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _email = email {
            value["email"] = _email
        }
        
        if let _displayName = displayName {
            value["displayName"] = _displayName
        }
        
        value["score"] = score
        value["university"] = university
        value["degree"] = degree
        value["year"] = year
        
        return value
    }
}

class Rabbit {
    var email: NSString? = nil
    var displayName: NSString? = nil
    var code: NSString? = nil
    var team: NSString? = nil
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _email = email { value["email"] = _email }
        if let _displayName = displayName { value["displayName"] = _displayName }
        if let _code = code { value["code"] = _code }
        if let _team = team { value["team"] = _team }
        
        return value
    }
}

class Question {
    var text: NSString? = nil
    var multiple: [NSString]? = nil
    var free: NSString? = nil
    var answer: NSNumber? = nil
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _text = text { value["text"] = _text }
        if let _free = free { value["free"] = _free }
        if let _answer = answer { value["answer"] = _answer }
        if let _multiple = multiple { value["multiple"] = _multiple }
    
        return value
    }
}

class PlayerQuestion {
    var state: NSNumber? = nil
    var answer: NSString? = nil
    var rabbitCode: NSString? = nil
    
    
    init(state: NSNumber?) {
        if let _state = state as NSNumber? {
            self.state = _state
        }
    }
    
    init(state: NSNumber?, answer: String?, rabbitCode: String?) {
        self.state = state
        
        if let _answer = answer as NSString? {
            self.answer = _answer
        }
        
        if let _rabbitCode = rabbitCode as NSString? {
            self.rabbitCode = _rabbitCode
        }
    }
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _state = state { value["state"] = _state }
        if let _answer = answer { value["answer"] = _answer }
        if let _rabbitCode = rabbitCode { value["rabbitCode"] = _rabbitCode }
        
        return value
    }
}

class AutoComplete {
    var name: String? = nil
    var nick: String? = nil
    
    init(name: String, nick: String) {
        self.name = name
        self.nick = nick
    }
    
    func toString() -> String {
        return "\(name) \(nick)"
    }
}

enum QuestionState: NSNumber {
    case locked = 0
    case unlocked = 1
    case done = 2
}
