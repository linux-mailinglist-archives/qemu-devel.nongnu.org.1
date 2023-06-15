Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A996F73131E
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9iwK-0007Xe-JN; Thu, 15 Jun 2023 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1q9iwH-0007XI-Lp
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1q9iwF-0008K3-Hs
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686820002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74/IG7jUDay9IkqYNIE3O/U5/E1Q16v5KZLTi3durt0=;
 b=i2yElWCwNIcOnHXaGkyATxRpfiAKGebtbupEZ+/Q505vX4B9gfjSYbeFNedD2iJGW3ynlL
 +IWa8O2QDyszftRlcZ3I46aJgC2qzDZmjkIGv3doeT+huDTc1wWtnQgvCwCtyNeqaqpn//
 QK5i52ej2HFHZZT8PAwx+Z/AaQpIlQg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-pMDi2Q28N0WYA1yMfsBERg-1; Thu, 15 Jun 2023 05:06:40 -0400
X-MC-Unique: pMDi2Q28N0WYA1yMfsBERg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D9003806061
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 09:06:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9667C40D1B60;
 Thu, 15 Jun 2023 09:06:39 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bilal Elmoussaoui <belmouss@redhat.com>
Subject: [PATCH v2 2/2] ui/dbus: Expose a touch device interface
Date: Thu, 15 Jun 2023 11:06:35 +0200
Message-Id: <20230615090635.160734-2-belmouss@redhat.com>
In-Reply-To: <20230615090635.160734-1-belmouss@redhat.com>
References: <20230615090635.160734-1-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

So that clients making use of the DBus backend could
send touch events through the new org.qemu.Display1.Touch
interface

Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
---
 ui/dbus-console.c    | 59 +++++++++++++++++++++++++++++++++++++++++++-
 ui/dbus-display1.xml | 45 +++++++++++++++++++++++++++++++--
 ui/trace-events      |  1 +
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index f77bc49..7722f39 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -32,6 +32,8 @@
 
 #include "dbus.h"
 
+static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
+
 struct _DBusDisplayConsole {
     GDBusObjectSkeleton parent_instance;
     DisplayChangeListener dcl;
@@ -44,6 +46,7 @@ struct _DBusDisplayConsole {
     QKbdState *kbd;
 
     QemuDBusDisplay1Mouse *iface_mouse;
+    QemuDBusDisplay1Touch *iface_touch;
     gboolean last_set;
     guint last_x;
     guint last_y;
@@ -345,6 +348,46 @@ dbus_mouse_rel_motion(DBusDisplayConsole *ddc,
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+static gboolean
+dbus_touch_send_event(DBusDisplayConsole *ddc,
+                      GDBusMethodInvocation *invocation,
+                      guint kind, uint64_t num_slot,
+                      double x, double y)
+{
+    Error *error = NULL;
+    int width, height;
+    trace_dbus_touch_send_event(kind, num_slot, x, y);
+
+    if (kind != INPUT_MULTI_TOUCH_TYPE_BEGIN &&
+        kind != INPUT_MULTI_TOUCH_TYPE_UPDATE &&
+        kind != INPUT_MULTI_TOUCH_TYPE_CANCEL &&
+        kind != INPUT_MULTI_TOUCH_TYPE_END)
+    {
+        g_dbus_method_invocation_return_error(
+            invocation, DBUS_DISPLAY_ERROR,
+            DBUS_DISPLAY_ERROR_INVALID,
+            "Invalid touch event kind");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+    width = qemu_console_get_width(ddc->dcl.con, 0);
+    height = qemu_console_get_height(ddc->dcl.con, 0);
+
+    console_handle_touch_event(ddc->dcl.con, touch_slots,
+                               num_slot, width, height,
+                               x, y, kind, &error);
+    if (error != NULL) {
+        g_dbus_method_invocation_return_error(
+            invocation, DBUS_DISPLAY_ERROR,
+            DBUS_DISPLAY_ERROR_INVALID,
+            error_get_pretty(error), NULL);
+        error_free(error);
+    } else {
+        qemu_dbus_display1_touch_complete_send_event(ddc->iface_touch,
+                                                     invocation);
+    }
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
 static gboolean
 dbus_mouse_set_pos(DBusDisplayConsole *ddc,
                    GDBusMethodInvocation *invocation,
@@ -440,7 +483,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     g_autofree char *label = NULL;
     char device_addr[256] = "";
     DBusDisplayConsole *ddc;
-    int idx;
+    int idx, i;
 
     assert(display);
     assert(con);
@@ -495,6 +538,20 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
         G_DBUS_INTERFACE_SKELETON(ddc->iface_mouse));
 
+    ddc->iface_touch = qemu_dbus_display1_touch_skeleton_new();
+    g_object_connect(ddc->iface_touch,
+        "swapped-signal::handle-send-event", dbus_touch_send_event, ddc,
+        NULL);
+    qemu_dbus_display1_touch_set_max_slots(ddc->iface_touch,
+                                           INPUT_EVENT_SLOTS_MAX);
+    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
+        G_DBUS_INTERFACE_SKELETON(ddc->iface_touch));
+
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
+        struct touch_slot *slot = &touch_slots[i];
+        slot->tracking_id = -1;
+    }
+
     register_displaychangelistener(&ddc->dcl);
     ddc->mouse_mode_notifier.notify = dbus_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index c3b2293..a98cfd1 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -39,8 +39,9 @@
       "Text" (see :dbus:prop:`Type` and other properties).
 
       Interactions with a console may be done with
-      :dbus:iface:`org.qemu.Display1.Keyboard` and
-      :dbus:iface:`org.qemu.Display1.Mouse` interfaces when available.
+      :dbus:iface:`org.qemu.Display1.Keyboard`,
+      :dbus:iface:`org.qemu.Display1.Mouse` and
+      :dbus:iface:`org.qemu.Display1.Touch` interfaces when available.
   -->
   <interface name="org.qemu.Display1.Console">
     <!--
@@ -236,6 +237,46 @@
     <property name="IsAbsolute" type="b" access="read"/>
   </interface>
 
+  <!--
+      org.qemu.Display1.Touch:
+
+      This interface in implemented on ``/org/qemu/Display1/Console_$id`` (see
+      :dbus:iface:`~org.qemu.Display1.Console` documentation).
+
+      .. _dbus-kind-values:
+
+      **Kind values**::
+
+        Begin       = 0
+        Update      = 1
+        End         = 2
+        Cancel      = 3
+  -->
+  <interface name="org.qemu.Display1.Touch">
+    <!--
+        SendEvent:
+        @kind: The touch event kind
+        @num_slot: The slot number.
+        @x: The x coordinates.
+        @y: The y coordinates.
+
+        Send a touch gesture event.
+    -->
+    <method name="SendEvent">
+      <arg type="u" name="kind" direction="in"/>
+      <arg type="t" name="num_slot" direction="in"/>
+      <arg type="d" name="x" direction="in"/>
+      <arg type="d" name="y" direction="in"/>
+    </method>
+
+    <!--
+        MaxSlots:
+
+        The maximum number of slots.
+    -->
+    <property name="MaxSlots" type="i" access="read"/>
+  </interface>
+
   <!--
       org.qemu.Display1.Listener:
 
diff --git a/ui/trace-events b/ui/trace-events
index 6747361..138a09c 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -154,6 +154,7 @@ dbus_mouse_press(unsigned int button) "button %u"
 dbus_mouse_release(unsigned int button) "button %u"
 dbus_mouse_set_pos(unsigned int x, unsigned int y) "x=%u, y=%u"
 dbus_mouse_rel_motion(int dx, int dy) "dx=%d, dy=%d"
+dbus_touch_send_event(unsigned int kind, uint32_t num_slot, uint32_t x, uint32_t y) "kind=%u, num_slot=%u, x=%d, y=%d"
 dbus_update(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
 dbus_clipboard_grab_failed(void) ""
 dbus_clipboard_register(const char *bus_name) "peer %s"
-- 
2.40.1


