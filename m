Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDFB72417F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 13:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VK5-0000KO-4s; Tue, 06 Jun 2023 07:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VK4-0000KG-4E
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJz-0005st-9s
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRfugJB+FFIULsci+7C3+z0gvZ1ISZSR/ACtM6IdXq0=;
 b=U++AU0h5xd851fOpfXtY5c2NcCT4qEBCkcbrmPCfTnkDOfcpo3R3BAYkgONheg55LdK0Bx
 8ny87gx7QYp0y/roLw+0i0A+kAWBLOmSVIE1IPe12+KfkEtRGQXaTMMXT9Yox8YFb9EIPi
 JJUJUNUclkM+UY1ChU5gEQX6+mmhOa8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-ilNhkDE0NuO-4egP_OZoDw-1; Tue, 06 Jun 2023 07:57:53 -0400
X-MC-Unique: ilNhkDE0NuO-4egP_OZoDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D82FD3C0CEED
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:57:52 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A522B9E8B;
 Tue,  6 Jun 2023 11:57:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 08/21] ui/dbus: introduce "Interfaces" properties
Date: Tue,  6 Jun 2023 15:56:45 +0400
Message-Id: <20230606115658.677673-9-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 ui/dbus-console.c    |   6 +++
 ui/dbus-display1.xml | 118 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index f0a060dc81..2f4d3439d1 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -494,6 +494,11 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     char device_addr[256] = "";
     DBusDisplayConsole *ddc;
     int idx;
+    const char *interfaces[] = {
+        "org.qemu.Display1.Keyboard",
+        "org.qemu.Display1.Mouse",
+        NULL
+    };
 
     assert(display);
     assert(con);
@@ -518,6 +523,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "width", qemu_console_get_width(con, 0),
         "height", qemu_console_get_height(con, 0),
         "device-address", device_addr,
+        "interfaces", interfaces,
         NULL);
     g_object_connect(ddc->iface,
         "swapped-signal::handle-register-listener",
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 80eae363f0..2c4acce593 100644
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
@@ -126,12 +140,27 @@
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
@@ -170,7 +199,8 @@
   <!--
       org.qemu.Display1.Mouse:
 
-      This interface in implemented on ``/org/qemu/Display1/Console_$id`` (see
+      This interface is optionally implemented on
+      ``/org/qemu/Display1/Console_$id`` (see
       :dbus:iface:`~org.qemu.Display1.Console` documentation).
 
       .. _dbus-button-values:
@@ -384,6 +414,20 @@
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
@@ -481,6 +525,20 @@
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
@@ -530,6 +588,20 @@
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
@@ -616,6 +688,20 @@
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
@@ -704,6 +790,20 @@
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
@@ -785,5 +885,19 @@
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
2.40.1


