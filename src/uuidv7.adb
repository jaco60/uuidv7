with Ada.Text_IO;
with Uuid;

procedure UUIDv7 is
   use Ada.Text_IO;
begin
   Put_Line (Uuid.Generate_UUIDv7);
end UUIDv7;
