Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73D7E57FF
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 14:38:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ikM-0004Xh-Hg; Wed, 08 Nov 2023 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0ikL-0004XY-8U
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0ikJ-0002on-5E
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699450645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uJzNJoOqDMqfvzyrIYQYNxE/gbq1OD1wy3miEHjhrmI=;
 b=cWmvbEEBxf3Y2Cm+qnmfYaikJDdZHHfkNGAVFLs6qSndsB7vh/4oc7zNrJdKUScX5ovP5x
 m4fT0LDdB6ZC+lKPMFNLeUAVhOsIOnZ5mNsAduCHY+b1CWNMGpnV8nBu0ZkqutWHPJDMiu
 T0z0y29Q1wWoFbSqFZpRbTRmDgOPn6A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-wegBcMJDOTq_H-6-Fk-n8Q-1; Wed,
 08 Nov 2023 08:37:23 -0500
X-MC-Unique: wegBcMJDOTq_H-6-Fk-n8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 292901C05136
 for <qemu-devel@nongnu.org>; Wed,  8 Nov 2023 13:37:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD3B2026D68;
 Wed,  8 Nov 2023 13:37:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, gmaglione@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui/console: fix default VC when there are no display
Date: Wed,  8 Nov 2023 17:37:19 +0400
Message-ID: <20231108133719.113217-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When display is "none", we may still have remote displays (I think it
would be simpler if VNC/Spice were regular display btw). Return the
default VC then, and set them up to fix a regression when using remote
display and it used the TTY instead.

Fixes: commit 1bec1cc0d ("ui/console: allow to override the default VC")
Reported-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c  |  4 +++-
 ui/console.c | 14 ++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index bd7fad770b..8c522a07da 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1359,6 +1359,7 @@ static void qemu_setup_display(void)
             dpy.type = DISPLAY_TYPE_NONE;
 #if defined(CONFIG_VNC)
             vnc_parse("localhost:0,to=99,id=default");
+            display_remote++;
 #endif
         }
     }
@@ -1391,7 +1392,8 @@ static void qemu_create_default_devices(void)
         }
     }
 
-    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO))) {
+    if (nographic ||
+        ((!display_remote || !vc) && !is_daemonized() && isatty(STDOUT_FILENO))) {
         if (default_parallel) {
             add_device_config(DEV_PARALLEL, "null");
         }
diff --git a/ui/console.c b/ui/console.c
index 8e688d3569..f08c8365b0 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1679,19 +1679,21 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
 
 const char *qemu_display_get_vc(DisplayOptions *opts)
 {
+#ifdef CONFIG_PIXMAN
+    const char *vc = "vc:80Cx24C";
+#else
+    const char *vc = NULL;
+#endif
+
     assert(opts->type < DISPLAY_TYPE__MAX);
     if (opts->type == DISPLAY_TYPE_NONE) {
-        return NULL;
+        return vc;
     }
     assert(dpys[opts->type] != NULL);
     if (dpys[opts->type]->vc) {
         return dpys[opts->type]->vc;
-    } else {
-#ifdef CONFIG_PIXMAN
-        return "vc:80Cx24C";
-#endif
     }
-    return NULL;
+    return vc;
 }
 
 void qemu_display_help(void)
-- 
2.41.0


