 #include <xcb/xcb.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>

 static xcb_atom_t intern_atom(xcb_connection_t *c, const char *name)
 {
 	xcb_atom_t result = 0;
 	xcb_intern_atom_reply_t *r = xcb_intern_atom_reply(c,
 			xcb_intern_atom(c, 0, strlen(name), name),
 			NULL);
 	if (r)
 		result = r->atom;
 	free(r);
 	return result;
 }

 static uint32_t get_workspace(xcb_connection_t *c, xcb_window_t root, xcb_atom_t atom)
 {
 	uint32_t result = 0;
 	xcb_get_property_reply_t *reply = xcb_get_property_reply(c,
 			xcb_get_property(c, 0, root, atom, XCB_ATOM_CARDINAL, 0, 42),
 			NULL);
 	if (reply && reply->format == 32 && reply->length > 0)
 		result = *(uint32_t *) xcb_get_property_value(reply);
 	free(reply);
 	return result;
 }

 int main()
 {
 	uint32_t workspace;
 	xcb_generic_event_t *event;
 	xcb_connection_t *c = xcb_connect(NULL, NULL);
 	xcb_screen_t *screen = xcb_setup_roots_iterator(xcb_get_setup(c)).data;
 	xcb_atom_t current_desktop = intern_atom(c, "_NET_CURRENT_DESKTOP");

 	xcb_change_window_attributes (c, screen->root, XCB_CW_EVENT_MASK, (uint32_t[]) { XCB_EVENT_MASK_PROPERTY_CHANGE });
 	workspace = get_workspace(c, screen->root, current_desktop);

 	xcb_flush(c);

 	printf("At startup, workspace is %d\n", (int) workspace);

 	while ((event = xcb_wait_for_event(c)) != NULL) {
 		if (event->response_type == XCB_PROPERTY_NOTIFY) {
 			xcb_property_notify_event_t *notify = (void *) event;
 			if (notify->window == screen->root && notify->atom == current_desktop) {
 				uint32_t new_workspace = get_workspace(c, screen->root, current_desktop);
 				if (new_workspace != workspace) {
 					workspace = new_workspace;
 					printf("Workspace changed to %d\n", (int) workspace);
 				}
 			}
 		}
 		free(event);
 	}

 	xcb_disconnect(c);
 	return 0;
 }
