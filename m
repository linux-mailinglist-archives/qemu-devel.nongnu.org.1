Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5B7E3907
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:25:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J83-0007qm-LD; Tue, 07 Nov 2023 05:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0J7x-0007e2-Eq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0J7v-0003ZX-PF
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmV56O8rUuNhsZEmD3/vWvetTBu+YFNXX7Trndub2hs=;
 b=bqchg6FaeoXKZE+ZUFyCLM2Lh43iX2LwW7fv/ZK85xQZOPAqB1kTAUuc+IRTf5BYtEM/T0
 r3oPyZNzUxRuopmuTwcZbL09Xx6c0CaVm3G56KVkHQG9Sih3Nt0OGQgEg8t9swNvSCsc8O
 Rh4IWZ+lzg9ZXS8mlWoJoqlC20pfglg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-QzcSYcw7PpGgHb6Kt8j0ng-1; Tue, 07 Nov 2023 05:16:04 -0500
X-MC-Unique: QzcSYcw7PpGgHb6Kt8j0ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2EE88556E8;
 Tue,  7 Nov 2023 10:16:04 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BCBD40C6EB9;
 Tue,  7 Nov 2023 10:16:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 09/25] ui/console: allow to override the default VC
Date: Tue,  7 Nov 2023 14:15:07 +0400
Message-ID: <20231107101524.2993389-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


