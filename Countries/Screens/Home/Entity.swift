//
//  Entity.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation

typealias Countries = [Country]

// MARK: - Country
struct Country: Codable {
    let name: Name?
    let tld: [String]?
    let cca2, ccn3, cca3: String?
    let independent: Bool?
    let status: Status?
    let unMember: Bool?
    let currencies: Currencies?
    let idd: Idd?
    let capital, altSpellings: [String]?
    let region: Region?
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let car: Car?
    let timezones: [String]?
    let continents: [Continent]?
    let flags: Flags?
    let coatOfArms: CoatOfArms?
    let startOfWeek: StartOfWeek?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
    let borders: [String]?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side?
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let usd, ngn, dzd, mad: Aed?
    let mru, twd, crc, xof: Aed?
    let hnl, aud, eur, uzs: Aed?
    let bob, mnt, sgd, scr: Aed?
    let nok, htg, pgk, mzn: Aed?
    let pkr, ugx, bwp, xcd: Aed?
    let sar, gbp, gtq, aoa: Aed?
    let byn, isk, ils, omr: Aed?
    let ckd, nzd, mkd, cdf: Aed?
    let lbp, lrd, kid, szl: Aed?
    let zar, btn, inr, idr: Aed?
    let egp, jod, kpw, iqd: Aed?
    let thb, zwl, wst, ttd: Aed?
    let dop, tzs, bgn, etb: Aed?
    let ron, mga, vuv, xaf: Aed?
    let ang, currenciesTRY, xpf, yer: Aed?
    let npr, dkk, fok, php: Aed?
    let irr, mvr, cuc, cup: Aed?
    let lyd, mxn, tmt, mmk: Aed?
    let chf, rub: Aed?
    let bam: BAM?
    let kwd, imp, kgs, lsl: Aed?
    let rwf, sll, ghs, kyd: Aed?
    let tnd, tjs, clp, srd: Aed?
    let ars: Aed?
    let sdg: BAM?
    let azn, uah, fkp, bzd: Aed?
    let lak, pen, amd, jpy: Aed?
    let afn, qar, bdt, bmd: Aed?
    let cad, bsd, vnd, mop: Aed?
    let sbd, zmw, ern, khr: Aed?
    let brl, ssp, kzt, pyg: Aed?
    let mur, pln, mdl, cny: Aed?
    let fjd, stn, shp, gyd: Aed?
    let bbd, sek, bhd, sos: Aed?
    let top, hkd, bnd, all: Aed?
    let mwk, awg, kes, tvd: Aed?
    let ves, gip, bif, myr: Aed?
    let gmd, gnf, jmd, aed: Aed?
    let jep, ggp, cve, syp: Aed?
    let djf, rsd, nad, kmf: Aed?
    let pab, gel, huf, czk: Aed?
    let krw, uyu, cop, lkr: Aed?
    let nio: Aed?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case ngn = "NGN"
        case dzd = "DZD"
        case mad = "MAD"
        case mru = "MRU"
        case twd = "TWD"
        case crc = "CRC"
        case xof = "XOF"
        case hnl = "HNL"
        case aud = "AUD"
        case eur = "EUR"
        case uzs = "UZS"
        case bob = "BOB"
        case mnt = "MNT"
        case sgd = "SGD"
        case scr = "SCR"
        case nok = "NOK"
        case htg = "HTG"
        case pgk = "PGK"
        case mzn = "MZN"
        case pkr = "PKR"
        case ugx = "UGX"
        case bwp = "BWP"
        case xcd = "XCD"
        case sar = "SAR"
        case gbp = "GBP"
        case gtq = "GTQ"
        case aoa = "AOA"
        case byn = "BYN"
        case isk = "ISK"
        case ils = "ILS"
        case omr = "OMR"
        case ckd = "CKD"
        case nzd = "NZD"
        case mkd = "MKD"
        case cdf = "CDF"
        case lbp = "LBP"
        case lrd = "LRD"
        case kid = "KID"
        case szl = "SZL"
        case zar = "ZAR"
        case btn = "BTN"
        case inr = "INR"
        case idr = "IDR"
        case egp = "EGP"
        case jod = "JOD"
        case kpw = "KPW"
        case iqd = "IQD"
        case thb = "THB"
        case zwl = "ZWL"
        case wst = "WST"
        case ttd = "TTD"
        case dop = "DOP"
        case tzs = "TZS"
        case bgn = "BGN"
        case etb = "ETB"
        case ron = "RON"
        case mga = "MGA"
        case vuv = "VUV"
        case xaf = "XAF"
        case ang = "ANG"
        case currenciesTRY = "TRY"
        case xpf = "XPF"
        case yer = "YER"
        case npr = "NPR"
        case dkk = "DKK"
        case fok = "FOK"
        case php = "PHP"
        case irr = "IRR"
        case mvr = "MVR"
        case cuc = "CUC"
        case cup = "CUP"
        case lyd = "LYD"
        case mxn = "MXN"
        case tmt = "TMT"
        case mmk = "MMK"
        case chf = "CHF"
        case rub = "RUB"
        case bam = "BAM"
        case kwd = "KWD"
        case imp = "IMP"
        case kgs = "KGS"
        case lsl = "LSL"
        case rwf = "RWF"
        case sll = "SLL"
        case ghs = "GHS"
        case kyd = "KYD"
        case tnd = "TND"
        case tjs = "TJS"
        case clp = "CLP"
        case srd = "SRD"
        case ars = "ARS"
        case sdg = "SDG"
        case azn = "AZN"
        case uah = "UAH"
        case fkp = "FKP"
        case bzd = "BZD"
        case lak = "LAK"
        case pen = "PEN"
        case amd = "AMD"
        case jpy = "JPY"
        case afn = "AFN"
        case qar = "QAR"
        case bdt = "BDT"
        case bmd = "BMD"
        case cad = "CAD"
        case bsd = "BSD"
        case vnd = "VND"
        case mop = "MOP"
        case sbd = "SBD"
        case zmw = "ZMW"
        case ern = "ERN"
        case khr = "KHR"
        case brl = "BRL"
        case ssp = "SSP"
        case kzt = "KZT"
        case pyg = "PYG"
        case mur = "MUR"
        case pln = "PLN"
        case mdl = "MDL"
        case cny = "CNY"
        case fjd = "FJD"
        case stn = "STN"
        case shp = "SHP"
        case gyd = "GYD"
        case bbd = "BBD"
        case sek = "SEK"
        case bhd = "BHD"
        case sos = "SOS"
        case top = "TOP"
        case hkd = "HKD"
        case bnd = "BND"
        case all = "ALL"
        case mwk = "MWK"
        case awg = "AWG"
        case kes = "KES"
        case tvd = "TVD"
        case ves = "VES"
        case gip = "GIP"
        case bif = "BIF"
        case myr = "MYR"
        case gmd = "GMD"
        case gnf = "GNF"
        case jmd = "JMD"
        case aed = "AED"
        case jep = "JEP"
        case ggp = "GGP"
        case cve = "CVE"
        case syp = "SYP"
        case djf = "DJF"
        case rsd = "RSD"
        case nad = "NAD"
        case kmf = "KMF"
        case pab = "PAB"
        case gel = "GEL"
        case huf = "HUF"
        case czk = "CZK"
        case krw = "KRW"
        case uyu = "UYU"
        case cop = "COP"
        case lkr = "LKR"
        case nio = "NIO"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String?
}

// MARK: - BAM
struct BAM: Codable {
    let name: String?
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng, fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String?
}

// MARK: - Name
struct Name: Codable {
    let common, official: String?
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String?
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format, regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}


