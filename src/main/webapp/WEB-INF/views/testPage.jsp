<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <!-- include libraries(jQuery, bootstrap) -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- CKEditor 5 CDN 적용-->
    <script src="/ckeditor/build/ckeditor.js"></script>
    <style>
        body {
            background-image : url("/static/assets/wallpaper.jpg");

        }

    </style>
    <script type="text/javascript">
    function MyCustomUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
    return new MyUploadAdapter(loader)
    }
    }
    </script>
</head>
<body>
<%@ include file="import/Navigation.jsp" %>
    <form name="f" method="post" action="/board/BoardInsert" target="ifrPrc" onsubmit="return doSubmit(this);">

            <textarea name="contents" id="contents"></textarea>

        <div align="center" colspan="2">
            <input type="submit" value="등록" />
            <input type="reset" value="다시 작성" />
        </div>
    </form>

    <iframe name="ifrPrc" style="display:none"></iframe>

    <!-- 글쓰기 에디터 실행-->
    <script>
        ClassicEditor.create( document.getElementById("contents"),{
                extraPlugins: [MyCustomUploadAdapterPlugin]
                }

            )
            .catch( error => {
                console.error(error);
            })

    </script>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

    </body>
</html>