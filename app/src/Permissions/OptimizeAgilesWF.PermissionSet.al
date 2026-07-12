//namespace Essent.OptimizeAgilesWorkflow.Permissions;

permissionset 92626 OptimizeAgilesWF
{
    Access = Internal;
    Assignable = true;
    Caption = 'Optimize Agiles Workflow', Locked = true;
    Permissions =
         codeunit "PTE Clear Images (Agiles)" = X,
         report "PTE Cleanup Images (Agiles)" = X;
}