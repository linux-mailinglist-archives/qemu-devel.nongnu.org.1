Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2E73FC74
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M0-000064-OP; Tue, 27 Jun 2023 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ln-0008Ve-Qk
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ll-00075e-OI
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dfamq97zDHWgWJoUOttRD4ntjk4FlCHAaw04hrxqgKs=;
 b=iHb/KxLdCO5Hu1u6kP1R4mocr1Z9n9coRbTd9bysjKIa+8f0Xf2kJu6PuqabtM4k01kzFm
 S0vSEZv7DbQe6jTklotRnZQ+H6MvyuongSZT1206WbKQ5ZT4yDmL5PdUU8UrnRUCLRdpb5
 In8nscVe9yBOHHbGBGZg67qgBdnOjTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-wvPy7lcGOMWGepKGTPDMdg-1; Tue, 27 Jun 2023 09:03:08 -0400
X-MC-Unique: wvPy7lcGOMWGepKGTPDMdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C27185A78F;
 Tue, 27 Jun 2023 13:03:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5169740C6F5A;
 Tue, 27 Jun 2023 13:03:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/33] ui/egl: fix make_context_current() callback return value
Date: Tue, 27 Jun 2023 15:02:11 +0200
Message-ID: <20230627130231.1614896-15-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

eglMakeCurrent() returns 1/EGL_TRUE on success. This is not what the
callback expects, where 0 indicates success.

While at it, print the EGL error to ease debugging.

As with virgl_renderer_callbacks, the return value is now checked since
version >= 4:
https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/7f09e6bf0c6ceea6727bd0049781256a28cab0e5

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-3-marcandre.lureau@redhat.com>
---
 ui/egl-context.c | 10 ++++++++--
 ui/gtk-egl.c     | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/ui/egl-context.c b/ui/egl-context.c
index eb5f520fc4..9e0df466f3 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "ui/egl-context.h"
 
 QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
@@ -32,6 +33,11 @@ void qemu_egl_destroy_context(DisplayGLCtx *dgc, QEMUGLContext ctx)
 int qemu_egl_make_context_current(DisplayGLCtx *dgc,
                                   QEMUGLContext ctx)
 {
-   return eglMakeCurrent(qemu_egl_display,
-                         EGL_NO_SURFACE, EGL_NO_SURFACE, ctx);
+   if (!eglMakeCurrent(qemu_egl_display,
+                       EGL_NO_SURFACE, EGL_NO_SURFACE, ctx)) {
+        error_report("egl: eglMakeCurrent failed: %s", qemu_egl_get_error_string());
+        return -1;
+   }
+
+   return 0;
 }
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index e99e3b0d8c..64dc0eeec8 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 
 #include "trace.h"
 
@@ -369,6 +370,11 @@ int gd_egl_make_current(DisplayGLCtx *dgc,
 {
     VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
 
-    return eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                          vc->gfx.esurface, ctx);
+    if (!eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                        vc->gfx.esurface, ctx)) {
+        error_report("egl: eglMakeCurrent failed: %s", qemu_egl_get_error_string());
+        return -1;
+    }
+
+    return 0;
 }
-- 
2.41.0


