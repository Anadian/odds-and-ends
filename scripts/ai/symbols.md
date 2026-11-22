`symbols.json` contains a list of symbols which need to be or have been renamed in the *.h and *.c files in the `src` and `include` directories.
`symbols.json` is something of a cumulative log chronicling renames across multiple invocations. Renames that have already been applied should be marked with an `"enabled": true` in their respective properties on `symbols.json` object. Entries described as "enabled" should be assumed to already be correctly implemented and can be ignore for this invocation.
Each symbol is specified using a dot-chain notation where "A" means a struct, subroutine, or enum and "A.b" a member of struct A, a parametre of subroutine A, or a field of enum A. Note: for member/param/field symbols, their "parent" part (preceding the dot) may refer to the parent's current symbols name or its original name.
- When changigng text for members, params, and fields: ONLY CHANGE THE TEXT FOR THE FIELDS IN THE PARENT STRUCT/SUBROUTINE/ENUM. 
- Never alter text of an include directives!
- Never change file names or paths.
- Never `git reset` or make destructive edits to Git without explicit user permission for each instance!
- Only change files in src and include!
- For each entry in the `symbols.json` object: 
    1. Rename symbols in the source code text in `src` and `include` to reflect the symbol name changes in `symbols.json`.
    2. Mark each newly renamed symbol as `enabled` in `symbols.json`.
    3. Add `declaredIn`, with the project relative path of the file in which symbol is declared, to the symbol entry in `symbols.json`.
    4. And, if different, `definedIn` with the file path of its definition.
- If you're unsure what any of this, or `symbols.json`, means or you believe you've found an input array in your instructions, ask the user for clarification/confirmation before making any destructive changes.
