Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6779C73FC78
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M4-00008F-E4; Tue, 27 Jun 2023 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M0-00006R-7O
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lv-00079S-Pa
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Vzzn6tUFrjan4BZgfFPWCPjeNGkv0pevKvaUz08Xb4=;
 b=YKBWtxwQasSh/JFNBbRCkhRyXPOgYmXcqLwQ9vczam5++jgGNSl7RNwk/Pr7eRVNfUNKNz
 nvGwQFb21V/+sQxar1yJLvIrzw7iw8OwzRsdiWSoneGSL/dP3kY0Ai9tey5ldwyOlOKlfP
 tQjAY+Y0lnx8pEIjqkyeExQt0LZf+3o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-sRBmmjD_M-anMQ7lij5nXQ-1; Tue, 27 Jun 2023 09:03:18 -0400
X-MC-Unique: sRBmmjD_M-anMQ7lij5nXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51AFC3C1CB01;
 Tue, 27 Jun 2023 13:03:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87B70200A3AD;
 Tue, 27 Jun 2023 13:03:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 20/33] ui/dbus: introduce "Interfaces" properties
Date: Tue, 27 Jun 2023 15:02:17 +0200
Message-ID: <20230627130231.1614896-21-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This property is similar to ``org.freedesktop.DBus.Interfaces`` property
on the bus interface: it's an array of strings listing the extra
interfaces and capabilities available, in a convenient way.

Most interfaces are implicit, as they are required. For
``org/qemu/Display1_$id``, we can list the Keyboard And Mouse
interfaces. Those could be optional.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-9-marcandre.lureau@redhat.com>
---
 ui/dbus-console.c    |   7 +++
 ui/dbus-display1.xml | 118 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 4a1c1fb55e..aaa9d3b0b3 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -537,6 +537,12 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     char device_addr[256] = "";
     DBusDisplayConsole *ddc;
     int idx, i;
+    const char *interfaces[] = {
+        "org.qemu.Display1.Keyboard",
+        "org.qemu.Display1.Mouse",
+        "org.qemu.Display1.MultiTouch",
+        NULL
+    };
 
     assert(display);
     assert(con);
@@ -561,6 +567,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "width", qemu_console_get_width(con, 0),
         "height", qemu_console_get_height(con, 0),
         "device-address", device_addr,
+        "interfaces", interfaces,
         NULL);
     g_object_connect(ddc->iface,
         "swapped-signal::handle-register-listener",
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index cd596f774e..06e8779c04 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -26,6 +26,20 @@
         The list of consoles available on ``/org/qemu/Display1/Console_$id``.
     -->
     <property name="ConsoleIDs" type="au" access="read"/>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/VM object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -127,12 +141,27 @@
         The device address (ex: "pci/0000/02.0").
     -->
     <property name="DeviceAddress" type="s" access="read"/>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        ``/org/qemu/Display1/Console_$id`` object, and can be used to detect the
+        capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
       org.qemu.Display1.Keyboard:
 
-      This interface in implemented on ``/org/qemu/Display1/Console_$id`` (see
+      This interface is optionally implemented on
+      ``/org/qemu/Display1/Console_$id`` (see
       :dbus:iface:`~org.qemu.Display1.Console`).
   -->
   <interface name="org.qemu.Display1.Keyboard">
@@ -171,7 +200,8 @@
   <!--
       org.qemu.Display1.Mouse:
 
-      This interface in implemented on ``/org/qemu/Display1/Console_$id`` (see
+      This interface is optionally implemented on
+      ``/org/qemu/Display1/Console_$id`` (see
       :dbus:iface:`~org.qemu.Display1.Console` documentation).
 
       .. _dbus-button-values:
@@ -425,6 +455,20 @@
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
     </method>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/Listener object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -522,6 +566,20 @@
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
     </method>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/Clipboard object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -571,6 +629,20 @@
       <arg type="h" name="listener" direction="in"/>
       <?endif?>
     </method>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/Audio object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -657,6 +729,20 @@
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
     </method>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/AudioOutListener object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -745,6 +831,20 @@
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
     </method>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        /org/qemu/Display1/AudioInListener object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 
   <!--
@@ -826,5 +926,19 @@
         The D-Bus unique name of the registered handler.
     -->
     <property name="Owner" type="s" access="read"/>
+
+    <!--
+        Interfaces:
+
+        This property lists extra interfaces provided by the
+        ``/org/qemu/Display1/Chardev_$i`` object, and can be used to detect
+        the capabilities with which they are communicating.
+
+        Unlike the standard D-Bus Introspectable interface, querying this
+        property does not require parsing XML.
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="Interfaces" type="as" access="read"/>
   </interface>
 </node>
-- 
2.41.0


