pragma Ada_2022;

with Ada.Text_IO;
with Ada.Assertions;
with Uuid;

procedure UUIDv7 is

   --  type Byte is mod 2**8;
   --  type UUIDv7 is array (1 .. 16) of Byte;

   --  function Squeeze (Id : Uuid.UUIDv7_Str) return UUIDv7 is
   --    Tmp          : String (1 .. 32);   -- UUIDv7_Str'Length - 4
   --    Res          : UUIDv7;
   --    I_Tmp, I_Res : Positive := 1;
   --  begin
   --    -- Remove the - characters
   --    Tmp :=
   --     Id (1 .. 8) & Id (10 .. 13) & Id (15 .. 18) & Id (20 .. 23) &
   --     Id (25 .. 36);

   --    -- Convert pairs of hexa chars to single characters
   --    I_Tmp := 1;
   --    while I_Tmp < Tmp'Length loop
   --      Res (I_Res) := Byte'Value ("16#" & Tmp (I_Tmp .. I_Tmp + 1) & "#");
   --      I_Tmp       := @ + 2;
   --      I_Res       := @ + 1;
   --    end loop;
   --    return Res;
   --  end Squeeze;

   uuid1, uuid2, uuid3, uuid4 : Uuid.UUIDv7;

begin
   uuid1 := Uuid.Generate_UUIDv7;
   delay 1.0;
   uuid2 := Uuid.Generate_UUIDv7 (False);
   delay 1.0;
   uuid3 := Uuid.Generate_UUIDv7 (False);
   delay 1.0;
   uuid4 := Uuid.Generate_UUIDv7 (False);

   Ada.Assertions.Assert
     (uuid1.String < uuid2.String and then uuid2.String < uuid3.String
      and then uuid3.String < uuid4.String);

   Ada.Text_IO.Put_Line (uuid1.String);
   for I of uuid1.Binary loop
      Ada.Text_IO.Put (Uuid.Byte'Image (I));
   end loop;
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put_Line
     ("Length of Id: " & Integer'Image (uuid1.Binary'Length * Uuid.Byte'Size) &
      " bits");
end UUIDv7;
