//namespace Essent.OptimizeAgilesWorkflow.AgilesWorkflow;

pageextension 92627 "PTE To-Do List" extends "aWF - To-do List"
{
    layout
    {
        modify("Status Picture")
        {
            Visible = false;
        }
        addafter("Status Picture")
        {
            field("PTE Status"; StatusLevelBuffer.Name)
            {
                ApplicationArea = All;
                StyleExpr = StatusStyle;
            }
        }
    }

    trigger OnOpenPage()
    var
        StatusLevel: Record "aWF - Status Level";
        AWFTextTranslationMgt: Codeunit "aWF - Text Translation Mgt.";
    begin
        StatusLevelBuffer.DeleteAll();
        StatusLevel.FindSet();
        repeat
            StatusLevelBuffer := StatusLevel;
            StatusLevelBuffer.Name :=
                    AWFTextTranslationMgt.GetTextFieldTranslationDescription(Database::"aWF - Status Level", StatusLevelBuffer.FieldNo(Name), 0, '', StatusLevelBuffer.Level, false, true);
            StatusLevelBuffer.Insert();
        until StatusLevel.Next() = 0;
    end;

    trigger OnAfterGetRecord()
    begin
        StatusLevelBuffer.Get(Rec."Status Level");
        case StatusLevelBuffer.Style of
            StatusLevelBuffer.Style::Standard:
                StatusStyle := Format(PageStyle::Standard);
            StatusLevelBuffer.Style::StandardAccent:
                StatusStyle := Format(PageStyle::StandardAccent);
            StatusLevelBuffer.Style::Strong:
                StatusStyle := Format(PageStyle::Strong);
            StatusLevelBuffer.Style::StrongAccent:
                StatusStyle := Format(PageStyle::StrongAccent);
            StatusLevelBuffer.Style::Attention:
                StatusStyle := Format(PageStyle::Attention);
            StatusLevelBuffer.Style::AttentionAccent:
                StatusStyle := Format(PageStyle::AttentionAccent);
            StatusLevelBuffer.Style::Favorable:
                StatusStyle := Format(PageStyle::Favorable);
            StatusLevelBuffer.Style::Unfavorable:
                StatusStyle := Format(PageStyle::Unfavorable);
            StatusLevelBuffer.Style::Ambiguous:
                StatusStyle := Format(PageStyle::Ambiguous);
            StatusLevelBuffer.Style::Subordinate:
                StatusStyle := Format(PageStyle::Subordinate);
        end;
    end;

    var
        StatusLevelBuffer: Record "aWF - Status Level" temporary;
        StatusStyle: Text;
}