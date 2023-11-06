Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F57E1DBF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:59:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwLl-0007Ai-9G; Mon, 06 Nov 2023 04:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLP-0006iJ-EK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLL-0008Q9-JG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699264586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmV56O8rUuNhsZEmD3/vWvetTBu+YFNXX7Trndub2hs=;
 b=dr7kzmLqGdmMBOl6j26kHhqfQWxAzogGC0B7X36J1Gi6uBzOcQoBtR/dQjSrRnFbfTWNIZ
 CSziLeTMEApo5t182jS8BSpvimUyhwAd0M6p3aXah2zxOy87m5L04tV7n8HkYFbK0ryBi2
 vt51dJw8vp7bPzTyuvCLtyIYhhsLhJU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-HhgKFJTDNsO7xY5ylfXoHQ-1; Mon,
 06 Nov 2023 04:56:21 -0500
X-MC-Unique: HhgKFJTDNsO7xY5ylfXoHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD69F3C0C490;
 Mon,  6 Nov 2023 09:56:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B83FCC1290F;
 Mon,  6 Nov 2023 09:56:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 09/24] ui/console: allow to override the default VC
Date: Mon,  6 Nov 2023 13:55:26 +0400
Message-ID: <20231106095542.1852973-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

If a display is backed by a specialized VC, allow to override the
default "vc:80Cx24C".

As suggested by Paolo, if the display doesn't implement a VC (get_vc()
returns NULL), use a fallback that will use a muxed console on stdio.

This changes the behaviour of "qemu -display none", to create a muxed
serial/monitor by default (on TTY & not daemonized).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/ui/console.h |  2 ++
 system/vl.c          | 27 +++++++++++++++++----------
 ui/console.c         | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index acb61a7f15..a4a49ffc64 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -462,12 +462,14 @@ struct QemuDisplay {
     DisplayType type;
     void (*early_init)(DisplayOptions *opts);
     void (*init)(DisplayState *ds, DisplayOptions *opts);
+    const char *vc;
 };
 
 void qemu_display_register(QemuDisplay *ui);
 bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
+const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
diff --git a/system/vl.c b/system/vl.c
index cf46e438cc..bd7fad770b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1372,6 +1372,7 @@ static void qemu_setup_display(void)
 static void qemu_create_default_devices(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
+    const char *vc = qemu_display_get_vc(&dpy);
 
     if (is_daemonized()) {
         /* According to documentation and historically, -nographic redirects
@@ -1390,24 +1391,30 @@ static void qemu_create_default_devices(void)
         }
     }
 
-    if (nographic) {
-        if (default_parallel)
+    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO))) {
+        if (default_parallel) {
             add_device_config(DEV_PARALLEL, "null");
+        }
         if (default_serial && default_monitor) {
             add_device_config(DEV_SERIAL, "mon:stdio");
         } else {
-            if (default_serial)
+            if (default_serial) {
                 add_device_config(DEV_SERIAL, "stdio");
-            if (default_monitor)
+            }
+            if (default_monitor) {
                 monitor_parse("stdio", "readline", false);
+            }
         }
     } else {
-        if (default_serial)
-            add_device_config(DEV_SERIAL, "vc:80Cx24C");
-        if (default_parallel)
-            add_device_config(DEV_PARALLEL, "vc:80Cx24C");
-        if (default_monitor)
-            monitor_parse("vc:80Cx24C", "readline", false);
+        if (default_serial) {
+            add_device_config(DEV_SERIAL, vc ?: "null");
+        }
+        if (default_parallel) {
+            add_device_config(DEV_PARALLEL, vc ?: "null");
+        }
+        if (default_monitor && vc) {
+            monitor_parse(vc, "readline", false);
+        }
     }
 
     if (default_net) {
diff --git a/ui/console.c b/ui/console.c
index 8ee66d10c5..a758ed62ad 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1675,6 +1675,20 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
     dpys[opts->type]->init(ds, opts);
 }
 
+const char *qemu_display_get_vc(DisplayOptions *opts)
+{
+    assert(opts->type < DISPLAY_TYPE__MAX);
+    if (opts->type == DISPLAY_TYPE_NONE) {
+        return NULL;
+    }
+    assert(dpys[opts->type] != NULL);
+    if (dpys[opts->type]->vc) {
+        return dpys[opts->type]->vc;
+    } else {
+        return "vc:80Cx24C";
+    }
+}
+
 void qemu_display_help(void)
 {
     int idx;
-- 
2.41.0


