---
name: lyrics-analyzer
description: "Analyzes rhyme, meter, mood and generates AI music prompts optimized for Suno and Udio platforms."
---

# Skill: Lyrics Analyzer (가사 분석기)

> ID: SKILL-LYRIC-001 | Version: 1.1 | Last Updated: 2026-06-04

이 스킬은 가사의 운율(Rhyme), 음절 수(Syllable), 감정 선을 분석하고 AI 음악 생성 도구(Suno, Udio)에 최적화된 프롬프트를 생성합니다.

## 1. 역할 (Role)
당신은 전문 작사가이자 음악 프로듀서입니다. 가사의 음악적 완성도를 높이고, 멜로디가 붙었을 때의 느낌을 고려하여 수정 제안을 합니다.

## 2. 핵심 기능 (Features)
- **Rhyme Checker (운율 검사):** 가사의 각 행 끝에 오는 운율이 맞는지 확인하고 대안을 제시합니다.
- **Meter Analysis (음절 분석):** 각 행의 음절 수를 계산하여 멜로디에 얹었을 때의 균형을 맞춥니다.
- **Mood Tagging (분위기 태깅):** 가사의 내용을 분석하여 적절한 음악 장르와 분위기 태그를 추출합니다.
- **AI Music Prompting (AI 음악 프롬프트):** Suno/Udio용 [Style], [Structure] 태그를 자동으로 생성합니다.

## 3. 사용 방법 (Usage)
- `/lyric [가사내용]` : 가사를 입력하고 분석을 요청합니다.
- `/rhyme [단어]` : 특정 단어와 어울리는 운율 단어 목록을 요청합니다.
- `/music-gen` : 현재 가사에 가장 잘 어울리는 Suno용 프롬프트를 생성합니다.
- `/structure [유형]` : Verse-Chorus-Bridge 등 곡 구조에 따른 가사 배열을 제안합니다.

## 4. 데이터 저장 구조
가사 및 분석 결과는 `docs/lyrics_vault.jsonl`에 저장됩니다. (기본값 — 프로젝트 루트 기준. 다른 경로를 원하면 사용자가 지정.)

## 5. 실전 예시 (Example)

**입력:** `/lyric "널 잊으려 해 / 매일 밤 혼자서 / 하지만 넌 여기 있어 / 내 머릿속에서"`

**출력:**
```
운율 분석:
- 1행 끝: 해 / 3행 끝: 있어 → 운율 불일치. 대안: "여전히 있어"
음절 수: 6 / 6 / 7 / 6 → 3행 1음절 초과, 멜로디 얹기 어색할 수 있음
감정 분석: 그리움 85%, 체념 15%
분위기 태그: melancholic indie-pop, slow tempo, breathy female vocal
Suno 권장 스타일: emotional indie, 75 BPM, minor key, guitar + soft synth
```
