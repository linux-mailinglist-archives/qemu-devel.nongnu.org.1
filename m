Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0E7A4AF0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEgH-0005s4-SS; Mon, 18 Sep 2023 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEgF-0005ol-6D
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEfv-0000Si-MA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695045150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAAq6oURv7/Ab7LozQ4fDXV1z0sRozSZjYnJISsyitc=;
 b=IvnjjKs+7sVzq0qwdat3NpB6EI3iHUM/rXzcTrVhJ4gKd4aKIvk06O1UNrs368PIh7gRR7
 2scPYCROFeDhwcyu3kuGpILTVLquF/iuvHHH+Myw3/t7JejivJA+zupOZeWp9K2RRQE/GA
 VfTa83md7fPbZ0u0JQtDfqcQmKGKU6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-x0cmA8F-PB6eOFysQE_Gwg-1; Mon, 18 Sep 2023 09:52:27 -0400
X-MC-Unique: x0cmA8F-PB6eOFysQE_Gwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33F4D85A5BA;
 Mon, 18 Sep 2023 13:52:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 117F92156701;
 Mon, 18 Sep 2023 13:52:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 04/18] ui/console: allow to override the default VC
Date: Mon, 18 Sep 2023 17:51:51 +0400
Message-ID: <20230918135206.2739222-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
default "vc:80Cx24C". For that, set the dpy.type just before creating
the default serial/parallel/monitor.

(the next patch makes it create a "null" backend by default if !PIXMAN)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  2 ++
 softmmu/vl.c         | 45 +++++++++++++++++++++++---------------------
 ui/console.c         | 14 ++++++++++++++
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 28882f15a5..08c0f0dc70 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -463,12 +463,14 @@ struct QemuDisplay {
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3db4fd2680..8850cd3121 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1361,6 +1361,23 @@ static void qemu_create_default_devices(void)
         }
     }
 
+#if defined(CONFIG_VNC)
+    if (!QTAILQ_EMPTY(&(qemu_find_opts("vnc")->head))) {
+        display_remote++;
+    }
+#endif
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
     if (nographic) {
         if (default_parallel)
             add_device_config(DEV_PARALLEL, "null");
@@ -1373,12 +1390,15 @@ static void qemu_create_default_devices(void)
                 monitor_parse("stdio", "readline", false);
         }
     } else {
-        if (default_serial)
-            add_device_config(DEV_SERIAL, "vc:80Cx24C");
+        const char *vc = qemu_display_get_vc(&dpy);
+
+        if (default_serial) {
+            add_device_config(DEV_SERIAL, vc);
+        }
         if (default_parallel)
-            add_device_config(DEV_PARALLEL, "vc:80Cx24C");
+            add_device_config(DEV_PARALLEL, vc);
         if (default_monitor)
-            monitor_parse("vc:80Cx24C", "readline", false);
+            monitor_parse(vc, "readline", false);
     }
 
     if (default_net) {
@@ -1389,23 +1409,6 @@ static void qemu_create_default_devices(void)
 #endif
     }
 
-#if defined(CONFIG_VNC)
-    if (!QTAILQ_EMPTY(&(qemu_find_opts("vnc")->head))) {
-        display_remote++;
-    }
-#endif
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
diff --git a/ui/console.c b/ui/console.c
index 4a4f19ed33..a38d24f075 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1677,6 +1677,20 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
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


