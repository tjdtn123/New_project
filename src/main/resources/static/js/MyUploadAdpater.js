class MyUploadAdapter {
    constructor(loader) {
        this.loader = loader;
    }

    upload() {
        return this.loader.file
            .then( file => new Promise( ( resolve, reject ) => {
                this._initRequest();
                this._initListeners( resolve, reject, file );
                this._sendRequest( file );
            } ) );
    }

    abort() {
        if ( this.xhr ) {
            this.xhr.abort();
        }
    }


    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();
        //여기서는 POST 요청과 json으로 응답을 받지만 어떤 포맷으로 하든 너의 선택이다.
        xhr.open('POST', 'http://3.34.110.134:11000/fileUpload', true);

        xhr.responseType = 'json';
    }

    //XHR 리스너 초기화 하기
    _initListeners( resolve, reject, file ) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = `Couldn't upload file: ${ file.name }.`;
        xhr.addEventListener( 'error', () => reject( genericErrorText ) );
        xhr.addEventListener( 'abort', () => reject() );
        xhr.addEventListener( 'load', () => {
            const response = xhr.response;
            // 이 예제에서는 XHR서버에서의 response 객체가 error와 함께 올 수 있다고 가정한다. 이 에러는
            // 메세지를 가지며 이 메세지는 업로드 프로미스의 매개변수로 넘어갈 수 있다.
            if ( !response || response.error ) {
                return reject( response && response.error ? response.error.message : genericErrorText );
            }
            // 만약 업로드가 성공했다면, 업로드 프로미스를 적어도 default URL을 담은 객체와 함께 resolve하라.
            // 이 URL은 서버에 업로드된 이미지를 가리키며, 컨텐츠에 이미지를 표시하기 위해 사용된다.
            resolve( {
                default: response.url
             } );
    } );
        // 파일로더는 uploadTotal과 upload properties라는 속성 두개를 갖는다.
        // 이 두개의 속성으로 에디터에서 업로드 진행상황을 표시 할 수 있다.
        if ( xhr.upload ) {
            xhr.upload.addEventListener( 'progress', evt => {
                if ( evt.lengthComputable ) {
                    loader.uploadTotal = evt.total;
                    loader.uploaded = evt.loaded;
                }
            } );
        }
    }



    _sendRequest(file) {
        const data = new FormData()
        data.append('upload',file)
        this.xhr.send(data)
    }
}