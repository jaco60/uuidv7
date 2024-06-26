with Ada.Text_IO;
with Uuid;

procedure UUIDv7 is
begin
   Ada.Text_IO.Put_Line (Uuid.Generate_UUIDv7);
end UUIDv7;
