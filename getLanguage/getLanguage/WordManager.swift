//
//  WordManager.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/30.
//

import Foundation

class WordManager {
    
    // TOEIC 600点レベルの単語
    private let toeic600Words = [
        "ability", "above", "account", "address", "advertise", "agree",
        "allow", "alone", "along", "amount", "annual", "anywhere", "apply",
        "approach", "approve", "area", "arrive", "as long as", "ask for",
        "available", "avoid", "aware", "back", "because of", "believe",
        "benefit", "bring", "build", "business", "buy", "careful", "carry",
        "center", "certain", "change", "choose", "close", "common", "company",
        "complete", "concern", "condition", "confirm", "connect", "consider",
        "contact", "continue", "contract", "cost", "cover", "create",
        "customer", "decide", "decrease", "deliver", "demand", "department",
        "depend", "describe", "design", "develop", "direction", "discount",
        "due to", "each", "early", "easily", "effective", "effort", "either",
        "employee", "encourage", "enough", "enter", "especially", "eventually",
        "every", "everyone", "everything", "except", "exist", "expect",
        "experience", "explain", "extend", "extra", "face", "fail", "far",
        "fast", "feel", "figure out", "final", "find", "finish", "first",
        "following", "for example", "for free", "force", "form", "forward",
        "free", "fresh", "from now on", "full", "further", "general", "get back",
        "give up", "go on", "good for", "grow", "happen", "hardly", "have to",
        "health", "hear", "help", "high", "however", "if not", "important",
        "improve", "in addition", "in order to", "include", "increase",
        "individual", "inform", "instead of", "interested", "introduce",
        "involve", "it is likely that", "join", "just as", "keep in mind",
        "know", "last", "late", "later", "leave", "less than", "likely to",
        "local", "long", "look for", "low", "maintain", "make sure", "manage"
    ]
    
    // TOEIC 700点レベルの単語（より高度な語彙）
    private let toeic700Words = [
        "accomplish", "accurate", "acknowledge", "acquire", "adequate", "adjacent",
        "advocate", "aggregate", "allocate", "alternative", "anticipate", "appropriate",
        "approximate", "arbitrary", "assembly", "assess", "attribute", "audit",
        "authorize", "behalf", "bulk", "capable", "capacity", "category",
        "clarify", "collaborate", "commence", "commodity", "competent", "complement",
        "comply", "component", "comprehensive", "compromise", "concept", "conclude",
        "concurrent", "conduct", "conference", "configure", "consecutive", "consent",
        "consequence", "considerable", "consistent", "consolidate", "constitute", "constraint",
        "consult", "contemporary", "contract", "contrary", "contribute", "controversy",
        "conventional", "coordinate", "corporate", "correspond", "criteria", "crucial",
        "currency", "data", "debate", "decline", "dedicate", "demonstrate",
        "derive", "detect", "device", "dimension", "distribute", "diverse",
        "domestic", "dominant", "draft", "dramatic", "duration", "economic",
        "eliminate", "emerge", "emphasis", "enable", "encounter", "enhance",
        "enormous", "ensure", "entity", "equipment", "equivalent", "error",
        "establish", "estimate", "ethnic", "evaluate", "eventual", "evident",
        "exceed", "exclude", "execute", "exhibit", "expand", "expertise",
        "explicit", "exploit", "export", "expose", "external", "extract",
        "facilitate", "factor", "feature", "federal", "finance", "flexible",
        "fluctuate", "format", "formula", "foundation", "framework", "function",
        "fundamental", "generate", "global", "grade", "grant", "guarantee",
        "guideline", "hence", "hypothesis", "identical", "identify", "illustrate",
        "image", "implement", "imply", "impose", "incentive", "incident",
        "incorporate", "index", "indicate", "infrastructure", "initial", "initiate",
        "innovation", "input", "insight", "inspect", "install", "instance",
        "institute", "integrate", "integrity", "intelligence", "intense", "interact",
        "intermediate", "internal", "interpret", "interval", "invest", "investigate",
        "invoke", "isolate", "issue", "item", "justify", "label",
        "labor", "layer", "lecture", "legal", "legislation", "liberal",
        "license", "likewise", "link", "locate", "logic", "maintain",
        "major", "manual", "margin", "mature", "maximum", "mechanism",
        "media", "medical", "medium", "mental", "method", "migrate",
        "minimum", "minor", "mode", "modify", "monitor", "motive",
        "network", "neutral", "nevertheless", "norm", "notion", "nuclear",
        "objective", "obtain", "obvious", "occupy", "occur", "option",
        "orient", "outcome", "output", "overall", "overseas", "panel",
        "parallel", "parameter", "participate", "partner", "passive", "perceive",
        "percent", "period", "persist", "perspective", "phase", "phenomenon",
        "philosophy", "physical", "plus", "policy", "portion", "positive",
        "potential", "practitioner", "precede", "precise", "predict", "preliminary",
        "previous", "primary", "prime", "principal", "principle", "prior",
        "priority", "proceed", "process", "professional", "project", "promote",
        "proportion", "prospect", "protocol", "psychology", "publication", "publish",
        "purchase", "pursue", "qualitative", "quote", "radical", "random",
        "range", "ratio", "rational", "react", "recover", "refine",
        "region", "register", "regulate", "reinforce", "reject", "relate",
        "relevant", "reliable", "reluctant", "rely", "reliance", "remark",
        "remove", "require", "research", "reside", "resolve", "resource",
        "respond", "restore", "restrict", "retain", "reveal", "revenue",
        "reverse", "revise", "revolution", "role", "route", "scenario",
        "schedule", "scheme", "scope", "section", "sector", "secure",
        "seek", "select", "sequence", "series", "shift", "significant",
        "similar", "simulate", "site", "so-called", "sole", "somewhat",
        "source", "specific", "specify", "sphere", "stable", "statistic",
        "status", "straightforward", "strategy", "stress", "structure", "style",
        "submit", "subsequent", "substitute", "sufficient", "summary", "supplement",
        "survey", "survive", "suspend", "sustain", "symbol", "tape",
        "target", "task", "team", "technical", "technique", "technology",
        "temporary", "tense", "terminal", "text", "theme", "theory",
        "thereby", "thesis", "topic", "trace", "tradition", "transfer",
        "transform", "transition", "transmit", "transport", "trend", "trigger",
        "ultimate", "undergo", "underlie", "undertake", "unique", "unit",
        "unity", "universal", "update", "upgrade", "urban", "utility",
        "valid", "vary", "vehicle", "version", "via", "violate",
        "virtual", "visible", "volume", "voluntary", "welfare", "whereas", "whereby"
    ]
    
    // 指定されたレベルに応じて単語を返す
    func getRandomWord(for level: TOEICLevel) -> String {
        let wordList: [String]
        
        switch level {
        case .level600:
            wordList = toeic600Words
        case .level700:
            wordList = toeic700Words
        }
        
        return wordList.randomElement() ?? "error"
    }
    
    // 指定されたレベルの総単語数を返す
    func getWordCount(for level: TOEICLevel) -> Int {
        switch level {
        case .level600:
            return toeic600Words.count
        case .level700:
            return toeic700Words.count
        }
    }
}
