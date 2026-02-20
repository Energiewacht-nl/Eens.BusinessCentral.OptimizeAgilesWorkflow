codeunit 92627 "PTE Clear Images (Agiles)"
{
    procedure ProcessBuffer(HideDialog: Boolean)
    var
        ToDo: Record "aWF - To-do";
        Code: Code[20];
        Dlg: Dialog;
        i: Integer;
    begin
        if not HideDialog then
            Dlg.Open('Clearing images... #1############ of ' + Format(ToDoBuffer.Count));
        foreach Code in ToDoBuffer do begin
            ToDo.Get(Code);
            Clear(ToDo."Status Picture");
            ToDo.Modify();
            i += 1;
            if not HideDialog then begin
                Dlg.Update(1, i);
            end;
        end;
        if not HideDialog then
            Dlg.Close();
    end;

    procedure AddToBufferIfImageExists(var ToDo: Record "aWF - To-do"): Integer
    begin
        ToDo.CalcFields("Status Picture");
        if not ToDo."Status Picture".HasValue then
            exit;

        ToDoBuffer.Add(ToDo."No.");
        exit(1);
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