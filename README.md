# Dopaminz-iOS
도파민즈 팀 iOS 레포

## Tuist Usage
1. Install tuist
 
```swift
curl -Ls https://install.tuist.io | bash 
```
2. Generate project

```swift
make clean // optional
make fetch // optional
make cache
make generate
```

처음 프로젝트 받으면 Tuist signing 에 있는 명령어 실행</br> 

## Tuist signing 암호화 해제 

```swift
cd Tuist 한후

tuist signing decrypt
```

