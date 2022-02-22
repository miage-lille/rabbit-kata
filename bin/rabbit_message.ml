type t = {
  name : string;
  action : string;
}
[@@deriving yojson]

let make name action = { name; action }
let of_json = t_of_yojson
let to_json = yojson_of_t
