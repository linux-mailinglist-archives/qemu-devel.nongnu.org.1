Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EB7DB88C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPpL-0002A7-31; Mon, 30 Oct 2023 06:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpE-0001zS-4f
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpB-0002bM-Qq
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698662929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24iwjS+5GLmWEBxiwHw+1ljmdyQ4g9AvDLJnkPc5KG0=;
 b=KfGrgKaPreDA4GG9MALiRpNT5hrbfbOk9tRqJzCSB9sg5CqS2vqzrSuS2c86XJoo51rkiO
 5poTMihxj186fxu0uXX5AFvPqR3EG8kK2Irw9hGvlT22nL4I4LzAGHNR8pGJ+QGb9Ukhic
 kDTgHNY8fkEOZD/arLKZwNQUa/3p21k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-_ZK9EKsZN4KDbRv4VOx5sw-1; Mon,
 30 Oct 2023 06:48:45 -0400
X-MC-Unique: _ZK9EKsZN4KDbRv4VOx5sw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC1353826D25;
 Mon, 30 Oct 2023 10:48:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56B5140C6EB9;
 Mon, 30 Oct 2023 10:48:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v7 09/23] ui/console: allow to override the default VC
Date: Mon, 30 Oct 2023 14:47:40 +0400
Message-ID: <20231030104755.124188-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231030104755.124188-1-marcandre.lureau@redhat.com>
References: <20231030104755.124188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index db4d5ee79a..86dd2dce28 100644
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


