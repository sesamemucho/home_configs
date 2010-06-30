#!/usr/bin/env python

""" Simple dialog popup example similar to the GTK+ Tutorials one """

import gtk
import sys

mins = sys.argv[1]
text = ' '.join(sys.argv[2:])
dialog = gtk.MessageDialog(None,
                           gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                           # gtk.MESSAGE_INFO, gtk.BUTTONS_OK,
                           gtk.MESSAGE_INFO, gtk.BUTTONS_NONE, # Make it really annoying
                           "Appt in %s mins: %s" % (mins, text))
dialog.run()
dialog.destroy()
