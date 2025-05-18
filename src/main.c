// #include <stdio.h>
#include "mongoose.h"

#define da_append(da, e) \
    do { \
        if (da.count >= da.capacity) { \
            if (da.capacity == 0) da.capacity = 256; \
            else da.capacity *= 2; \
            da.items = realloc(da.items, da.capacity*sizeof(*da.items)); \
        }\
        da.items[da.count++] = e;\
    } while (0) \


char tmp_buf[50000];
struct mg_str clipboard = {0};

static void fn(struct mg_connection *c, int ev, void *ev_data) {
    if (ev == MG_EV_HTTP_MSG) {
        struct mg_http_message *hm = (struct mg_http_message *) ev_data;

        if (mg_match(hm->uri, mg_str("/set"), NULL)) {
            mg_snprintf(tmp_buf,sizeof(tmp_buf),"%s", hm->body);
            clipboard = mg_str(tmp_buf);

            mg_http_reply(c, 200, "Content-Type: application/json\r\n", "{%m: %m}", MG_ESC("result"), MG_ESC("success"));
        } else {
            mg_http_reply(c, 200, "Content-Type: text/plain\r\n", "%s", clipboard);
        }
    }
}

int main() {
    struct mg_mgr mgr;
    mg_mgr_init(&mgr);
    mg_http_listen(&mgr, "http://0.0.0.0:5000", fn, NULL);
    for (;;) {
        mg_mgr_poll(&mgr, 1000);
    }
    return 0;
}
