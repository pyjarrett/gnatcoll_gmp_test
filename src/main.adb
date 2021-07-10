with GNATCOLL.GMP.Lib;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C.Strings;
with Interfaces.C_Streams;

procedure Main is
   use GNATCOLL.GMP.Lib;

   var_t, var_a, var_b : aliased mpz_t;

   -- User's choice of whether they want to use variable'Access or
   -- a nice alias.
   type mpz_access is access all mpz_t;
   t : mpz_access := var_t'Access;
   a : mpz_access := var_a'Access;
   b : mpz_access := var_b'Access;

   Sample_String : Interfaces.C.Strings.chars_ptr;

   -- Need operators visible for /=
   use type GNATCOLL.GMP.Int;
   use type Interfaces.C.size_t;

   procedure print (var : mpz_access) is
   begin
      if mpz_out_str (Interfaces.C_Streams.stdout, 10, var) = 0 then
         Put_Line (Standard_Error, "Failed to write to stdout.");
      end if;
      New_Line;
   end print;
begin
   mpz_init (t);
   mpz_init (a);
   mpz_init (b);
   mpz_set_ui (t, 2);

   Sample_String := Interfaces.C.Strings.New_String ("1234");
   if mpz_set_str (t, Sample_String, base => 10) /= 0 then
      Ada.Text_IO.Put_Line ("Assignment to T failed.");
   end if;
   print (t);

   mpz_set_ui (a, 3);
   mpz_set_ui (b, 4);
   mpz_add (t, a, b);

   Interfaces.C.Strings.Free (Sample_String);

   print (t);
   print (a);
   print (b);
end Main;
