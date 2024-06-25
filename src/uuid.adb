with Ada.Numerics.Float_Random;
with Ada.Calendar.Conversions;
with Interfaces.C;

package body Uuid is
   function Generate_UUIDv7 return UUIDv7 is
      use Interfaces.C;
      use Ada.Calendar;
      use Ada.Calendar.Conversions;

      subtype LLI is Long_Long_Integer;

      UUID           : UUIDv7        := (others => '0');
      Now            : constant Time := Clock;
      Time_In_Millis : LLI           := LLI (To_Unix_Time (Now) * 1_000);
      Time_Hex       : String (1 .. 12);
   begin
      --  Convert time to hex string
      for I in reverse 1 .. 12 loop
         Time_Hex (I)   := To_Hex (Integer (Time_In_Millis mod 16));
         Time_In_Millis := @ / 16;
      end loop;

      --  Fill in the UUID parts
      --  Set TimeStamp
      UUID (1 .. 8)   := Time_Hex (1 .. 8);
      UUID (9)        := '-';
      UUID (10 .. 13) := Time_Hex (9 .. 12);
      UUID (14)       := '-';

      --  Set version: 7
      UUID (15) := '7';

      --  Set rand_a
      for I in 16 .. 18 loop
         UUID (I) := Random_Hex;
      end loop;

      --  Set variant: 8
      UUID (19 .. 20) := "-8";

      --  Set rand_b
      for I in 21 .. 23 loop
         UUID (I) := Random_Hex;
      end loop;
      UUID (24) := '-';

      --  Fill remaining rand_b
      for I in 25 .. 36 loop
         UUID (I) := Random_Hex;
      end loop;

      return UUID;
   end Generate_UUIDv7;

   function To_Hex (Value : Integer) return Character is
      Hex_Chars : constant array (0 .. 15) of Character :=
        "0123456789abcdef";
   begin
      if Value < 0 or else Value > 15 then
         raise Constraint_Error with "Value must be between 0 and 15";
      end if;
      return Hex_Chars (Value);
   end To_Hex;
      
   function Random_Hex return Character is
      use Ada.Numerics.Float_Random;

      Gen          : Generator;
      Random_Value : Float;
   begin
      Reset (Gen);
      Random_Value := Random (Gen);
      return To_Hex (Integer (15.0 * Random_Value));
   end Random_Hex;

end Uuid;
