// this is where the javascript will go!

let output = document.getElementById('output');

// this is for things passed to the javascript by ruby
let values = document.getElementById('values');
let cardDesc = values.getAttribute("cardDesc");

// TODO: 2-word keywords do not work as currently implemented.
const KEYWORDS = {
    "monster": "https://yugipedia.com/wiki/Monster_Card",
    "spell": "https://yugipedia.com/wiki/Spell_Card",
    "trap": "https://yugipedia.com/wiki/Trap_Card",
    "dark": "https://yugipedia.com/wiki/DARK",
    "divine": "https://yugipedia.com/wiki/DIVINE",
    "earth": "https://yugipedia.com/wiki/EARTH",
    "fire": "https://yugipedia.com/wiki/FIRE",
    "light": "https://yugipedia.com/wiki/LIGHT",
    "water": "https://yugipedia.com/wiki/WATER",
    "wind": "https://yugipedia.com/wiki/WIND",
    "pendulum": "https://yugipedia.com/wiki/Pendulum",
    "normal": "https://yugipedia.com/wiki/Normal",
    "effect": "https://yugipedia.com/wiki/Effect",
    "ritual": "https://yugipedia.com/wiki/Ritual_Monster",
    "fusion": "https://yugipedia.com/wiki/Fusion_Monster",
    "synchro": "https://yugipedia.com/wiki/Synchro_Monster",
    "xyz": "https://yugipedia.com/wiki/Xyz_Monster",
    "link": "https://yugipedia.com/wiki/Link_Monster",
    "special": "https://yugipedia.com/wiki/Special_Summon",
    "tuner": "https://yugipedia.com/wiki/Tuner_monster",
    "flip": "https://yugipedia.com/wiki/Flip_monster",
    "toon": "https://yugipedia.com/wiki/Toon_monster",
    "spirit": "https://yugipedia.com/wiki/Spirit_monster",
    "union": "https://yugipedia.com/wiki/Union_monster",
    "gemini": "https://yugipedia.com/wiki/Gemini_monster",
    "excavate": "https://yugipedia.com/wiki/Excavate",
    "counter": "https://yugipedia.com/wiki/Counter",
    "counters": "https://yugipedia.com/wiki/Counter",
    "aqua": "https://yugipedia.com/wiki/Aqua",
    "beast": "https://yugipedia.com/wiki/Beast",
    "beast-warrior": "https://yugipedia.com/wiki/Beast-Warrior",
    "cyberse": "https://yugipedia.com/wiki/Cyberse",
    "dinosaur": "https://yugipedia.com/wiki/Dinosaur",
    "divine-beast": "https://yugipedia.com/wiki/Divine-Beast",
    "dragon": "https://yugipedia.com/wiki/Dragon",
    "fairy": "https://yugipedia.com/wiki/Fairy",
    "fiend": "https://yugipedia.com/wiki/Fiend",
    "fish": "https://yugipedia.com/wiki/Fish",
    "illusion": "https://yugipedia.com/wiki/Illusion",
    "insect": "https://yugipedia.com/wiki/Insect",
    "machine": "https://yugipedia.com/wiki/Machine",
    "plant": "https://yugipedia.com/wiki/Plant",
    "psychic": "https://yugipedia.com/wiki/Psychic",
    "pyro": "https://yugipedia.com/wiki/Pyro",
    "reptile": "https://yugipedia.com/wiki/Reptile",
    "rock": "https://yugipedia.com/wiki/Rock",
    "sea serpent": "https://yugipedia.com/wiki/Sea_Serpent", //NOT VALID
    "spellcaster": "https://yugipedia.com/wiki/Spellcaster",
    "thunder": "https://yugipedia.com/wiki/Thunder",
    "warrior": "https://yugipedia.com/wiki/Warrior",
    "winged beast": "https://yugipedia.com/wiki/Winged_Beast", //NOT VALID
    "wyrm": "https://yugipedia.com/wiki/Wyrm",
    "zombie": "https://yugipedia.com/wiki/Zombie",
    "level": "https://yugipedia.com/wiki/Level",
    "rank": "https://yugipedia.com/wiki/Rank",
    "link rating": "https://yugipedia.com/wiki/Link_Rating", //NOT VALID
    "pendulum scale": "https://yugipedia.com/wiki/Pendulum_Scale", //NOT VALID
    "atk": "https://yugipedia.com/wiki/ATK",
    "def": "https://yugipedia.com/wiki/DEF",
    "continuous": "https://yugipedia.com/wiki/Continuous_Effect",
    "equip": "https://yugipedia.com/wiki/Equip_Spell_Card",
    "field": "https://yugipedia.com/wiki/Field_Spell_Card",
    "quick-play": "https://yugipedia.com/wiki/Quick-Play_Spell_Card",
    "ritual": "https://yugipedia.com/wiki/Ritual_Spell_Card",
    "token": "https://yugipedia.com/wiki/Monster_Token",
    "lp": "https://yugipedia.com/wiki/LP",
    "damage": "https://yugipedia.com/wiki/Damage",
    "face-down": "https://yugipedia.com/wiki/Face-down",
    "face-up": "https://yugipedia.com/wiki/Face-up",
    "control": "https://yugipedia.com/wiki/Control",
    "controls": "https://yugipedia.com/wiki/Control",
    "owner": "https://yugipedia.com/wiki/Owner",


}

finish();

function finish() {
  let textArr = getCardText(cardDesc)
    output.replaceWith(textArr);
}

// custom string splitting.
// strings are split according to the characters listed in start and end,
// which are included in the split strings based on which array they were in.
// however, if the splitting characters are contained within double quotes, 
// we don't split on them.
// assume that all quotes will be closed.
function splitOnCharsQuotesafe(str, start = [], end = []) {
    ret = [];
    quoted = false;
    curr = ``;
    for(let i = 0; i < str.length; i++) {
        if(str[i] == `"`) { //first, check & toggle quoting.
            quoted = !quoted;
        }

        //check 
        if(start.includes(str[i]) && !quoted) {
            ret.push(curr);
            curr = ``;
        } 
        curr += str[i];
        if(end.includes(str[i]) && !quoted) {
            ret.push(curr);
            curr = ``;
        }
    }
    ret.push(curr);
    return ret;
}


// splits card text into sentences.
// https://stackoverflow.com/questions/71812772/skipfail-workaround-in-javascript-regexp helped me figure out some tricky regex witchcraft. with escaping quotes.
function getSentences(text) {
    let newText = text.trim();
    let ret = splitOnCharsQuotesafe(newText, ["●"], [".", '\n']);

    return ret;
}

//splits card sentences into clauses.
function getClauses(sentence) {
    //regex applies to : or ;
    //let regex = /(?=".*")|(?<=;|:)/g
    //let clauses = sentence.trim().split(regex)
    let clauses = splitOnCharsQuotesafe(sentence.trim(), [], [';',':'])
    return clauses
}

//transforms a clause into a list of words.
function getWords(clause) {
    //regex applies to whitespace
    let regex = /(?<=\s)/g
    regex = /\s/g
    let words = clause.trim().split(regex)
    return words
}

//transforms a list of words back into a clause.
function wordsToClause(words) {
    ret = ""
    for (var i = 0; i < words.length; i++) {
        ret += words[i] + " "
    }
    //console.log(ret)
    return ret.trim()
}

// detects Key Words in an array of words and does transform to them.
function applyKeyWords(words, transform) {
    // for word in clauses
    //    if word is in keywords
    //       transform(word)
    // return words
    ret = []
    for (var i = 0; i < words.length; i++) {
        keyword = KEYWORDS[words[i].trim().replace(/[.,\/#!$%\^&\*;:{}=\_`~()]/g, "").toLowerCase()]
        if (keyword != null) {
            console.log('True')
            ret.push(transform(words[i], keyword))
        } else {
            console.log('False')
            ret.push(words[i])
        }
    }
    return ret
}

function transformKeyWords(word, keyword) {
    return `<a href="${keyword}">${word}</a>`
}

//turns card sentences into divs.
function formatOutput(splitSentences) {
    let ret = document.createElement('div')
    ret.classList.add('outputContainer')

    for (i in splitSentences) {
        block = splitSentences[i];
        if (typeof block != 'string') {
            ret.appendChild(formatOutputClauses(block));
        } else {
            ret.appendChild(makeDiv(block))
        }
    }
    return ret;
}

//turns a complex sentence into divs.
//complex sentences have one div be the parent, and the remaining divs be the children.
function formatOutputClauses(sentence) {
    let ret = document.createElement('div');
    ret.classList.add('sentence');
    for (i = sentence.length - 1; i >= 0; i--) {
        block = sentence[i];
        let me = makeDiv(block)

        //for screen reader purposes, we need the sentence to be split up LESS so that it doesn't pause in weird spots.
        me.setAttribute('aria-label', sentence)
        me.appendChild(ret)
        ret = me
    }
    return ret;
}

//turns card clause into div.
function makeDiv(clause) {
    let ret = document.createElement('div');
    ret.classList.add('sentence')
    ret.innerHTML = ret.innerHTML + clause
    return ret
}

// gets the content typed in CardBody and converts it into an array of sentences.
function getCardText(cardText) {
    let cardSentences = getSentences(cardText)

    let splitSentences = []
    for (var i = 0; i < cardSentences.length; i++) {
        sentence = cardSentences[i]
        clauses = getClauses(sentence)

        for (var j = 0; j < clauses.length; j++) {
            words = getWords(clauses[j])
            words = applyKeyWords(words, transformKeyWords)
            clauses[j] = wordsToClause(words)
        }
        splitSentences.push(clauses)
    }

    ret = formatOutput(splitSentences)
    return ret
}

/* for database API:
 * you can use the version API to check if cards are up to date
 * 1. if todays date is not the last date the database was stored, check version API
 * 2. if the last loaded version is not the current loaded version, update DB
 * 3. if there is no stored database then just update the cards anyways since they don't exist
 * 
 * version endpoint: https://db.ygoprodeck.com/api/v7/checkDBVer.php
 * db endpoint: https://db.ygoprodeck.com/api/v7/cardinfo.php
 */
async function checkDB() {
    try {
        if ((localStorage.versionDB && localStorage.updatedOn) || forceUpdate) {
            console.log('checking update')
            // check dates
            const newDate = getDate();
            if (localStorage.updatedOn != newDate || forceUpdate)  {
                // check version
                const newVers = await getVersion();
                if (localStorage.versionDB != await newVers || forceUpdate) {
                    // update database
                    const untrimmedDB = await getDBFromAPI();
                    transferDBInfo(await untrimmedDB);
                    

                    // update versionDB
                    localStorage.versionDB = newVers;
                }

                // update date
                localStorage.updatedOn = newDate;
            }
        } else {
            const untrimmedDB = await getDBFromAPI();
            transferDBInfo(await untrimmedDB);

            const newVers = await getVersion();
            localStorage.versionDB = newVers;

            const newDate = getDate();
            localStorage.updatedOn = newDate;
        }
    } catch (error) {
        console.error(`Error: ${error.message}`)
    }
}

function getDate() {
    let date = new Date();
    const newDate = `${date.getUTCDate()}-${date.getUTCMonth()}-${date.getUTCFullYear()}`;
    return newDate;
}

async function getVersion() {
    const url = 'https://db.ygoprodeck.com/api/v7/checkDBVer.php';
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new error(`Response status: ${response.status}`);
        }
        const ret = (await response.json())[0].database_version
        return ret;
    } catch (error) {
        console.error(`Error: ${error.message}`)
    }
}

async function getDBFromAPI() {
    const url = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new error(`Response status: ${response.status}`);
        }
        const ret = (await response.json()).data
        console.log(await ret[0])
        return ret;
    } catch (error) {
        console.log(`Error: ${error.message}`)
    }
}

//transfers information pulled from the API to the local indexedDB
function transferDBInfo(untrimmed_db) {
    console.log('trimming database...');

    const transaction = db.transaction(DB_STORE_NAME, "readwrite");
    transaction.oncomplete = function (event) {
        console.log('trimming complete!');
    }
    transaction.onerror = function (event) {
        console.error(`transferDBInfo: ${event.target.error}`);
    }
    const objectStore = transaction.objectStore(DB_STORE_NAME);
    const clearRequest = objectStore.clear();

    /*const request = objectStore.add(FAKE_CARD);
    request.onsuccess = function (event) {
        console.log(`added fake card`);
    }*/
    
    for(let i = 0; i < untrimmed_db.length; i++) {
        let trimmedCard = {};
        let untrimmedCard = untrimmed_db[i];
        for(let j = 0; j < FIELD_NAMES.length; j++) {
            const field = FIELD_NAMES[j];
            if(untrimmedCard[field]) {
                trimmedCard[field] = untrimmedCard[field]
            }
        }
        //console.log(trimmedCard);
        
        //"search name" is a sanitized version of the name. special characters replaced by whitespace and all letters to caps
        let sName = trimmedCard.name
        sName = sName.replace(/[^\x00-\x7F]/g, " ");
        sName = sName.toUpperCase();
        sName = sName.trim();
        trimmedCard['searchname'] = sName

        
        //add card to database
        const request = objectStore.add(trimmedCard);
        request.onsuccess = function (event) {
            console.log(`${i} / ${untrimmed_db.length}: ${trimmedCard.id} ${trimmedCard.searchname} `);
        }
    }
    console.log(FAKE_CARD);
    //return trimmedDB;
}
