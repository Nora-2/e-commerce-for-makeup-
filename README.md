# Flutter E-commerce X 

A flutter E-commerce app template.

## Screenshots
![Screenshot_1](https://user-images.githubusercontent.com/111413480/213930626-d59cc147-1294-43d8-baf0-011348f127c3.jpg)
![Screenshot_2](https://user-images.githubusercontent.com/111413480/213930656-13329dc6-3a01-4a01-b5fa-e89f5e8d3899.jpg)
![Screenshot_3](https://user-images.githubusercontent.com/111413480/213930674-e7ff38a0-a9d9-4a4a-998f-fd41f783ae6a.jpg)
![Screenshot_4](https://user-images.githubusercontent.com/111413480/213930691-a87a6e9b-3b7e-4c2d-8e0b-af4bc3a1112d.jpg)
![Screenshot_5](https://user-images.githubusercontent.com/111413480/213930716-b2f3fbd3-adc9-45c1-ac53-69a990f38860.jpg)
![Screenshot_6](https://user-images.githubusercontent.com/111413480/213930733-e3c9de65-f6c0-4063-891f-0d7c26ff4b7e.jpg)
![Screenshot_7](https://user-images.githubusercontent.com/111413480/213930739-010aef8c-7fa8-485b-bdb0-a5d8171359bf.jpg)
![Screenshot_8](https://user-images.githubusercontent.com/111413480/213930749-f804f4e9-38a9-4ca0-b446-f0c112aaf24e.jpg)

### Screens

Intro , Home , Cart , Profile , Search , Checkout , Payment , Login$SignUp , Favorits , Order history , User Address , Shoping

### Development Notice

1- Clone project with https://github.com/EmirBashiri/Flutter-E-commerce-X.git

2- Run flutter pub get in terminal

3- Run flutter run in terminal and enjoy
# Flutter ChatGPT

## ChatGPT Application with flutter

ChatGPT is a chatbot launched by OpenAI in November 2022. It is built on top of OpenAI's GPT-3.5 family of large language models, and is fine-tuned with both supervised and reinforcement learning techniques.

### Install Package

```
chat_gpt: 2.0.0
pub get
```

#### Example

Create ChatGPT Instance

1. Parameter
  Token
    Your secret API keys are listed below. Please note that we do not display your secret API keys again after you generate them.
    Do not share your API key with others, or expose it in the browser or other client-side code. In order to protect the security of your account, OpenAI may also automatically rotate any API key that we've found has leaked publicly.
    https://beta.openai.com/account/api-keys
2. OrgId
    Identifier for this organization sometimes used in API requests
    https://beta.openai.com/account/org-settings

'final openAI = OpenAI.instance.build(token: token,baseOption: HttpSetup(receiveTimeout: 6000),isLogger: true);'

3. Text Complete API
   Translate Method
   translateEngToThai
   translateThaiToEng
   translateToJapanese

4. Model
   kTranslateModelV3
   kTranslateModelV2
   kCodeTranslateModelV2
   Translate natural language to SQL queries.
   Create code to call the Stripe API using natural language.
   Find the time complexity of a function.
   https://beta.openai.com/examples

```
final request = CompleteText(prompt: translateEngToThai(word: ''),
model: kTranslateModelV3, maxTokens: 200);

openAI.onCompleteStream(request:request).listen((response) => print(response))
.onError((err) {
print("$err");
});
```

5. Complete with StreamBuilder

```
final tController = StreamController<CTResponse?>.broadcast();

openAI
.onCompleteStream(request: request)
.asBroadcastStream()
.listen((res) {
tController.sink.add(res);
});

///ui code
StreamBuilder<CTResponse?>(
stream: tController.stream,
builder: (context, snapshot) {
final data = snapshot.data;
if(snapshot.connectionState == ConnectionState.done) return something
if(snapshot.connectionState == ConnectionState.waiting) return something
return something
})
```

6. Complete with Feature

```
void _translateEngToThai() async{
final request = CompleteText(
prompt: translateEngToThai(word: _txtWord.text.toString()),
max_tokens: 200,
model: kTranslateModelV3);

final response = await openAI.onCompleteText(request: request);
print(response);
}
```

Example Q&A
Answer questions based on existing knowledge.

```
final request = CompleteText(prompt:'What is human life expectancy in the United States?'),
model: kTranslateModelV3, maxTokens: 200);

openAI.onCompleteStream(request:request).listen((response) => print(response))
.onError((err) {
print("$err");
});
```

Request

Q: What is human life expectancy in the United States?

Response

A: Human life expectancy in the United States is 78 years.

Generate Image
    prompt
       A text description of the desired image(s). The maximum length is 1000 characters.
       The number of images to generate. Must be between 1 and 10.
    size
       The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    response_format
       The format in which the generated images are returned. Must be one of url or b64_json.
    user
       A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
       Generate with stream

```
openAI = OpenAI
.instance
.builder(toekn:"token",
baseOption: HttpSetup(receiveTimeout: 7000),isLogger:true);

const prompt = "Snake Red";

final request = GenerateImage(prompt,2);

               openAI.generateImageStream(request)
              .asBroadcastStream()
              .listen((it) {
                print(it.data?.last?.url)
              });

/// cancel stream controller
openAI.genImgClose();
```

Generate with feature

```
void _generateImage() {
const prompt = "cat eating snake blue red.";

final request = GenerateImage(prompt,2);
final response = openAI.generateImage(request);
print("img url :${response.data?.last?.url}");
}
```

Model List

List and describe the various models available in the API. You can refer to the Models documentation to understand what models are available and the differences between them.

```final models = await openAI.listModel();```