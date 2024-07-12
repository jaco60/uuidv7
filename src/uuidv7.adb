with Ada.Text_IO;
with Ada.Assertions;
with Uuid;

procedure UUIDv7 is
   uuid1, uuid2, uuid3, uuid4 : Uuid.UUIDv7;
begin
   uuid1 := Uuid.Generate_UUIDv7;
   delay 1.0;
   uuid2 := Uuid.Generate_UUIDv7;
   delay 1.0;
   uuid3 := Uuid.Generate_UUIDv7;
   delay 1.0;
   uuid4 := Uuid.Generate_UUIDv7;

   Ada.Assertions.Assert
     (uuid1 < uuid2 and then uuid2 < uuid3 and then uuid3 < uuid4);

   Ada.Text_IO.Put_Line (Uuid.Generate_UUIDv7);
end UUIDv7;
