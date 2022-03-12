import Foundation

struct Darbinieks {
   enum pieredzesLimenis {
       case praktikants
       case jaunakaisSpecialists
       case specialists
       case vecakaisSpecialists
       case projektaVadiba
       case nodalasVadiba
       case uznemumaVadiba
   }

   enum Dzimums : CustomStringConvertible {
       case virietis
       case sieviete

       var description : String {
           switch self {
               case .virietis: return "virietis"
               case .sieviete: return "sieviete"
           }
       }
   }

   let vards: String
   let uzvards: String
   let dzimsanasDiena: Date?
   let dzimums: Dzimums
   var alga: Double
   var nodalasNosaukums: String
   var ilglaicigsDarbinieks: Bool
   var vecums: Int
}

func pirmaisUzdevums( _ visiDarbinieki: [Darbinieks], vecums: Int) {
    print("------------------- 1. uzdevums -------------------")
    let kartotsPecNodalas = visiDarbinieki.sorted(by: {
        $0.nodalasNosaukums < $1.nodalasNosaukums
    })

    for person in kartotsPecNodalas {
        if (person.dzimums == .sieviete && person.vecums >= vecums) {
            print("nodala: \(person.nodalasNosaukums) | dzimums: \(person.dzimums) | vecums: \(person.vecums)")
        }
    }  
    print("---------------------------------------------------")
}

func otraisUzdevums( _ visiDarbinieki: [Darbinieks], nodalasNosaukums: String, vecumsNo: Int, vecumsLidz: Int) {
    print("------------------- 2. uzdevums -------------------")
    let kartotsPecVecumaUnDzimuma = visiDarbinieki.sorted {
        ($0.vecums, $0.dzimums.description) < ($1.vecums, $1.dzimums.description)
    }

    for person in kartotsPecVecumaUnDzimuma {
        if (person.nodalasNosaukums == nodalasNosaukums && person.vecums >= vecumsNo && person.vecums <= vecumsLidz) {
            print("vecums: \(person.vecums) | dzimums: \(person.dzimums) | Vards: \(person.vards) | Uzvards: \(person.uzvards) | nodala: \(person.nodalasNosaukums)")
        }
    }
    print("---------------------------------------------------")
}

func treshaisUzdevums( _ visiDarbinieki: [Darbinieks]) {
    print("------------------- 3. uzdevums -------------------")
    var nodalasMap = [String: Int]()
    var personCount = 0
    var personSum = 0
    for person in visiDarbinieki {
        nodalasMap[person.nodalasNosaukums] = 0
        personCount += 1
        personSum += person.vecums
    }
    for person in visiDarbinieki {
        var valueSum = nodalasMap[person.nodalasNosaukums]!
        valueSum += person.vecums
        nodalasMap[person.nodalasNosaukums] = valueSum
    }
    for (key, value) in nodalasMap {
        var valueSum = nodalasMap[key]!
        var valueCount = getCount(visiDarbinieki, item: key)
        nodalasMap[key] = valueSum / valueCount
    }
    nodalasMap["Uznemums"] = personSum / personCount
    print(nodalasMap)
    print("---------------------------------------------------")
}

func strToDate(dateBirthYear dzimsanasDiena: String) -> Date? {
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd"
    let date = dfmatter.date(from: dzimsanasDiena)
    return date
}

func dateToStr(dateBirthYear dzimsanasDiena: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.string(from: dzimsanasDiena)
    return date
}

func getAge(birthday: String) -> Int {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    let birthdayDate = dateFormater.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
    let age = calcAge.year
    return age!
}

func getCount( _ visiDarbinieki: [Darbinieks], item: String) -> Int{
    var count = 0;
    for nodala in visiDarbinieki {
        if (nodala.nodalasNosaukums == item) {
            count += 1;
        }
    }
    return count;
}

let d1 = Darbinieks(vards: "Janis", uzvards: "Jančevskis", dzimsanasDiena: strToDate(dateBirthYear: "1987-01-01"), dzimums: .virietis, alga: 3000.00, nodalasNosaukums: "Web", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1987-01-01"))
let d2 = Darbinieks(vards: "Olga", uzvards: "Oga", dzimsanasDiena: strToDate(dateBirthYear: "1986-03-01"), dzimums: .sieviete, alga: 3500.00, nodalasNosaukums: "Menedžments", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1986-03-01"))
let d3 = Darbinieks(vards: "Laila", uzvards: "Laimone", dzimsanasDiena: strToDate(dateBirthYear: "1976-07-11"), dzimums: .sieviete, alga: 2500.00, nodalasNosaukums: "UX-Dizains", ilglaicigsDarbinieks: false, vecums: getAge(birthday: "1976-07-11"))
let d4 = Darbinieks(vards: "Maija", uzvards: "Marina", dzimsanasDiena: strToDate(dateBirthYear: "1987-01-01"), dzimums: .sieviete, alga: 3000.00, nodalasNosaukums: "Web", ilglaicigsDarbinieks: false, vecums: getAge(birthday: "1987-01-01"))
let d5 = Darbinieks(vards: "Harijs", uzvards: "Holdmanis", dzimsanasDiena: strToDate(dateBirthYear: "2000-10-10"), dzimums: .virietis, alga: 2500.00, nodalasNosaukums: "Testēšana", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "2000-10-10"))
let d6 = Darbinieks(vards: "Cēzars", uzvards: "Cēzonis", dzimsanasDiena: strToDate(dateBirthYear: "1999-12-31"), dzimums: .virietis, alga: 2500.00, nodalasNosaukums: "BackEnd", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1999-12-31"))
let d7 = Darbinieks(vards: "Rikardo", uzvards: "Rikmanis", dzimsanasDiena: strToDate(dateBirthYear: "2000-10-13"), dzimums: .virietis, alga: 2500.00, nodalasNosaukums: "Web", ilglaicigsDarbinieks: false, vecums: getAge(birthday: "2000-10-13"))
let d8 = Darbinieks(vards: "Signe", uzvards: "Rikmane", dzimsanasDiena: strToDate(dateBirthYear: "1984-10-13"), dzimums: .sieviete, alga: 2500.00, nodalasNosaukums: "IOS", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1984-10-13"))
let d9 = Darbinieks(vards: "Kate", uzvards: "Kulme", dzimsanasDiena: strToDate(dateBirthYear: "1977-10-13"), dzimums: .sieviete, alga: 3500.00, nodalasNosaukums: "Android", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1977-10-13"))
let d10 = Darbinieks(vards: "Eduards", uzvards: "Eidonis", dzimsanasDiena: strToDate(dateBirthYear: "1965-10-13"), dzimums: .virietis, alga: 3000.00, nodalasNosaukums: "Android", ilglaicigsDarbinieks: true, vecums: getAge(birthday: "1965-10-13"))


var darbinieki: [Darbinieks] = []

func pievienotDarbinieku(employee persona: Darbinieks) {
    darbinieki.append(persona)
}

pievienotDarbinieku(employee: d1)
pievienotDarbinieku(employee: d2)
pievienotDarbinieku(employee: d3)
pievienotDarbinieku(employee: d4)
pievienotDarbinieku(employee: d5)
pievienotDarbinieku(employee: d6)
pievienotDarbinieku(employee: d7)
pievienotDarbinieku(employee: d8)
pievienotDarbinieku(employee: d9)
pievienotDarbinieku(employee: d10)

pirmaisUzdevums(darbinieki, vecums: 34)
otraisUzdevums(darbinieki, nodalasNosaukums: "Web", vecumsNo: 18, vecumsLidz: 45)
treshaisUzdevums(darbinieki)