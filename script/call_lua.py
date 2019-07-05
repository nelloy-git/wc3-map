import lupa
lua = lupa.LuaRuntime(unpack_returned_tuples=True)

from luaparser import ast


lua_compiletime = \
    '''
    compiletime_count = 0
    compiletime_results = {}

    function compiletime(body)
        if type(body) == \'function\' then
            compiletime_results[compiletime_count + 1] = body()
        else
            compiletime_results[compiletime_count + 1] = body
        end
        compiletime_count = compiletime_count + 1
    end
    '''

lua_require = \
    '''
    function require(module)
        module = module:gsub(\'%.\', \'_\')
        local func = _G[module..\'_return\']
        if func == nil then
            return nil
        end
        return func()
    end
    '''


def init_compiletime():
    lua.execute(lua_compiletime)

def load_enviroment(content):
    try:
        lua.execute(content)
    except RuntimeError as err:
        print('RuntimeError: ', err)

def lua_to_ast(val, val_type):
    if val_type == 'nil':
        return ast.Nil()
    if val_type == 'number':
        return ast.Number(val)
    if val_type == 'string':
        return ast.String(val)
    if val_type == 'table':
        fields = []
        for field_name in val:
            field_val = lua_to_ast(val[field_name], lua.globals().type(val[field_name]))
            field = ast.Field(ast.Name(field_name), field_val)
            fields.append(field)
        return ast.Table(fields)

    print('Error: compiletime function can return only nil, number, \
           string or table (with nils, numbers, strings and tables etc.).')
    return False

def get_compiletime_result(pos):
    lg = lua.globals()
    res = lg.compiletime_results[pos]
    res_type = lg.type(lg.compiletime_results[pos])
    return lua_to_ast(res, res_type)

def clear_enviroment():
    lua.execute('for k, v in pairs(_G) do v = nil end')