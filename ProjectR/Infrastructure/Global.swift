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
var RABBIT_PROFILE_PICS = "rabbit_profile_pics"
var RABBIT_CELEBRITIES = "celebrities"
var FIRST_PLACE: Int64 = 10000
var SECOND_PLACE: Int64 = 9999
var THIRD_PLACE: Int64 = 9998

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
var refRabbitCelebrities = ref.child(RABBIT_CELEBRITIES)

var firebaseRabbits: [Rabbit] = []
var firebaseQuestions: [Question] = []
var firebaseCelebrities: [Celebrity] = []

func currentUserId() -> String { return auth.currentUser!.uid }
func currentUserEmail() -> String { return auth.currentUser!.email ?? ""}
func refCurrentUser() -> DatabaseReference { return refRabbiteers.child(currentUserId()) }
func refCurrentRabbit() -> DatabaseQuery { return refRabbits.queryOrdered(byChild: "email").queryEqual(toValue: currentUserEmail()) }
func refCurrentUserQuestions() -> DatabaseReference { return refCurrentUser().child(QUESTIONS) }
func refCurrentUserQuestion(qrCode: String) -> DatabaseReference { return refCurrentUserQuestions().child(qrCode) }
func refQuestion(questionId: String) -> DatabaseReference { return refQuestions.child(questionId) }
func refRabbitBoard(rabbitCode: String) -> DatabaseReference { return refRabbitBoard.child(rabbitCode) }
func refRabbitTeamBoard(team: String) -> DatabaseReference { return refRabbitTeamBoard.child(team) }
func refRabbitCelebrities(rabbitCode: String) -> DatabaseReference { return refRabbitCelebrities.child(rabbitCode) }
func isRabbit(user: User?) -> Bool { return user?.email?.contains("@retrorabbit.co.za") ?? false }

var storeRef = Storage.storage().reference()
var profilePicsRef = storeRef.child(PROFILE_PICS)
var currentUserProfilePic = profilePicsRef.child("\(currentUserId()).jpg")

var rabbitProfilePicsRef = storeRef.child(RABBIT_PROFILE_PICS)
func rabbitProfilePic(rabbitCode: String) -> StorageReference { return rabbitProfilePicsRef.child("\(rabbitCode).png") }
var profileImage: UIImage?

class Player {
    var email: String? = nil
    var displayName: String? = nil
    //var questions: HashMap<String, PlayerQuestion>? = nil
    var score: Int64 = 0
    var university: String = ""
    var degree: String = ""
    var year: String = ""
    var individualRanking: Int64 = 0
    //yyyy-MM-dd'T'HH:mm:ss'Z'`
    var win: String = ""
    
    init() {
        
    }
    
    init(email: String?, displayName: String?) {
        self.email = email
        self.displayName = displayName
    }
    
    init(email: String?, displayName: String?, university: String?, degree: String?, year: String?, score: Int64) {
        self.email = email
        self.displayName = displayName
        self.university = university ?? ""
        self.degree = degree ?? ""
        self.year = year ?? ""
        self.score = score
    }
    
    init(email: String?, displayName: String?, university: String?, degree: String?, year: String?) {
        self.email = email
        self.displayName = displayName
        self.university = university ?? ""
        self.degree = degree ?? ""
        self.year = year ?? ""
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
        value["win"] = win
        
        return value
    }
    
    static func decode(snapshot: DataSnapshot) -> Player {
        let player = Player()
        player.email = snapshot.childSnapshot(forPath: "email").value as? String ?? ""
        player.displayName = snapshot.childSnapshot(forPath: "displayName").value as? String ?? ""
        player.score = snapshot.childSnapshot(forPath: "score").value as? Int64 ?? 0
        player.university = snapshot.childSnapshot(forPath: "university").value as? String ?? ""
        player.degree = snapshot.childSnapshot(forPath: "degree").value as? String ?? ""
        player.year = snapshot.childSnapshot(forPath: "year").value as? String ?? ""
        player.win = snapshot.childSnapshot(forPath: "win").value as? String ?? ""
        return player
    }
}

class Rabbit {
    var email: String? = nil
    var displayName: String? = nil
    var code: String? = nil
    var team: String? = nil
    var questionsAnswered: Int64 = 0
    var individualRanking: Int64 = 0
    var teamRanking: Int64 = 0
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _email = email { value["email"] = _email }
        if let _displayName = displayName { value["displayName"] = _displayName }
        if let _code = code { value["code"] = _code }
        if let _team = team { value["team"] = _team }
        
        return value
    }
    
    static func decode(dataSnap: DataSnapshot) -> Rabbit {
        let rabbit = Rabbit()
        rabbit.email = dataSnap.childSnapshot(forPath: "email").value as? String ?? ""
        rabbit.displayName = dataSnap.childSnapshot(forPath: "displayName").value as? String ?? ""
        rabbit.code = dataSnap.childSnapshot(forPath: "code").value as? String ?? ""
        rabbit.team = dataSnap.childSnapshot(forPath: "team").value as? String ?? ""
        
        return rabbit
    }
}

class Celebrity {
    var code: String = ""
    var displayName: String? = nil
    var bio: String? = nil
    var Category: String? = nil
    var Abilities: String? = nil
    var Weaknesses: String? = nil
    
    static func decode(dataSnap: DataSnapshot) -> Celebrity {
        let celeb = Celebrity()
        celeb.code = dataSnap.key
        celeb.displayName = dataSnap.childSnapshot(forPath: "displayName").value as? String ?? ""
        celeb.bio = dataSnap.childSnapshot(forPath: "bio").value as? String ?? ""
        celeb.Category = dataSnap.childSnapshot(forPath: "Category").value as? String ?? ""
        celeb.Weaknesses = dataSnap.childSnapshot(forPath: "Weaknesses").value as? String ?? ""
        celeb.Abilities = dataSnap.childSnapshot(forPath: "Abilities").value as? String ?? ""
        return celeb
    }
}

class Question {
    var text: String? = nil
    var multiple: [String]? = nil
    var free: String? = nil
    var answer: Int64? = nil
    var qrCode: String? = nil
    var state: Int64 = 0    // 0 = Locked, 1 = unlocked, 2 = answered
    var unlocked: String? = nil
    
    func formatted() -> [String:Any] {
        var value: [String:Any] = [:]
        if let _text = text { value["text"] = _text }
        if let _free = free { value["free"] = _free }
        if let _answer = answer { value["answer"] = _answer }
        if let _multiple = multiple { value["multiple"] = _multiple }
        
        return value
    }
    
    static func decode(snapshot: DataSnapshot) -> Question {
        let question = Question()
        question.qrCode = snapshot.key
        question.text = snapshot.childSnapshot(forPath: "text").value as? String ?? ""
        question.free = snapshot.childSnapshot(forPath: "free").value as? String ?? ""
        question.answer = snapshot.childSnapshot(forPath: "answer").value as? Int64 ?? 0
        question.state = snapshot.childSnapshot(forPath: "state").value as? Int64 ?? 0
        question.unlocked = snapshot.childSnapshot(forPath: "unlocked").value as? String ?? ""
        
        question.multiple = [
            snapshot.childSnapshot(forPath: "multiple").childSnapshot(forPath: "0").value as? String ?? "",
            snapshot.childSnapshot(forPath: "multiple").childSnapshot(forPath: "1").value as? String ?? "",
            snapshot.childSnapshot(forPath: "multiple").childSnapshot(forPath: "2").value as? String ?? ""
        ]
        
        return question
    }
}

class PlayerQuestion {
    var state: Int? = nil
    var value: String? = nil
    var answer: String? = nil
    var rabbitCode: String? = nil
    var lockedCodes: [String] = []
    
    init() {
    }
    
    init(state: Int?) {
        if let _state = state as Int? {
            self.state = _state
        }
    }
    
    init(state: Int?, lockedCodes: [String]) {
        if let _state = state as Int? {
            self.state = _state
        }
        
        self.lockedCodes = lockedCodes
    }
    
    init(state: Int?, answer: String?, rabbitCode: String?) {
        self.state = state
        
        if let _answer = answer as String? {
            self.answer = _answer
        }
        
        if let _rabbitCode = rabbitCode as String? {
            self.rabbitCode = _rabbitCode
        }
    }
    
    func formatted() -> [String:Any] {
        var formattedValue: [String:Any] = [:]
        
        if let _state = state { formattedValue["state"] = _state }
        if let _value = value { formattedValue["value"] = _value }
        if let _answer = answer { formattedValue["answer"] = _answer }
        if let _rabbitCode = rabbitCode { formattedValue["rabbitCode"] = _rabbitCode }
        if lockedCodes.count > 0 { formattedValue["lockedCodes"] = lockedCodes.joined(separator: ",") }
        return formattedValue
    }
    
    static func decode(snapshot: DataSnapshot) -> PlayerQuestion {
        let playerQuestion = PlayerQuestion()
        playerQuestion.state = snapshot.childSnapshot(forPath: "state").value as? Int ?? 0
        if let val = snapshot.childSnapshot(forPath: "value").value as? String { playerQuestion.value = val }
        if let ans = snapshot.childSnapshot(forPath: "answer").value as? String { playerQuestion.answer = ans }
        if let rabCode = snapshot.childSnapshot(forPath: "rabbitCode").value as? String { playerQuestion.rabbitCode = rabCode }
        if let SlockedCodes = snapshot.childSnapshot(forPath: "lockedCodes").value as? String { playerQuestion.lockedCodes = SlockedCodes.components(separatedBy: ",") }
        return playerQuestion
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

enum QuestionState: Int {
    case locked = 0
    case unlocked = 1
    case done = 2
}
