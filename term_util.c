#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <errno.h>

#include <lua.h>
#include <lauxlib.h>


int term_echo_off(lua_State *L) {
	struct termios flags;

	/* disabling echo */
	tcgetattr(fileno(stdin), &flags);
	flags.c_lflag &= ~ECHO;
	flags.c_lflag |= ECHONL;

	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
		lua_pushnil(L);
		lua_pushfstring(L, "tcsetattr: ", strerror(errno));
		return 2;
	}

	lua_pushboolean(L, 1);

	return 1;
}


int term_echo_on(lua_State *L) {
	struct termios flags;

	/* enabling echo */
	tcgetattr(fileno(stdin), &flags);
	flags.c_lflag |= ECHO;
	flags.c_lflag |= ECHONL;

	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
		lua_pushnil(L);
		lua_pushfstring(L, "tcsetattr: ", strerror(errno));
		return 2;
	}

	lua_pushboolean(L, 1);

	return 1;
}


struct luaL_Reg term_lib[] = {
	{ "echo_off", term_echo_off },
	{ "echo_on", term_echo_on },

	{ NULL, NULL }
};


int luaopen_term(lua_State *L) {
	luaL_newlib(L, term_lib);

	return 1;
}
