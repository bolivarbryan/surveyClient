# surveyClient

App Navigation Flow

<img width="781" alt="Screenshot 2023-09-24 at 3 13 22 PM" src="https://github.com/bolivarbryan/surveyClient/assets/810092/7f44e682-7296-429e-9dab-f84467817503">


## Demo App

https://github.com/bolivarbryan/surveyClient/assets/810092/2c6f4cf5-66ab-4255-bace-f47d9cec3be9


## NimbleAPI.swift

This is a Swift file that defines an enum `NimbleAPI`, which contains various cases representing different API endpoints. This enum conforms to the `TargetType` protocol from the `Moya` library, which is used for defining network requests.


## IMPORTANT

⚠️ you must provide client id and secret on API package in order to make it work

```swift
    private var clientID: String { "" }
    private var clientSecret: String { "" }
```


### Usage

To use this API, you can create an instance of `NimbleAPI` and pass it to a `MoyaProvider` to make network requests. For example, you can do the following:


```swift
let provider = MoyaProvider<NimbleAPI>()

provider.request(.register(email: "test@example.com", name: "John Doe", password: "password", passwordConfirmation: "password")) { result in
    switch result {
    case .success(let response):
        // Handle successful response
        print(response.data)
    case .failure(let error):
        // Handle error
        print(error.localizedDescription)
    }
}
```

## APIProvider.swift

This is a Swift file that defines a struct `APIProvider` with static methods for making network requests using the `NimbleAPI` enum and the `Moya` library.

### Usage

To use this `APIProvider`, you can call the `request(service:completion:)` method and pass in the desired `NimbleAPI` case and a completion closure that will be called with the response data. For example:

```swift
APIProvider.request(service: .surveyList(page: 1)) { data in
    // Handle response data
    print(data)
}
```


## Storage.swift

This is a Swift file that defines a protocol `Storage` and several structs that conform to this protocol. The `Storage` protocol provides a common interface for saving and fetching values from storage (in this case, `UserDefaults`). The structs `AccessToken`, `TokenType`, and `RefreshToken` are implementations of this protocol, each handling a specific value related to user authentication.

### Usage

To save or fetch a value using these structs, you can call the corresponding methods directly. For example:

```swift
AccessToken.save("123abc")
let accessToken = AccessToken.fetch()
print(accessToken) // Output: "123abc"
```

### Protocols and Structs

- `Storage`: This is a protocol that defines two static methods: `save(_:)` to save a value and `fetch()` to retrieve a value. It is implemented by several structs.

- `AccessToken`: This struct handles the user access token and provides the static methods to save and fetch the token value from `UserDefaults`. The access token value is saved under the key "user_access_token".

- `TokenType`: This struct handles the token type and provides the static methods to save and fetch the token type value from `UserDefaults`. The token type value is saved under the key "user_token_type"


## Language
The `Language` struct contains nested structs for different sections of the app. It includes the following:

### Login
- `email`: A string representing the localized "Email" text.
- `password`: A string representing the localized "Password" text.
- `forgot`: A string representing the localized "Forgot?" text.
- `login`: A string representing the localized "Log in" text.

### PasswordRecover
- `title`: A string representing the localized title for the password recovery screen.
- `email`: A string representing the localized "Email" text.
- `reset`: A string representing the localized "Reset" text.
- `titleAlert`: A string representing the localized title for the password recovery success alert.
- `bodyAlert`: A string representing the localized body text for the password recovery success alert.

### Home
- `dayFormat`: A string representing the format for displaying the current date on the home screen.
