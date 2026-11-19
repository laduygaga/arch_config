#!/usr/bin/env python3
import sys
import json

def extract_json_values(text: str) -> list[str]:
    values = []
    n = len(text)
    i = 0
    while i < n:
        char = text[i]
        if char in ("{", "["):
            end_char = "}" if char == "{" else "]"
            depth = 0
            in_string = False
            escape_next = False
            j = i
            while j < n:
                c = text[j]
                if escape_next:
                    escape_next = False
                elif c == "\\" and in_string:
                    escape_next = True
                elif c == '"':
                    in_string = not in_string
                elif not in_string:
                    if (char == "{" and c == "{") or (char == "[" and c == "["):
                        depth += 1
                    elif c == end_char:
                        depth -= 1
                        if depth == 0:
                            raw_val = text[i : j + 1]
                            values.append(raw_val)
                            i = j
                            break
                j += 1
            if j >= n:
                break
        i += 1
    return values

def main():
    input_text = sys.stdin.read()
    if not input_text:
        return

    raw_values = extract_json_values(input_text)
    minified_values = []
    for v in raw_values:
        try:
            parsed = json.loads(v)
            minified = json.dumps(parsed, separators=(",", ":"))
            minified_values.append(minified)
        except Exception:
            pass

    seen = set()
    unique = []
    for v in minified_values:
        if v not in seen:
            seen.add(v)
            unique.append(v)

    if unique:
        print("\n".join(unique))

if __name__ == "__main__":
    main()
