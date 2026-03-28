// Google Translate public endpoint — no API key required. Responses are cached in
// sessionStorage so each unique string is only fetched once per browser session.

const LANG_CODES = {
    hi: 'hi', bho: 'bho', mai: 'mai', mr: 'mr', gu: 'gu', raj: 'hi',
    pa: 'pa', te: 'te', ta: 'ta', kn: 'kn', ml: 'ml', or: 'or',
    as: 'as', bn: 'bn', ur: 'ur', ne: 'ne', sa: 'sa', sd: 'sd',
    es: 'es', fr: 'fr', ar: 'ar', zh: 'zh-CN', pt: 'pt', de: 'de',
    ja: 'ja', ko: 'ko', ru: 'ru', id: 'id', tr: 'tr', it: 'it',
    nl: 'nl', vi: 'vi', th: 'th', sw: 'sw', ms: 'ms', fa: 'fa',
    pl: 'pl', uk: 'uk', el: 'el', cs: 'cs', ro: 'ro', hu: 'hu',
    sv: 'sv', no: 'no',
};

function hash(str) {
    let h = 0;
    for (let i = 0; i < str.length; i++) h = (Math.imul(31, h) + str.charCodeAt(i)) | 0;
    return (h >>> 0).toString(36);
}

export async function translateText(text, langCode) {
    if (!text || langCode === 'en') return text;
    const tl = LANG_CODES[langCode];
    if (!tl) return text;

    const cKey = `tr_${tl}_${hash(text)}`;
    const cached = sessionStorage.getItem(cKey);
    if (cached !== null) return cached;

    try {
        const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${tl}&dt=t&q=${encodeURIComponent(text)}`;
        const res = await fetch(url);
        const data = await res.json();
        // Response format: [ [[chunk, original], ...], "en" ]
        const result = data[0].map(s => (s[0] || '')).join('');
        if (result) sessionStorage.setItem(cKey, result);
        return result || text;
    } catch {
        return text; // fallback to English on network error
    }
}

// Translates question text + all option texts in parallel
export async function translateQuestion(question, langCode) {
    if (langCode === 'en' || !question) return question;
    const [questionText, ...optionTexts] = await Promise.all([
        translateText(question.questionText, langCode),
        ...question.options.map(o => translateText(o.optionText, langCode)),
    ]);
    return {
        ...question,
        questionText,
        options: question.options.map((o, i) => ({ ...o, optionText: optionTexts[i] })),
    };
}

// Translates personalityTrait, personalityDescription, empowermentMessage + nextQuestion
export async function translateFeedback(feedback, langCode) {
    if (langCode === 'en' || !feedback) return feedback;
    const [personalityTrait, personalityDescription, empowermentMessage, nextQuestion] = await Promise.all([
        translateText(feedback.personalityTrait, langCode),
        translateText(feedback.personalityDescription, langCode),
        translateText(feedback.empowermentMessage, langCode),
        feedback.nextQuestion ? translateQuestion(feedback.nextQuestion, langCode) : Promise.resolve(null),
    ]);
    return { ...feedback, personalityTrait, personalityDescription, empowermentMessage, nextQuestion };
}
