(* This example program generates _n_ SET commands
	 with random UUIDs for both the key and a single value.
	 It is ideal for piping through `redis-cli --pipe`
*)

let kvg () =
  let k = Core.Uuid.create () |> Core.Uuid.to_string in
  let v = Core.Uuid.create () |> Core.Uuid.to_string in
  [k;v]

let rec run n =
  if n == 0 then
    exit 0
  else
    Redis_protocol.Redis_command.build ~command:"SET" (kvg ())
      |> Redis_protocol.Resp.encode_exn
      |> Printf.printf "%s";
    run (n - 1)
;;

run ((Array.get Sys.argv 1) |> int_of_string) ;;
