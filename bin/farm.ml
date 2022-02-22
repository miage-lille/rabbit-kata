open Amqp_client_lwt

(* Helpers for Lwt *)
module LwtSyntax = struct
  let ( let* ) = Lwt.bind
end

module RabbitFarm = struct
  type rabbit_name = string
  type health = int
  type t = (rabbit_name, health) Hashtbl.t

  let to_json (rf : t) : Yojson.Safe.t =
    Hashtbl.fold
      (fun k v (acc : Yojson.Safe.t) ->
        match acc with
        | `List l ->
          `List (`Assoc [("name", `String k); ("health", `Int v)] :: l)
        | _ -> `List []
        (* unreachable but mandatory for pattern exhaustivity *))
      rf (`List [])
end

let handler farm m (h, s) =
  let open LwtSyntax in
  let () = print_endline "Parse message here" (* TODO *) in
  let* () = Lwt_mutex.lock m in
  let () = print_endline "Process msg here" (* TODO *) in
  let _ = Lwt_mutex.unlock m in
  Lwt.return (h, s)

let host = "" (* TODO *)

let credentials = ("", "") (* TODO *)

let virtual_host = "" (* TODO *)

let run handler () =
  let open LwtSyntax in
  (* let* connection = get_connection () in *)
  (* TODO *)
  let _ = Dream.log "AMQP Connection started" in
  (* let* channel = get_channel () *)
  (* TODO *)
  let _ = Dream.log "AMQP Channel opened" in
  (* let* queue = get_queue () in *)
  (* TODO *)
  let _ = Dream.log "AMQP Listening for requests" in
  Lwt.return_unit
(* TODO *)

let () =
  let farm : RabbitFarm.t = Hashtbl.create 10 in
  let m = Lwt_mutex.create () in
  let () =
    print_endline
      "Here call function that decrease rabbit feed units every 10sec"
    (* TODO *) in
  let _ = run (handler farm m) () in
  ()
