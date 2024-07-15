pragma Ada_2022;

with Ada.Text_IO;
with Ada.Assertions;
with Uuid;

procedure UUIDv7 is

   uuid1, uuid2, uuid3, uuid4 : Uuid.UUIDv7_Str;
begin
   uuid1 := Uuid.Generate_UUIDv7_Str;
   delay 1.0;
   uuid2 := Uuid.Generate_UUIDv7_Str;
   delay 1.0;
   uuid3 := Uuid.Generate_UUIDv7_Str;
   delay 1.0;
   uuid4 := Uuid.Generate_UUIDv7_Str;

   Ada.Assertions.Assert
     (uuid1 < uuid2 and then uuid2 < uuid3 and then uuid3 < uuid4);

   Ada.Text_IO.Put_Line (uuid1);
end UUIDv7;
