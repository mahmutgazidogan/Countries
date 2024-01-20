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
    let independent: Bool?
    let status: Status?
    let currencies: Currencies?
    let idd: Idd?
    let capital: [String]?
    let region: Region?
    let subregion: String?
    let languages: [String: String]?
    let latlng: [Double]?
    let area: Double?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let car: Car?
    let timezones: [String]?
    let continents: [Continent]?
    var flags: Flags?
    let coatOfArms: CoatOfArms?
    let startOfWeek: StartOfWeek?
    let capitalInfo: CapitalInfo?
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
}

enum Continent: String, Codable, CaseIterable {
    case all = "All"
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
    let usd, ngn, dzd, mad, mru, twd, crc, xof, hnl, aud, eur, uzs, bob, mnt, sgd, scr, nok, htg, pgk, mzn, pkr, ugx, bwp, xcd,
        sar, gbp, gtq, aoa, byn, isk, ils, omr, ckd, nzd, mkd, cdf, lbp, lrd, kid, szl, zar, btn, inr, idr, egp, jod, kpw, iqd,
        thb, zwl, wst, ttd, dop, tzs, bgn, etb, ron, mga, vuv, xaf, ang, currenciesTRY, xpf, yer, npr, dkk, fok, php, irr, mvr,
        cuc, cup, lyd, mxn, tmt, mmk, chf, rub: Aed?
    let bam: BAM?
    let kwd, imp, kgs, lsl, rwf, sll, ghs, kyd, tnd, tjs, clp, srd, ars: Aed?
    let sdg: BAM?
    let azn, uah, fkp, bzd, lak, pen, amd, jpy, afn, qar, bdt, bmd, cad, bsd, vnd, mop, sbd, zmw, ern, khr, brl, ssp, kzt, pyg,
        mur, pln, mdl, cny, fjd, stn, shp, gyd, bbd, sek, bhd, sos, top, hkd, bnd, all, mwk, awg, kes, tvd, ves, gip, bif, myr,
        gmd, gnf, jmd, aed, jep, ggp, cve, syp, djf, rsd, nad, kmf, pab, gel, huf, czk, krw, uyu, cop, lkr, nio: Aed?

    enum CodingKeys: String, CodingKey {
        case usd = "USD", ngn = "NGN", dzd = "DZD", mad = "MAD", mru = "MRU", twd = "TWD", crc = "CRC",
        xof = "XOF", hnl = "HNL", aud = "AUD", eur = "EUR", uzs = "UZS", bob = "BOB", mnt = "MNT", sgd = "SGD", scr = "SCR", nok = "NOK", htg = "HTG",
        pgk = "PGK", mzn = "MZN", pkr = "PKR", ugx = "UGX", bwp = "BWP", xcd = "XCD", sar = "SAR", gbp = "GBP", gtq = "GTQ", aoa = "AOA", byn = "BYN",
        isk = "ISK", ils = "ILS", omr = "OMR", ckd = "CKD", nzd = "NZD", mkd = "MKD", cdf = "CDF", lbp = "LBP", lrd = "LRD", kid = "KID", szl = "SZL",
        zar = "ZAR", btn = "BTN", inr = "INR", idr = "IDR", egp = "EGP", jod = "JOD", kpw = "KPW", iqd = "IQD", thb = "THB", zwl = "ZWL", wst = "WST",
        ttd = "TTD", dop = "DOP", tzs = "TZS", bgn = "BGN", etb = "ETB", ron = "RON", mga = "MGA", vuv = "VUV", xaf = "XAF", ang = "ANG",
        currenciesTRY = "TRY", xpf = "XPF", yer = "YER", npr = "NPR", dkk = "DKK", fok = "FOK", php = "PHP", irr = "IRR", mvr = "MVR", cuc = "CUC",
        cup = "CUP", lyd = "LYD", mxn = "MXN", tmt = "TMT", mmk = "MMK", chf = "CHF", rub = "RUB", bam = "BAM", kwd = "KWD", imp = "IMP", kgs = "KGS",
        lsl = "LSL", rwf = "RWF", sll = "SLL", ghs = "GHS", kyd = "KYD", tnd = "TND", tjs = "TJS", clp = "CLP", srd = "SRD", ars = "ARS", sdg = "SDG",
        azn = "AZN", uah = "UAH", fkp = "FKP", bzd = "BZD", lak = "LAK", pen = "PEN", amd = "AMD", jpy = "JPY", afn = "AFN", qar = "QAR", bdt = "BDT",
        bmd = "BMD", cad = "CAD", bsd = "BSD", vnd = "VND", mop = "MOP", sbd = "SBD", zmw = "ZMW", ern = "ERN", khr = "KHR", brl = "BRL", ssp = "SSP",
        kzt = "KZT", pyg = "PYG", mur = "MUR", pln = "PLN", mdl = "MDL", cny = "CNY", fjd = "FJD", stn = "STN", shp = "SHP", gyd = "GYD", bbd = "BBD",
        sek = "SEK", bhd = "BHD", sos = "SOS", top = "TOP", hkd = "HKD", bnd = "BND", all = "ALL", mwk = "MWK", awg = "AWG", kes = "KES", tvd = "TVD",
        ves = "VES", gip = "GIP", bif = "BIF", myr = "MYR", gmd = "GMD", gnf = "GNF", jmd = "JMD", aed = "AED", jep = "JEP", ggp = "GGP", cve = "CVE",
        syp = "SYP", djf = "DJF", rsd = "RSD", nad = "NAD", kmf = "KMF", pab = "PAB", gel = "GEL", huf = "HUF", czk = "CZK", krw = "KRW", uyu = "UYU",
        cop = "COP", lkr = "LKR", nio = "NIO"
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

// MARK: - Flags
struct Flags: Codable {
    var png: String?
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



