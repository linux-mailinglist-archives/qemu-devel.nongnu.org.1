Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBD7241A0
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VJM-00006c-OQ; Tue, 06 Jun 2023 07:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJL-00006O-Be
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJI-0005fo-GI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0bCb//3S1YWVtZD/CuiOvQZEwkrfi94l77q2yPHDB0=;
 b=cVlK4r+6AwR0uoREmdkJz0kreqZ8iptw7wbLlN06ZPzn348wcL5zapsx4vjZVNy8HRmAV3
 4Rs1k6B2AjHA1aYcjbVHmB1aO0uOj1MCEE4sgfVlO1JbDOC6yNIQ+QlFnE/2zpYa2Co6wb
 He6eQWquFOYsL/pVefaRDadm8Oy9yns=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-70nkkhxYOQSa6d1CusygRg-1; Tue, 06 Jun 2023 07:57:10 -0400
X-MC-Unique: 70nkkhxYOQSa6d1CusygRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA8F282CCA7
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:57:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F942166B25;
 Tue,  6 Jun 2023 11:57:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 02/21] ui/egl: fix make_context_current() callback return value
Date: Tue,  6 Jun 2023 15:56:39 +0400
Message-Id: <20230606115658.677673-3-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 ui/egl-context.c | 10 ++++++++--
 ui/gtk-egl.c     |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

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
index 19130041bc..f8b5901ce9 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -368,6 +368,11 @@ int gd_egl_make_current(DisplayGLCtx *dgc,
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
2.40.1


