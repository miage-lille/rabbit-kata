open Amqp_client_lwt

module LwtSyntax = struct
  let ( let* ) = Lwt.bind
end

let host = "" (* TODO *)

let credentials = ("", "") (* TODO *)

let virtual_host = "" (* TODO *)

let client : Rpc.Client.t option ref = ref None

(* let init_client () = let open LwtSyntax in let* connection = get_connection
   () in let* c = Rpc.Client.init ~id:"rpc-rabbit" connection in let _ = client
   := Some c in Lwt.return c *)
(* TODO *)

let from_request_to_name request =
  let open LwtSyntax in
  let* body = Dream.body request in
  Lwt.return body

let from_message (msg : Message.message option) =
  let open LwtSyntax in
  match msg with
  | None -> Lwt.return ""
  | Some (content, data) -> Lwt.return data

let run () =
  let open LwtSyntax in
  (* let* connection = get_connection () in *)
  (* TODO *)
  (* let* channel = get_channel () in let* queue = get_queue () in *)
  (* TODO *)
  Lwt.return_unit

let hello_handler _request =
  let open Yojson.Safe in
  Dream.json @@ to_string @@ `Assoc [("message", `String "hello world")]

let create_handler _request =
  let open Yojson.Safe in
  (* TODO *)
  Dream.json @@ to_string @@ `String "Not implemented"

let feed_handler _request =
  let open Yojson.Safe in
  (* TODO *)
  Dream.json @@ to_string @@ `String "Not implemented"

let () =
  let open LwtSyntax in
  (* let _ = init_client () in *)
  (* TODO *)
  let _ = run () in
  (* let () = all_rabbits_timer () in *)
  (* TODO *)
  Dream.run ~port:3001
  @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" hello_handler;
         Dream.post "/create" create_handler;
         Dream.put "/feed" feed_handler;
       ]
