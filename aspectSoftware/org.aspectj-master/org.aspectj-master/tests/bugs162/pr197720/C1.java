package test.aspects;


public class C1<T> {

    @MyAnn
    protected void aMethod() {
        System.out.println("Calling aMethod");
    }
    
    public void callAMethod() {
        aMethod(); // Should be a marker here...
    }

}
