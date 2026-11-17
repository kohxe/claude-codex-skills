# 인디케이터 9종 상세

각 섹션: 정의 · 쓸 때 / 쓰지 말 때 · 구조 · 상태 · 접근성 · 흔한 실수 · 최소 코드.
전체 동작 데모는 `../assets/indicators-demo.html`의 같은 번호 섹션(`<section id="ind-NN">`)에 있다.

## 목차
- [01 프로그레스 바](#01-프로그레스-바--progress-bar)
- [02 스텝 인디케이터](#02-스텝-인디케이터--step-indicator)
- [03 페이지 인디케이터](#03-페이지-인디케이터--page-indicator)
- [04 스토리 바](#04-스토리-바--story-progress)
- [05 스크롤 진행 바](#05-스크롤-진행-바--scroll-progress)
- [06 원형 진행률](#06-원형-진행률--progress-ring)
- [07 강도 표시기](#07-강도-표시기--strength-meter)
- [08 탭 인디케이터](#08-탭-인디케이터--tab-indicator)
- [09 홈 인디케이터](#09-홈-인디케이터--home-indicator)
- [React로 옮길 때 공통 요령](#react로-옮길-때-공통-요령)

---

## 01 프로그레스 바 · Progress bar
**정의**: 시스템 작업이 얼마나 끝났는지 가로 막대의 채움으로 보여 준다. 진행률을 알면 *determinate*, 모르면 *indeterminate*(막대가 왔다갔다).

- **쓸 때**: 업로드·다운로드·설치·내보내기처럼 1초 이상 걸리고 진행률을 계산할 수 있는 작업.
- **쓰지 말 때**: 1초 안에 끝나는 작업(깜빡임만 생김), 진행률을 모르는데 가짜로 채우는 경우(거짓 정보 — 차라리 indeterminate).
- **구조**: 트랙(배경) + 채움(fill) + 선택적으로 라벨과 % 텍스트.
- **상태**: 대기 → 진행 중(0–100) → 완료 / 실패(색 + 텍스트 + 다시 시도).
- **접근성**: 네이티브 `<progress value max>`가 가장 쉽다. 커스텀이면 `role="progressbar"`, `aria-valuemin/max/now`, `aria-label` 또는 `aria-labelledby`. indeterminate는 `aria-valuenow`를 빼고 `aria-busy="true"`.
- **흔한 실수**: 99%에서 오래 멈춤(마지막 단계도 진행률에 포함), 막대만 있고 숫자·라벨 없음, 완료 후 사라져서 결과를 못 봄.

```html
<div class="pbar" role="progressbar" aria-label="파일 업로드" aria-valuemin="0" aria-valuemax="100" aria-valuenow="42">
  <div class="pbar__fill" style="--value: 42"></div>
</div>
<style>
  .pbar { height: 8px; border-radius: 999px; background: #e5e7eb; overflow: hidden; }
  .pbar__fill { height: 100%; width: calc(var(--value) * 1%); background: #4f46e5; border-radius: inherit;
                transition: width .3s ease; }
  @media (prefers-reduced-motion: reduce) { .pbar__fill { transition: none; } }
</style>
```
값을 바꿀 때는 `--value`와 `aria-valuenow`를 **같이** 갱신한다.

---

## 02 스텝 인디케이터 · Step indicator
**정의**: 순서가 정해진 여러 단계 과정에서 완료한 단계, 현재 단계, 남은 단계를 보여 준다. Stepper, Progress tracker라고도 한다.

- **쓸 때**: 회원가입, 결제, 신청서처럼 3–7단계로 나뉘고 단계마다 할 일이 있는 흐름.
- **쓰지 말 때**: 단계가 2개뿐(그냥 제목으로 충분), 순서가 상관없는 설정 화면(탭이 맞다), 사이트 위치 표시(브레드크럼이 맞다).
- **구조**: 단계 노드(번호 또는 체크) + 연결선 + 단계 이름.
- **상태**: 완료(체크) / 현재(강조) / 예정(흐림). 완료 단계로 돌아갈 수 있다면 링크·버튼으로.
- **접근성**: `<ol>`로 순서를 표현, 현재 단계에 `aria-current="step"`, 완료 단계에는 시각적으로 숨긴 "완료" 텍스트.
  - **단계가 바뀌면 포커스를 옮긴다**: 다음/이전을 누르면 키보드 포커스를 새 단계의 제목(`tabindex="-1"`)이나 첫 입력 칸으로
    옮긴다. 누른 버튼이 숨겨지거나 사라지면 포커스가 `body`로 떨어져, 키보드·스크린 리더 사용자가 페이지 처음부터 다시 찾아야 한다.
  - 제목에 "2/3단계 · 배송 정보"처럼 위치를 넣으면 포커스가 갈 때 단계 변경이 함께 읽힌다. 이때 같은 내용을
    `aria-live`로 또 알리지 않는다(두 번 읽힌다).
- **흔한 실수**: 색으로만 현재/완료를 구분, 모바일에서 단계 이름이 겹침(모바일은 "2/4 배송 정보"처럼 축약),
  단계를 바꾼 뒤 포커스를 그대로 둠.

```html
<ol class="steps">
  <li class="is-done"><span class="dot">✓</span>장바구니<span class="sr-only"> (완료)</span></li>
  <li class="is-current" aria-current="step"><span class="dot">2</span>배송 정보</li>
  <li><span class="dot">3</span>결제</li>
  <li><span class="dot">4</span>완료</li>
</ol>
```

---

## 03 페이지 인디케이터 · Page indicator
**정의**: 가로로 넘기는 대등한 화면들 중 지금이 몇 번째인지 점으로 보여 준다. Apple은 Page control, 흔히 Dots, Carousel indicator.

- **쓸 때**: 온보딩 3–5장, 이미지 캐러셀, 카드 슬라이더.
- **쓰지 말 때**: 화면이 7–8개 이상(점이 의미 없음 → "3/12" 숫자), 순서·과정이 있는 흐름(스텝 인디케이터).
- **구조**: 점 N개, 현재 점은 크기·색·모양(길쭉한 알약)으로 구분.
- **상태**: 현재 / 나머지. 점을 눌러 이동할 수 있으면 각 점은 버튼.
- **접근성**: 점을 버튼으로 만들고 `aria-label="3번째 슬라이드로"`, 현재 점에 `aria-current="true"`. 슬라이드 컨테이너는 `aria-roledescription="carousel"`. 자동 넘김이면 정지 버튼.
- **흔한 실수**: 점이 너무 작아 터치 불가(시각 점은 8px여도 터치 영역은 24–44px), 스와이프와 점 상태가 어긋남.

```html
<div class="dots" role="group" aria-label="슬라이드 선택">
  <button aria-label="1번째 슬라이드" aria-current="true"></button>
  <button aria-label="2번째 슬라이드"></button>
  <button aria-label="3번째 슬라이드"></button>
</div>
<style>
  .dots { display: flex; gap: 4px; }
  .dots button { width: 24px; height: 24px; border: 0; background: none; display: grid; place-items: center; cursor: pointer; }
  .dots button::before { content: ""; width: 8px; height: 8px; border-radius: 999px; background: #cbd5e1; transition: width .25s; }
  .dots button[aria-current="true"]::before { width: 22px; background: #111827; }
</style>
```
스크롤 위치와 점을 동기화할 때는 `scroll-snap` + 슬라이드마다 IntersectionObserver(threshold 0.6)가 가장 간단하다.

---

## 04 스토리 바 · Story progress
**정의**: 짧은 콘텐츠 여러 개가 자동으로 넘어갈 때, 화면 위에 조각난 막대로 전체 개수·지난 것·현재 것의 남은 시간을 보여 준다. Segmented progress bar.

- **쓸 때**: 스토리, 자동 재생 온보딩, 하이라이트 릴.
- **쓰지 말 때**: 자동으로 넘어가지 않는 캐러셀(페이지 인디케이터가 맞다).
- **구조**: 세그먼트 N개(지난 것 꽉 참, 현재 것 시간에 따라 채움, 남은 것 비어 있음) + 좌/우 탭 영역 + 일시정지.
- **상태**: 재생 / 일시정지(길게 누르기 또는 버튼) / 끝.
- **접근성**: 자동으로 움직이는 콘텐츠는 **멈추기 수단이 필수**(WCAG 2.2.2). 일시정지 버튼, 이전/다음 버튼을 키보드로 쓸 수 있게. 세그먼트 막대는 장식(`aria-hidden`), 대신 "2 / 5" 같은 텍스트를 스크린리더에.
- **흔한 실수**: 탭 영역만 있고 키보드 조작 불가, 탭 전환 시 타이머가 계속 흘러감(`visibilitychange`에서 멈춤).

핵심 로직: 현재 세그먼트의 채움을 CSS 애니메이션(`animation: fill var(--dur) linear forwards`)으로 돌리고 `animationend`에서 다음으로. 일시정지는 `animation-play-state: paused` 한 줄.

```css
.seg { flex: 1; height: 3px; background: rgb(255 255 255 / .35); border-radius: 2px; overflow: hidden; }
.seg > i { display: block; height: 100%; width: 0; background: #fff; }
.seg.is-done > i { width: 100%; }
.seg.is-current > i { animation: story-fill var(--dur, 5s) linear forwards; }
.story.is-paused .seg.is-current > i { animation-play-state: paused; }
@keyframes story-fill { to { width: 100%; } }
```

---

## 05 스크롤 진행 바 · Scroll progress
**정의**: 긴 글에서 얼마나 읽었는지를 화면 맨 위(또는 헤더 아래)에 고정된 얇은 막대로 보여 준다. Reading progress bar.

- **쓸 때**: 블로그·뉴스·문서처럼 세로로 긴 읽기 페이지.
- **쓰지 말 때**: 짧은 페이지, 무한 스크롤 피드(끝이 없어서 의미 없음).
- **구조**: 화면 폭 전체 트랙(보통 투명) + 2–4px 채움.
- **접근성**: 브라우저 스크롤바가 같은 정보를 이미 주므로 장식으로 처리 `aria-hidden="true"`. 본문을 가리지 않게 얇게.
- **흔한 실수**: 스크롤 이벤트마다 width를 바꿔 레이아웃 재계산(→ `transform: scaleX()` 사용), 본문이 아니라 페이지 전체(푸터·댓글 포함) 기준으로 계산.

최신 브라우저는 JS 없이 된다 (Chrome·Edge·Safari 26+ 지원, Firefox는 미지원이라 아래 JS 폴백을 함께 둔다):
```css
.read-progress { position: fixed; inset: 0 0 auto 0; height: 3px; background: #4f46e5;
                 transform-origin: 0 50%; transform: scaleX(0); z-index: 50; }
@supports (animation-timeline: scroll()) {
  .read-progress { animation: grow linear both; animation-timeline: scroll(root); }
  @keyframes grow { to { transform: scaleX(1); } }
}
```
```js
// 폴백 (animation-timeline 미지원 브라우저)
if (!CSS.supports('animation-timeline: scroll()')) {
  const bar = document.querySelector('.read-progress');
  const update = () => {
    const max = document.documentElement.scrollHeight - innerHeight;
    bar.style.transform = `scaleX(${max > 0 ? Math.min(1, scrollY / max) : 0})`;
  };
  addEventListener('scroll', update, { passive: true }); update();
}
```
본문만 기준으로 하려면 `article.getBoundingClientRect()`로 시작·끝 위치를 계산한다.

---

## 06 원형 진행률 · Progress ring
**정의**: 진행률을 원의 둘레 채움으로 보여 준다. Circular progress, Progress circle. 가운데 숫자를 둘 수 있다.

- **쓸 때**: 공간이 좁을 때(버튼 안, 아바타 주변), 목표 달성률(운동 링, 학습 진도), 타이머.
- **쓰지 말 때**: 진행률을 모를 때(그건 스피너), 여러 값을 비교할 때(막대가 비교하기 쉽다).
- **구조**: SVG 원 2개(트랙 + 채움). 채움은 `stroke-dasharray`/`stroke-dashoffset`, 12시에서 시작하도록 -90° 회전.
- **접근성**: `role="progressbar"` + `aria-valuenow`, 가운데 숫자는 시각용이면 `aria-hidden`.

```html
<div class="ring" role="progressbar" aria-label="다운로드" aria-valuemin="0" aria-valuemax="100" aria-valuenow="68" style="--value:68">
  <svg viewBox="0 0 44 44" aria-hidden="true">
    <circle class="ring__track" cx="22" cy="22" r="20" pathLength="100"/>
    <circle class="ring__fill"  cx="22" cy="22" r="20" pathLength="100"/>
  </svg>
  <span aria-hidden="true">68%</span>
</div>
<style>
  .ring { position: relative; width: 96px; aspect-ratio: 1; display: grid; place-items: center; }
  .ring svg { position: absolute; inset: 0; rotate: -90deg; }
  .ring circle { fill: none; stroke-width: 4; }
  .ring__track { stroke: #e5e7eb; }
  .ring__fill { stroke: #4f46e5; stroke-linecap: round; stroke-dasharray: 100;
                stroke-dashoffset: calc(100 - var(--value)); transition: stroke-dashoffset .4s ease; }
</style>
```
`pathLength="100"` 덕분에 반지름을 바꿔도 퍼센트 계산이 그대로다.

---

## 07 강도 표시기 · Strength meter
**정의**: 입력값(주로 비밀번호)의 강도를 칸 채움과 등급 텍스트로 실시간 피드백한다. Password strength meter.

- **쓸 때**: 비밀번호 생성·변경. 그 밖에 "프로필 완성도"처럼 값의 품질을 재는 곳.
- **쓰지 말 때**: 로그인 화면(이미 정한 비밀번호를 평가할 필요 없음).
- **구조**: 3–5칸 세그먼트 + 등급 텍스트 + (선택) 충족 조건 체크리스트.
- **상태**: 비어 있음 / 약함 / 보통 / 강함 / 매우 강함. 색(빨강→초록)과 **텍스트를 함께**.
- **접근성**: 등급 텍스트를 `aria-live="polite"` 영역에 두고 입력창과 `aria-describedby`로 연결. 색만으로 전달하지 않는다.
  `aria-describedby`가 가리키는 요소(등급 문구, 조건 목록)에는 `aria-label`을 달지 않는다 — 라벨이 있으면 내용 대신 라벨만 읽힌다.
  조건 앞 ○/✓ 같은 장식 기호는 `content: "✓ " / "";`로 읽기에서 빼고, 충족 여부는 숨김 텍스트로 전달한다. 의미상 `<meter>`에 해당하지만 스타일링이 어려워 보통 커스텀 + 텍스트로 만든다.
- **흔한 실수**: 길이만 보고 판단(`aaaaaaaa`가 "강함"), 조건을 안 알려 주고 빨간색만 띄움, 키 입력마다 스크린리더가 시끄럽게 읽음(등급이 바뀔 때만 텍스트 갱신).

간단한 점수 규칙(데모에서 사용): 8자 이상, 대소문자 섞임, 숫자, 특수문자, 12자 이상 → 각 1점, 최대 4칸으로 매핑.
실서비스는 `zxcvbn` 같은 라이브러리로 사전 단어·패턴까지 보는 게 정확하다.

---

## 08 탭 인디케이터 · Tab indicator
**정의**: 탭 바에서 현재 선택된 탭 아래(또는 뒤)에 붙는 밑줄·알약 표시. 탭을 바꾸면 미끄러지듯 이동한다. Active indicator, Ink bar.

- **쓸 때**: 같은 화면에서 카테고리를 전환할 때(상단 탭, 세그먼트 컨트롤).
- **쓰지 말 때**: 페이지 이동 내비게이션(그건 링크 + `aria-current="page"`), 순서 있는 과정(스텝).
- **구조**: 탭 목록 + 인디케이터 1개(탭마다 따로 그리지 않고 하나를 움직이면 전환이 자연스럽다).
- **접근성**: `role="tablist"` / `role="tab"` + `aria-selected` + `aria-controls`, 패널은 `role="tabpanel"`. 좌우 화살표로 탭 이동, Home/End, 선택된 탭만 `tabindex="0"`(roving tabindex).
- **흔한 실수**: 인디케이터 위치를 `left/width` 애니메이션으로(→ `transform: translateX()` + `scaleX` 또는 width는 transition만), 글꼴 로딩 후 탭 폭이 변했는데 인디케이터를 다시 재지 않음(ResizeObserver로 재측정).

```js
function moveIndicator(tab) {
  indicator.style.width = tab.offsetWidth + 'px';
  indicator.style.transform = `translateX(${tab.offsetLeft}px)`;
}
new ResizeObserver(() => moveIndicator(tablist.querySelector('[aria-selected="true"]'))).observe(tablist);
```

---

## 09 홈 인디케이터 · Home indicator
**정의**: iPhone(Face ID 모델)과 iPad 화면 맨 아래의 가로 막대. 위로 쓸어 올려 홈으로 가거나 앱을 전환하는 손잡이다. Android 제스처 내비게이션의 "제스처 바"도 같은 역할.

- **우리가 할 일**: 그리지 않는다. OS가 그린다. 대신 **우리 UI가 그 영역(Safe area)을 침범하지 않게** 한다.
- **구조**: OS 소유. 웹에서는 `env(safe-area-inset-bottom)`(대략 34px)만큼의 여백으로 피한다.
- **흔한 실수**: 하단 고정 버튼·탭 바가 홈 인디케이터에 겹쳐 눌리지 않거나 제스처와 충돌, 데모 목업에 홈 인디케이터를 그려 넣고 실제 앱에서도 그려 버림.

```html
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<style>
  .bottom-bar { position: fixed; inset: auto 0 0 0;
                padding: 12px 16px calc(12px + env(safe-area-inset-bottom)); }
</style>
```
`viewport-fit=cover`가 없으면 `env()` 값이 0이라 효과가 없다. 네이티브 앱(SwiftUI)은 기본 safe area를 따르고, React Native는 `react-native-safe-area-context`의 `useSafeAreaInsets()`를 쓴다.

---

## React로 옮길 때 공통 요령
- 진행 값은 prop으로 받고, 시각(`style={{'--value': v}}`)과 ARIA(`aria-valuenow={v}`)를 같은 값에서 렌더한다 — 둘이 어긋나는 게 가장 흔한 버그다.
- 타이머·옵저버(스토리 바, 페이지 인디케이터, 스크롤 진행 바)는 `useEffect` cleanup에서 해제한다.
- 탭은 직접 만들기보다 Radix `Tabs`, React Aria `Tabs`처럼 키보드·ARIA가 갖춰진 헤드리스 컴포넌트에 인디케이터만 얹는 게 안전하다. 프로그레스 바도 Radix `Progress`가 있다.
- Tailwind: 채움 폭은 `style={{ width: `${v}%` }}` 또는 CSS 변수 + `w-[calc(var(--value)*1%)]`.
