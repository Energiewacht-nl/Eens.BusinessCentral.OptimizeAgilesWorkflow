codeunit 92626 "PTE Clear Images (Agiles)"
{
    procedure ProcessBuffer()
    var
        ToDo: Record "aWF - To-do";
        Code: Code[20];
    begin
        foreach Code in ToDoBuffer do begin
            ToDo.Get(Code);
            Clear(ToDo."Status Picture");
            ToDo.Modify();
        end;
    end;

    procedure AddToBufferIfImageExists(var ToDo: Record "aWF - To-do")
    begin
        ToDo.CalcFields("Status Picture");
        if ToDo."Status Picture".HasValue then
            ToDoBuffer.Add(ToDo."No.");
    end;

    procedure ClearSetup();
    var
        StatusLevel: Record "aWF - Status Level";
    begin
        repeat
            StatusLevel.CalcFields(Picture);
            if StatusLevel.Picture.HasValue then begin
                Clear(StatusLevel.Picture);
                StatusLevel.Modify();
            end;
        until StatusLevel.Next() = 0;
    end;

    var
        ToDoBuffer: List of [Code[20]];
}