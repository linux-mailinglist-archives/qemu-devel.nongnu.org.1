Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30B7E1B12
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:24:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztxz-0001ra-70; Mon, 06 Nov 2023 02:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxq-0001kA-9l
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxo-0006Lj-Fg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFWiW+q7/NUsYxRAkT/uCzkDHbVVeqZ11g2tKjRCj84=;
 b=N8c/6Jjsqato8Hn3ryJeIUaapn67dxASMIX74sg+YbKlorZXs5QGpos3vSqDRz2jhDNy5e
 l6NhKN/4bl9x4PzDd4cDz8fT0eTUGFSlfvbQxcYAMo4kOAO1NaW6EM/PtkWcXcNcTC/Bgy
 7MS5O9B+8CzbvL8hWUB3uzEy+3VrF70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-z9ixZ4p1Nueo6SuA74XIgQ-1; Mon, 06 Nov 2023 02:23:51 -0500
X-MC-Unique: z9ixZ4p1Nueo6SuA74XIgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ECC3185A780;
 Mon,  6 Nov 2023 07:23:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C26B10102;
 Mon,  6 Nov 2023 07:23:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/23] vl: move display early init before default devices
Date: Mon,  6 Nov 2023 11:22:57 +0400
Message-ID: <20231106072313.1742543-9-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The next commit needs to have the display registered itself before
creating the default VCs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 system/vl.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index e9819408df..cf46e438cc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1352,6 +1352,23 @@ static void qemu_disable_default_devices(void)
     }
 }
 
+static void qemu_setup_display(void)
+{
+    if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
+        if (!qemu_display_find_default(&dpy)) {
+            dpy.type = DISPLAY_TYPE_NONE;
+#if defined(CONFIG_VNC)
+            vnc_parse("localhost:0,to=99,id=default");
+#endif
+        }
+    }
+    if (dpy.type == DISPLAY_TYPE_DEFAULT) {
+        dpy.type = DISPLAY_TYPE_NONE;
+    }
+
+    qemu_display_early_init(&dpy);
+}
+
 static void qemu_create_default_devices(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
@@ -1401,18 +1418,6 @@ static void qemu_create_default_devices(void)
 #endif
     }
 
-    if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
-        if (!qemu_display_find_default(&dpy)) {
-            dpy.type = DISPLAY_TYPE_NONE;
-#if defined(CONFIG_VNC)
-            vnc_parse("localhost:0,to=99,id=default");
-#endif
-        }
-    }
-    if (dpy.type == DISPLAY_TYPE_DEFAULT) {
-        dpy.type = DISPLAY_TYPE_NONE;
-    }
-
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
         vga_model = get_default_vga_model(machine_class);
@@ -1937,7 +1942,6 @@ static void qemu_create_early_backends(void)
                      "ignoring option");
     }
 
-    qemu_display_early_init(&dpy);
     qemu_console_early_init();
 
     if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
@@ -3666,6 +3670,7 @@ void qemu_init(int argc, char **argv)
     suspend_mux_open();
 
     qemu_disable_default_devices();
+    qemu_setup_display();
     qemu_create_default_devices();
     qemu_create_early_backends();
 
-- 
2.41.0


