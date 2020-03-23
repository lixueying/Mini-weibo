struct Moment {
    let created_at : String
    let id : Int
    let text : String
    let reposts_count : Int
    let comments_count : Int
    let attitudes_count : Int
    let user : [User]
    let pic_num : Int
    let pic_infos : Object
}

struct User {
    let id : Int
    let screen_name : String
    let name : String
    let profile_image_url : String
}
