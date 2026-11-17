---
name: ai-motion-effects
description: >
  밋밋한 웹사이트·랜딩페이지·UI에 시각/모션 효과를 입히는 스킬. 20가지 효과(Liquid Motion, Holographic,
  Claymorphism, Halftone, Isometric, Kinetic Typography, Y2K Chrome, Paper Cutout, Infinite Zoom, Vaporwave,
  Text Scramble, Bauhaus, Neubrutalism, Shape Morph, Memphis Design, Line Animation, Low Poly,
  Squash and Stretch, Grainy Gradient, Glitch) 각각에 바로 돌아가는 데모 코드와 복붙용 프롬프트가 들어 있어서,
  효과를 골라 사용자의 프로젝트(HTML, React, Next.js, Tailwind 등)에 실제로 구현해 준다.
  "사이트가 밋밋해", "히어로 좀 화려하게", "모션 효과 넣어줘", "인터랙션 추가해줘", "글리치 효과", "홀로그램 카드",
  "클레이모피즘 버튼", "글자가 촤라락 바뀌는 효과", "베이퍼웨이브 느낌", "뉴브루탈리즘 스타일로", "그레인 그라디언트 배경",
  "선이 그려지는 애니메이션", "모션 효과 프롬프트 줘", "효과 뭐 있는지 보여줘" 같은 요청이면 스킬 이름을 말하지 않아도
  이 스킬을 쓴다. 효과 이름을 몰라도 느낌만 말하면(예: "무지개빛으로 번쩍이는 카드", "종이 오려 붙인 느낌") 카탈로그에서
  찾아 준다. 이미 있는 애니메이션의 타이밍·이징을 다듬는 일은 improve-animations, 효과 이름만 묻는 질문은
  animation-vocabulary가 더 맞다.
---

# AI 모션 효과 20가지

"AI로 만든 사이트가 밋밋하다"는 문제를, 이름 있는 시각 스타일 20개 중 하나를 골라 제대로 구현하는 것으로 푼다.
효과마다 **그대로 열면 돌아가는 데모 파일**이 있고, 그 파일 머리 주석에 느낌·잘 맞는 자리·조절 포인트·성능·접근성·
이식 메모가 정리돼 있다. 데모는 출발점이다 — 사용자의 브랜드와 코드베이스에 맞게 옮겨 심는 게 이 스킬의 본업이다.

## 들어 있는 것

| 경로 | 언제 읽나 |
|---|---|
| `effects/NN-이름.html` | 효과를 고른 뒤 구현 직전에 **해당 파일만** 통째로 읽는다 (각 60–200줄, 외부 의존성 없음) |
| `gallery.html` | 사용자가 "뭐가 있는지 보여줘", "골라볼래" 할 때 브라우저로 연다. 20개가 한 화면에 실시간으로 돈다 |
| `references/prompts-ko.md` | 사용자가 코드 대신 "프롬프트만 줘"라고 할 때, 또는 다른 AI 도구에 넘길 지시문이 필요할 때 |

아래 경로는 모두 이 SKILL.md가 있는 폴더 기준이다 (Claude Code는 보통 `~/.claude/skills/ai-motion-effects/`, Codex는 `~/.codex/skills/ai-motion-effects/`).

## 작업 흐름

### 1. 상황 파악 — 물어보기 전에 먼저 본다
- **어디에**: 히어로 배경 / 헤드라인 텍스트 / 버튼·카드 같은 컴포넌트 / 섹션 전환 중 어디인가.
- **스택**: `package.json`, 설정 파일, 기존 컴포넌트를 보고 판단한다 (React? Next.js App Router? Vue? Tailwind? 순수 HTML?).
- **톤**: 기존 색·폰트·카피에서 브랜드 분위기를 읽는다. 진지한 B2B인지, 장난스러운 Gen-Z 브랜드인지.
코드에서 알 수 있는 건 묻지 않는다. 진짜 모르는 것(예: 어떤 분위기를 원하는지)만 짧게 묻는다.

### 2. 효과 고르기
- 사용자가 효과 이름을 말했으면 그걸 쓴다.
- 느낌만 말했으면 아래 **느낌 → 효과** 표로 찾는다.
- 아무 말도 없으면 자리와 톤에 맞는 후보 2–3개를 이유 한 줄씩 붙여 추천하고, 원하면 `gallery.html`을 열어 보여 준다.
  (Windows: `start "" "<스킬폴더>\gallery.html"`, macOS: `open`, 또는 브라우저 도구로 file:// 경로를 연다.)

### 3. 데모 읽고 이식하기
1. `effects/NN-*.html`을 읽는다. 머리 주석의 **조절 포인트**와 **이식 메모**가 핵심이다.
2. 효과의 본체(핵심 CSS/JS)만 떼어 사용자의 구조에 맞게 옮긴다. 데모의 페이지 뼈대(`.stage`, `.tag` 라벨 등)는 가져가지 않는다.
3. **색·폰트·카피를 사용자의 것으로 바꾼다.** 데모 색과 문구가 그대로 남으면 바로 "템플릿 티"가 난다.
   브랜드 토큰(CSS 변수, Tailwind theme)이 있으면 그걸 연결한다.
4. 스택별 요령:
   - **React**: JS가 있는 효과는 `useEffect` 안에서 시작하고 cleanup에서 `cancelAnimationFrame`, `observer.disconnect()`,
     `removeEventListener`를 꼭 호출한다 (StrictMode에서 두 번 마운트돼도 루프가 겹치지 않게). DOM은 `useRef`로 잡는다.
   - **Next.js App Router**: 브라우저 API를 쓰는 컴포넌트는 `'use client'`. 캔버스 크기는 마운트 후에 잰다.
   - **SVG 필터/그라디언트 id**: 한 페이지에 여러 번 쓰면 id가 충돌한다 → React는 `useId()`로 고유 id를 만든다.
   - **Tailwind**: 키프레임은 `tailwind.config`의 `keyframes/animation`(v4는 CSS `@theme`)에 등록하고, 복잡한 필터·의사요소는
     전역 CSS나 CSS 모듈에 둔다. arbitrary value로 억지로 다 넣지 않는다.
   - **Vue/Svelte**: `onMounted/onUnmounted`(Svelte는 `onMount`의 반환 함수)로 같은 원칙.

### 4. 지켜야 할 것 (이유와 함께)
- **`prefers-reduced-motion`**: 움직임에 멀미를 느끼는 사람이 있다. 반복·연속 모션은 멈춘 예쁜 정지 화면으로 바꾼다.
  데모마다 처리돼 있으니 이식할 때 빠뜨리지 않는다.
- **한 화면에 효과는 1–2개**: 배경형 하나 + 포인트형 하나가 상한이다. 그 이상이면 산만하고 성능도 무너진다.
  눈에 띄는 장식 레이어는 하나하나가 효과로 센다(그레인·노이즈, 글로우, 장식용 오버레이 등). 그레이니 그라디언트처럼
  그레인이 효과 본체에 들어 있으면 하나로 치고, 글자 대비만을 위한 움직이지 않는 스크림·패널은 세지 않는다.
- **브랜드 색은 그대로 둔다**: 단색 브랜드 배경(`bg-brand` 등)을 그라디언트로 바꾸지 않는다. 효과는 브랜드 색 위나
  주변에 얹을 뿐 브랜드 색 자체를 다시 칠하지 않는다. 보조 색이 필요하면 기존 팔레트·토큰에서 가져오거나
  `color-mix()`·투명도로 브랜드 색에서 파생한다 — 팔레트에 없는 색을 새로 하드코딩하면 효과만 따로 떠 보인다.
  홀로그램 무지개처럼 효과 자체가 색인 경우는 예외지만, 그때도 바탕의 브랜드 색은 남기고 블렌드 레이어로 위에 얹는다.
- **글자 위 움직이는 배경은 대비 확보**: 반투명 패널이나 그라데이션 스크림을 깔아 본문 대비 4.5:1을 지킨다.
  카드처럼 효과 레이어(포일·글레어·노이즈)를 겹칠 때는 글자 레이어를 맨 위(`z-index`)에 둬서 효과가 글자를 덮지 않게 한다.
- **transform/opacity 위주**: layout을 건드리는 속성(width, top 등) 애니메이션은 버벅인다.
- **필요할 때만 돈다**: 캔버스·rAF 루프는 IntersectionObserver와 `document.hidden`으로 화면 밖에서 정지. 포인터·센서를
  따라가는 루프는 목표에 도착하면 스스로 멈추고 다음 입력에서 다시 시작한다(02 데모의 `settled`). 캔버스 DPR은 2로 제한.
  CSS `infinite` 애니메이션도 같다: 화면 밖이면 IntersectionObserver로 클래스를 붙여 `animation-play-state: paused`로
  멈춘다(특히 `background-position`·`filter`처럼 매 프레임 다시 그리는 속성). 데모는 한 화면짜리라 이 코드를 뺐으니,
  스크롤이 있는 실제 페이지에 옮길 때 붙인다.
- **모바일엔 hover가 없다**: 아무것도 안 해도 효과가 보이게 자동 재생을 두고, 탭·드래그에도 반응하게 한다. 기울기가
  어울리는 효과(홀로그래픽 등)는 폰 기울기 센서를 쓴다 — iOS는 `click` 핸들러 안에서
  `DeviceOrientationEvent.requestPermission()`으로 권한을 받아야 하고, 가로 모드면 축을 돌려 보정한다(02 데모 참고).
  효과 요소에 `touch-action: none`을 주면 그 위에서 스크롤이 막히므로 `pan-y`를 쓴다.
- **번쩍임 제한**: 글리치·깜빡임은 초당 3회 미만, 화면 전체가 번쩍이지 않게 (광과민성 발작 기준).

### 5. 확인
구현한 페이지를 브라우저로 열어 실제로 움직이는지, 콘솔 에러가 없는지 본다. 가능하면 reduced-motion도 에뮬레이션해
정지 화면이 멀쩡한지 확인한다. 확인 못 했으면 못 했다고 말한다.

## 카탈로그

유형: **배경**(섹션 전체를 채움) · **텍스트**(헤드라인용) · **스타일**(컴포넌트의 생김새 자체) · **마이크로**(작은 요소의 움직임)
무게: 가벼움(CSS만) · 보통(SVG 필터나 가벼운 JS) · 무거움(캔버스 매 프레임 그리기)

| # | 효과 | 한 줄 느낌 | 잘 맞는 자리 | 유형 | 무게 | 파일 |
|---|---|---|---|---|---|---|
| 01 | Liquid Motion 리퀴드 모션 | 액체처럼 붙었다 떨어지는 말랑한 덩어리 | 히어로 배경, 앱/핀테크 랜딩 | 배경 | 보통 | `effects/01-liquid-motion.html` |
| 02 | Holographic 홀로그래픽 | 각도 따라 무지갯빛이 흐르는 포일 카드 | 멤버십·티켓·상품 카드 | 스타일 | 보통 | `effects/02-holographic.html` |
| 03 | Claymorphism 클레이모피즘 | 찰흙처럼 말랑한 3D 파스텔 UI | 키즈·교육·캐주얼 앱 버튼/카드 | 스타일 | 가벼움 | `effects/03-claymorphism.html` |
| 04 | Halftone 하프톤 | 만화 인쇄 같은 점 패턴 | 포스터형 히어로, 일러스트 대체 | 배경 | 무거움 | `effects/04-halftone.html` |
| 05 | Isometric 아이소메트릭 | 비스듬히 내려다본 3D 블록 | 기능 소개, 아키텍처/플로우 설명 | 스타일 | 가벼움 | `effects/05-isometric.html` |
| 06 | Kinetic Typography 키네틱 타이포 | 글자가 하나씩 춤추며 등장 | 히어로 헤드라인, 슬로건 | 텍스트 | 가벼움 | `effects/06-kinetic-typography.html` |
| 07 | Y2K Chrome Y2K 크롬 | 2000년대 은빛 금속 글씨 | 패션·음악·이벤트 타이틀 | 텍스트 | 가벼움 | `effects/07-y2k-chrome.html` |
| 08 | Paper Cutout 페이퍼 컷아웃 | 종이를 오려 겹친 그림자 레이어 | 동화·브랜드 스토리, 친근한 히어로 | 배경 | 보통 | `effects/08-paper-cutout.html` |
| 09 | Infinite Zoom 인피니트 줌 | 끝없이 빨려 들어가는 터널 | 인트로, 로딩, 몰입형 섹션 | 배경 | 보통 | `effects/09-infinite-zoom.html` |
| 10 | Vaporwave 베이퍼웨이브 | 80년대 네온 석양과 그리드 | 레트로 이벤트, 게임, 음악 | 배경 | 가벼움 | `effects/10-vaporwave.html` |
| 11 | Text Scramble 텍스트 스크램블 | 해커 영화처럼 글자가 촤라락 풀림 | 테크/개발자 제품 헤드라인, 내비 hover | 텍스트 | 가벼움 | `effects/11-text-scramble.html` |
| 12 | Bauhaus 바우하우스 | 빨강·파랑·노랑 기하 도형 포스터 | 포트폴리오, 디자인 스튜디오 | 스타일 | 가벼움 | `effects/12-bauhaus.html` |
| 13 | Neubrutalism 뉴브루탈리즘 | 두꺼운 검은 테두리와 각진 그림자 | Gen-Z 브랜드, 인디 SaaS, 커뮤니티 | 스타일 | 가벼움 | `effects/13-neubrutalism.html` |
| 14 | Shape Morph 셰이프 모프 | 도형이 스르륵 다른 도형으로 변신 | 아이콘 전환, 히어로 오브젝트 | 마이크로 | 보통 | `effects/14-shape-morph.html` |
| 15 | Memphis Design 멤피스 디자인 | 지그재그·물결·점이 뿌려진 80년대 팝 | 이벤트·프로모션, 키즈 | 배경 | 가벼움 | `effects/15-memphis-design.html` |
| 16 | Line Animation 라인 애니메이션 | 선이 스스로 그려지는 드로잉 | 아이콘, 일러스트, 서명, 카드 테두리 | 마이크로 | 가벼움 | `effects/16-line-animation.html` |
| 17 | Low Poly 로우 폴리 | 삼각형 조각으로 이뤄진 다면체 면 | 테크 히어로 배경, 게임 | 배경 | 무거움 | `effects/17-low-poly.html` |
| 18 | Squash and Stretch 스쿼시 앤 스트레치 | 젤리처럼 눌렸다 늘어나는 탄성 | 버튼 피드백, 캐릭터, 로딩 | 마이크로 | 가벼움 | `effects/18-squash-and-stretch.html` |
| 19 | Grainy Gradient 그레이니 그라디언트 | 필름 노이즈 낀 몽환적 그라데이션 | 스타트업 히어로, 뉴스레터, 앱 배경 | 배경 | 보통 | `effects/19-grainy-gradient.html` |
| 20 | Glitch 글리치 | 디지털 오류처럼 깨지는 화면 | 게임·음악·사이버 테마 타이틀 | 텍스트 | 가벼움 | `effects/20-glitch.html` |

## 느낌 → 효과 (사용자가 이름을 모를 때)

| 사용자가 이렇게 말하면 | 효과 |
|---|---|
| 물처럼 출렁, 끈적하게 합쳐지는, 용암 램프 | Liquid Motion |
| 무지개빛 반짝 카드, 포켓몬 레어카드, 각도 따라 색 변함 | Holographic |
| 말랑말랑, 찰흙, 3D 귀여운 버튼, 장난감 같은 | Claymorphism |
| 만화책 점점이, 신문 인쇄 느낌, 도트 | Halftone |
| 비스듬한 3D, 게임 맵, 블록 쌓은 | Isometric |
| 글자가 춤추듯, 한 글자씩 튀어나오는 | Kinetic Typography |
| 은색 금속 글씨, 크롬, 2000년대 감성, 반짝이 별 | Y2K Chrome |
| 종이 오려 붙인, 그림자 겹겹이, 팝업북 | Paper Cutout |
| 끝없이 빨려 들어가는, 무한 확대, 터널 | Infinite Zoom |
| 80년대 레트로, 네온 석양, 핑크 그리드 | Vaporwave |
| 해커 영화, 글자가 촤라락 바뀌는, 암호 풀리듯 | Text Scramble |
| 빨강·파랑·노랑 도형, 모던 포스터, 기하학 | Bauhaus |
| 두꺼운 검은 테두리, 각진 그림자, 투박하게 힙한 | Neubrutalism |
| 모양이 스르륵 변하는, 아메바 같은 블롭 | Shape Morph |
| 알록달록 지그재그·물결 도형 뿌린, 80년대 팝 | Memphis Design |
| 선이 그려지는, 손으로 쓰는 듯한, 드로잉 | Line Animation |
| 삼각형 조각, 다면체, 크리스탈 면 | Low Poly |
| 통통 튀는, 젤리, 눌렀다 튕기는 | Squash and Stretch |
| 노이즈 낀 그라데이션, 필름 질감, 몽환적 배경 | Grainy Gradient |
| 화면 깨짐, 디지털 오류, 지지직, 사이버펑크 | Glitch |

## 조합 레시피

원칙: **배경형 하나 + 텍스트형이나 마이크로형 하나.** 배경형 두 개, 스타일형 두 개를 섞으면 서로 싸운다.

| 상황 | 조합 |
|---|---|
| 스타트업·SaaS 히어로 | Grainy Gradient 배경 + Text Scramble 헤드라인 |
| 게임·음악·이벤트 | Vaporwave 배경 + Glitch 타이틀 |
| 키즈·교육·캐주얼 앱 | Claymorphism 컴포넌트 + Squash and Stretch 버튼 피드백 |
| 디자이너 포트폴리오 | Bauhaus 레이아웃 + Shape Morph 또는 Line Animation |
| Gen-Z 브랜드·커뮤니티 | Neubrutalism 컴포넌트 + Memphis 배경 장식(아주 옅게) |
| 멤버십·티켓·컬렉터블 | Holographic 카드 + Y2K Chrome 타이틀 |
| 브랜드 스토리·동화 | Paper Cutout 배경 + Kinetic Typography 문장 |
| 테크·AI 제품 | Low Poly 또는 Liquid Motion 배경 + Text Scramble |

## 프롬프트만 원할 때

사용자가 코드를 원하지 않고 "클로드(또는 다른 AI)에 붙여 넣을 프롬프트"를 원하면 `references/prompts-ko.md`에서 해당
효과 프롬프트를 가져와 `[대괄호]` 자리를 사용자 상황(적용 위치, 브랜드 색, 스택)으로 채워서 준다.
좋은 효과 프롬프트의 뼈대는 이렇다 — 사용자가 직접 쓸 때도 이 순서를 알려 주면 된다:

> **효과 이름** + **적용 위치** + **색·톤** + **동작(무엇이 언제 어떻게 움직이는지, 속도)** + **기술 조건(스택, 라이브러리 여부)** + **접근성·성능 조건(reduced-motion, 모바일)**
