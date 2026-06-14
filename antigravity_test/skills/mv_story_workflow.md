---
name: mv-story-workflow
description: Automate music video story creation from song to image prompts in 7 steps. Use when turning Suno songs into MV storyboards and scene prompts.
---

# Skill: MV Story Workflow (뮤직비디오 스토리 자동화 워크플로우)

> ID: SKILL-STORY-008 | Version: 1.1 | Last Updated: 2026-06-13
> 참조: AI Content Labs Hero's Journey MV Prompt + AI Novel Prompter 워크플로우
> Suno AI 음악 → 세계관 → 캐릭터 → 스토리 → 이미지 프롬프트 → 영상 → 쇼츠 자동화

이 스킬은 노래 하나를 입력받아 MV 제작에 필요한 **모든 기반 문서를 자동 생성**하는 파이프라인입니다.

> **다른 스킬과의 관계:**
> - **이 스킬 (mv_story_workflow)** → 먼저 실행: 세계관·캐릭터·장면 목록·이미지 프롬프트 문서 생성 ("무엇을")
> - `mv_director.md` → 이후 실행: 생성된 장면 목록을 받아 카메라·조명·색감·컷 타이밍 결정 ("어떻게")

## 1. 역할 (Role)
당신은 AI 콘텐츠 자동화 파이프라인의 오케스트레이터입니다. 노래 제목·가사·장르를 입력받아 세계관 → 캐릭터 → 스토리 → 이미지 프롬프트 → 영상 프롬프트 → 쇼츠 대본까지 7단계 문서를 순서대로 생성합니다. 연출 세부사항(카메라·조명)은 `mv_director` 스킬에 위임합니다.

## 2. 7단계 워크플로우

```
[INPUT]  노래 제목 + 가사 + 장르 + 분위기
    │
    ▼
STEP 1  세계관 생성      → world.md
STEP 2  캐릭터 생성      → characters.md
STEP 3  스토리 아웃라인   → story_outline.md  (Hero's Journey 또는 Save the Cat)
STEP 4  장면 분해        → scene_breakdown.md (섹션별 장면)
STEP 5  이미지 프롬프트   → image_prompts.md  (AI 이미지 생성용)
STEP 6  영상 프롬프트     → video_prompts.md  (Runway / Kling용)
STEP 7  쇼츠 대본        → shorts_script.md  (60초 컷 편집 가이드)
    │
    ▼
[OUTPUT]  완성 MV 패키지
```

## 3. 각 단계 출력 형식

### STEP 1: world.md
```markdown
# 세계관: [노래 제목] 유니버스
배경: [시대·장소]
분위기: [비주얼 레퍼런스]
핵심 규칙: [2~3개]
```

### STEP 2: characters.md
```markdown
# 등장인물
## 주인공
- 이름: AI Boy / AI Girl chibi toy robot
- 역할: 서사의 중심
- 감정선: [Verse] → [Chorus] → [Outro]
## 조력자 / 기억 속 인물
- 역할: 주인공의 감정 유발 대상
```

### STEP 3: story_outline.md
```markdown
# 스토리 아웃라인 (Save the Cat 기반)
Opening Image: [Verse 1 — 현재 상태]
Catalyst:      [Pre-Chorus — 변화 유발]
Break Into Two: [Chorus — 감정 절정]
All Is Lost:   [Bridge — 최저점]
Final Image:   [Outro — 변화 후 상태]
```

### STEP 4: scene_breakdown.md
```markdown
# 장면 분해
| 섹션 | 장면 | image_type | 장소 | 행동 |
|------|------|-----------|------|------|
| Verse 1 | ... | story | ... | ... |
```

### STEP 5: image_prompts.md
```markdown
# 이미지 프롬프트
## Scene 01 — [섹션]
[AI 이미지 생성 프롬프트 (영어)]
추천 툴: Midjourney / Flux | 비율: 16:9
```

### STEP 6: video_prompts.md
```markdown
# 영상 프롬프트
## Scene 01
Image: [생성된 이미지 파일명]
Camera: [Slow push in / Static / Pan]
Duration: [3~5초]
Tool: [Runway Gen-3 / Kling AI]
```

### STEP 7: shorts_script.md
```markdown
# 쇼츠 대본 (60초)
00:00~00:05  Intro cut — [장면]
00:05~00:15  Verse 1 — [장면]
00:15~00:25  Pre-Chorus — [장면]
00:25~00:45  Chorus — [장면, 클라이맥스]
00:45~00:55  Bridge — [장면]
00:55~01:00  Outro — [Final Image]
트랜지션: [컷 방식]
BGM 타이밍: [코러스 시작 = 00:25]
```

## 4. 사용 방법 (Usage)
- `/mv-all [노래제목] [가사] [장르]` : 7단계 전부 순서대로 실행
- `/mv-step [1-7] [입력]` : 특정 단계만 실행
- `/mv-world [노래]` : STEP 1만 — 세계관 생성
- `/mv-chars [노래]` : STEP 2만 — 캐릭터 생성
- `/mv-story [노래]` : STEP 3만 — 스토리 아웃라인
- `/mv-images [장면목록]` : STEP 5만 — 이미지 프롬프트 일괄 생성
- `/mv-short [장면목록]` : STEP 7만 — 60초 쇼츠 대본

## 5. 실전 예시 (Example)

**입력:** `/mv-all "골목길 돌아서" [가사 첨부] "indie 발라드"`

**STEP 1 출력 (world.md 요약):**
```
세계관: 현대 서울 야간 도시
배경: 비 온 뒤 골목, 편의점, 버스 정류장
분위기: 레퍼런스 — 숲 "비도 오고 그래서" MV, 잔나비 "주저하는 연인들을 위해"
핵심 규칙: 실제 장소만, 화려한 조명 없음, 혼자인 장면 위주
```

**STEP 7 출력 (shorts_script.md 요약):**
```
00:00~00:04  골목 입구 — 와이드, AI Boy 걷기 시작
00:04~00:14  Verse 1 — 뒤를 돌아보는 AI Boy (story)
00:14~00:22  Pre-Chorus — 감정 쌓임, 표정 클로즈업
00:22~00:42  Chorus — 편의점 유리 반사 + 버스정류장 빈 자리 (2컷)
00:42~00:52  Bridge — 골목 끝에서 멈춤, 망설임
00:52~01:00  Outro — 같은 골목 다시 진입, 루프 구도
트랜지션: Chorus 진입 시 Hard cut, Outro는 Fade out
```
