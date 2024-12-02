# Battle RPG GAME
개인 과제 - 지역 검색 앱

## 프로젝트 소개
아래의 기능들이 있는 지역 겁색 앱

<br>

| HomePage | StationListPage | SeatPage |
| --- | --- | --- |
| <img src=''> | <img src=''> | <img src=''> |

<br>

< 필수 기능 > 
1. HomePage 구현
2. 지역 검색 기능 구현

< 도전 기능 >
1. 현재 위치 조회 후 네이버 API로 검색
2. 나만의 기능 추가
    
## 적용 기능
#### < 필수 기능 >
>* HomePage 구현 : 
<br>지역을 검색할 수 있는 HomePage 초기 화면 구현<br><br>
>* 지역 검색 기능 구현 : 
<br>TextField에 값을 입력후 Submit 하면 네이버 API를 통해 검색값을 받아오는 기능 구현 + 박스 누를시 해당 link가 연결되어 있는 Detailpage 구현<br><br>
#### < 도전 기능 >
>* 현재 위치 조회 후 네이버 API로 검색 :
<br>HomePage의 IconButton을 누르면, 현재 기기의 위치정보를 받은 후, 해당 위치정보를 기반으로 네이버 API에서 검색을 실시하는 로직 구현<br><br>
#### < 자유 구현 >
>* UX - 검색을 할때, 검색중 or 검색결과 없음이 출력되도록 하기 : 
<br>검색을 시작했을때, 로딩 Indicator가 보이도록하고 TextField를 누를 수 없도록 잠구기, 만일 검색값이 없는경우 '검색결과가 없습니다' 같은 문구를 출력함<br><br>


## 🚨 Trouble Shooting

<details>
<summary>📚[ RiverPod 메서드 작동부분 ]</summary>
<div markdown="1">

### [ TIL - RiverPod 메서드 작동 ](https://hamiric.tistory.com/70)

 <br>
</div>
</details>


## 📝Technologies & Tools (FE)

| 기술스택 | 배지 |
| --- | --- |
| Language | ![Dart Version](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=Dart&logoColor=white) |
| Framework | ![Flutter Version](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=Flutter&logoColor=white) |
| Code Editor | ![VSCode Version](https://img.shields.io/badge/VSCode-0175C2?style=flat-square) |
| Library | ![GetX Version](https://img.shields.io/badge/GetX-8A2BE2?style=flat-square&logo=GetX&logoColor=white) ![RiverPod Version](https://img.shields.io/badge/RiverPod-6DB33F?style=flat-square) ![InAppWebView Version](https://img.shields.io/badge/inAppWebView-007396?style=flat-square) ![HTTP Version](https://img.shields.io/badge/HTTP-F8A000?style=flat-square) ![Geolocator Version](https://img.shields.io/badge/Geolocator-512BD4?style=flat-square) |
| Version Control | ![Git Version](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=Git&logoColor=white) ![GitHub Version](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white) |