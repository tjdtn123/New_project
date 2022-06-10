package kopo.poly.service.impl;

public class PasswordWrongException extends RuntimeException {
    PasswordWrongException(){
        super("Password is Wrong");
    }

}
