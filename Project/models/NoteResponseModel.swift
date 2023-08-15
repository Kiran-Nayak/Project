//
//  NoteResponseModel.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation

struct NoteResponseModel: Codable {
    let invites: InvitesModel?
    let likes: LikesModel?
}

struct InvitesModel: Codable {
    let profiles: [
        ProfilesModel?
    ]?
    let totalPages: Int?
    let pending_invitations_count: Int?
}

struct ProfilesModel: Codable {
    let general_information: GeneralInformationModel?
    let approved_time: Double?
    let disapproved_time: Double?
    let photos: [
        PhotosModel?
    ]?
    let work: WorkModel?
    let preferences: [
        PreferenceModel?
    ]?
    let last_seen_window: String?
    let is_facebook_data_fetched: Bool?
    let verification_status: String?
    let has_active_subscription: Bool?
    let show_concierge_badge: Bool?
    let lat: Double?
    let lng: Double?
    let online_code: Int?
    let profile_data_list: [
        ProfileDataListModel?
    ]?
}

struct GeneralInformationModel: Codable {
    let date_of_birth: String?
    let date_of_birth_v1: String?
    let location: LocationModel?
    let drinking_v1: DrinkingModel
    let first_name: String?
    let gender: String?
    let marital_status_v1: MaritalStatusModel?
    let ref_id: String?
    let smoking_v1: CommonModel?
    let sun_sign_v1: CommonModel?
    let mother_tongue: CommonModel?
    let faith: CommonModel?
    let height: Int?
    let age: Int?
}

struct LocationModel: Codable {
    let summary: String?
    let full: String?
}

struct LikesModel: Codable {
    let profiles: [
        LikeProfileModel?
    ]
    let can_see_profile: Bool?
    let likes_received_count: Int?
}

struct LikeProfileModel: Codable {
    let first_name: String?
    let avatar: String?
}

struct PhotosModel: Codable {
    let photo: String?
    let photo_id: Int?
    let selected: Bool?
    let status: String?
}

struct WorkModel: Codable {
    let industry_v1: IndustryModel?
    let experience_v1: ExperienceModel?
    let highest_qualification_v1: HightestQualificationModel?
    let field_of_study_v1: FieldOfStudyArea?
}

struct IndustryModel: Codable {
    let id: Int?
    let name: String?
    let preference_only: Bool?
}

struct FieldOfStudyArea: Codable {
    let id: Int?
    let name: String?
}

struct HightestQualificationModel: Codable {
    let id: Int?
    let name: String?
    let preference_only: Bool?
}

struct PreferenceModel: Codable {
    let answer_id: Int?
    let id: Int?
    let value: Int?
    let preference_question: PreferenceQuestionModel?
}

struct PreferenceQuestionModel: Codable {
    let first_choice: String?
    let second_choice: String?
}

struct ProfileDataListModel: Codable {
    let question: String?
    let preferences: [
        ProfilePreference?
    ]?
    let invitation_type: String?
}
struct ProfilePreference: Codable {
    let answer_id: Int?
    let answer: String?
    let first_choice: String?
    let second_choice: String?
}

struct DrinkingModel: Codable {
    let id: Int?
    let name: String?
    let name_alias: String?
}

struct MaritalStatusModel: Codable {
    let id: Int?
    let name: String?
    let preference_only: Bool?
}

struct ExperienceModel: Codable {
    let id: Int
    let name: String?
    let name_alias: String?
}

struct CommonModel: Codable {
    let id: Int?
    let name: String?
    let name_alias: String?
}
