pragma Ada_2022;

with Ada.Numerics.Float_Random;
with Ada.Calendar.Conversions;
with Interfaces.C;

use Ada;

package body Uuid is
   -- Generate_UUIDv7 always produces a readable version of UUIDv7 as a 36-character string
   -- and, if requested, a binary version of UUIDv7 as an array of 16 bytes.
   function Generate_UUIDv7 (Binary : Boolean := True) return UUIDv7 is
      use Interfaces.C;
      package Conversions renames Ada.Calendar.Conversions;
      subtype LLI is Long_Long_Integer;

      UUID : UUIDv7 := (Binary => [others => 0], String => [others => '-']);
      Now            : constant Calendar.Time := Calendar.Clock;
      Time_In_Millis : LLI := LLI (Conversions.To_Unix_Time (Now) * 1_000);
      Time_Hex       : String (1 .. 12);
      Tmp            : String (1 .. 32);   -- UUIDv7_Str'Length - 4
      I_Tmp, I_Bin   : Positive               := 1;
   begin
      --  Convert time to hex string
      for I in reverse 1 .. 12 loop
         Time_Hex (I)   := To_Hex (Integer (Time_In_Millis mod 16));
         Time_In_Millis := @ / 16;
      end loop;

      --  First, initialize the String field of UUID
      --  Set TimeStamp
      UUID.String (1 .. 8)   := Time_Hex (1 .. 8);
      UUID.String (10 .. 13) := Time_Hex (9 .. 12);

      --  Set version: 7
      UUID.String (15) := '7';

      --  Set rand_a
      for I in 16 .. 18 loop
         UUID.String (I) := Random_Hex;
      end loop;

      --  Set variant: 8
      UUID.String (19 .. 20) := "-8";

      --  Set rand_b
      for I in 21 .. 23 loop
         UUID.String (I) := Random_Hex;
      end loop;

      --  Fill remaining rand_b
      for I in 25 .. 36 loop
         UUID.String (I) := Random_Hex;
      end loop;

      -- Then, if requested, initialize the Binary field of UUID
      if Binary then
         -- Remove the - characters
         Tmp   :=
           UUID.String (1 .. 8) & UUID.String (10 .. 13) &
           UUID.String (15 .. 18) & UUID.String (20 .. 23) &
           UUID.String (25 .. 36);
         -- Then, convert pairs of hexa chars to single characters
         I_Tmp := 1;
         while I_Tmp < Tmp'Length loop
            UUID.Binary (I_Bin) :=
              Byte'Value ("16#" & Tmp (I_Tmp .. I_Tmp + 1) & "#");
            I_Tmp               := @ + 2;
            I_Bin               := @ + 1;
         end loop;
      end if;
      return UUID;
   end Generate_UUIDv7;

   function To_Hex (Value : Integer) return Character is
      Hex_Chars : constant array (0 .. 15) of Character := "0123456789abcdef";
   begin
      if Value < 0 or else Value > 15 then
         raise Constraint_Error with "Value must be between 0 and 15";
      end if;
      return Hex_Chars (Value);
   end To_Hex;

   function Random_Hex return Character is
      package Rand renames Numerics.Float_Random;

      Gen          : Rand.Generator;
      Random_Value : Float;
   begin
      Rand.Reset (Gen);
      Random_Value := Rand.Random (Gen);
      return To_Hex (Integer (15.0 * Random_Value));
   end Random_Hex;

end Uuid;
