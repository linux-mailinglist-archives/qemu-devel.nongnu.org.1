Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4B73FC72
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M2-00007r-GC; Tue, 27 Jun 2023 09:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ls-0008WI-1W
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lq-00076m-56
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blqbeSKSUUdSuR4PyNLv9oNBw1JreBJz//zqRGfFELw=;
 b=X9c345Ms80IjdUiZqteCbs56aTx6T8AdM2U0JhNcOf2n8Kr+/KKXw8f9tmgcpvEOaICcGt
 WHaZh5CnGZtiBUsPFvBEQxrFhWYGQxGpwXBNF70Dxu2FeDtczr3TZSftzJkLqB1xA9J25I
 S2S46mtHfHf0nsi8EtxnAl6FTvFGOHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-egyCEBFMMwiJhM8kOAbILw-1; Tue, 27 Jun 2023 09:03:13 -0400
X-MC-Unique: egyCEBFMMwiJhM8kOAbILw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31A048C7C25;
 Tue, 27 Jun 2023 13:02:59 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C78A340140F;
 Tue, 27 Jun 2023 13:02:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/33] ui/egl: export qemu_egl_get_error_string()
Date: Tue, 27 Jun 2023 15:02:10 +0200
Message-ID: <20230627130231.1614896-14-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

It will be used from other units.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-2-marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h |  2 ++
 ui/egl-helpers.c         | 12 +++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 53d953ddf4..2cf6633ad2 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -67,4 +67,6 @@ bool qemu_egl_has_dmabuf(void);
 
 bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp);
 
+const char *qemu_egl_get_error_string(void);
+
 #endif /* EGL_HELPERS_H */
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 60385c1f48..26d43e0213 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -28,8 +28,7 @@ DisplayGLMode qemu_egl_mode;
 
 /* ------------------------------------------------------------------ */
 
-#if defined(CONFIG_X11) || defined(CONFIG_GBM)
-static const char *egl_get_error_string(void)
+const char *qemu_egl_get_error_string(void)
 {
     EGLint error = eglGetError();
 
@@ -68,7 +67,6 @@ static const char *egl_get_error_string(void)
         return "Unknown EGL error";
     }
 }
-#endif
 
 static void egl_fb_delete_texture(egl_fb *fb)
 {
@@ -480,20 +478,20 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
 
     qemu_egl_display = qemu_egl_get_display(dpy, platform);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
-        error_report("egl: eglGetDisplay failed: %s", egl_get_error_string());
+        error_report("egl: eglGetDisplay failed: %s", qemu_egl_get_error_string());
         return -1;
     }
 
     b = eglInitialize(qemu_egl_display, &major, &minor);
     if (b == EGL_FALSE) {
-        error_report("egl: eglInitialize failed: %s", egl_get_error_string());
+        error_report("egl: eglInitialize failed: %s", qemu_egl_get_error_string());
         return -1;
     }
 
     b = eglBindAPI(gles ?  EGL_OPENGL_ES_API : EGL_OPENGL_API);
     if (b == EGL_FALSE) {
         error_report("egl: eglBindAPI failed (%s mode): %s",
-                     gles ? "gles" : "core", egl_get_error_string());
+                     gles ? "gles" : "core", qemu_egl_get_error_string());
         return -1;
     }
 
@@ -502,7 +500,7 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
                         &qemu_egl_config, 1, &n);
     if (b == EGL_FALSE || n != 1) {
         error_report("egl: eglChooseConfig failed (%s mode): %s",
-                     gles ? "gles" : "core", egl_get_error_string());
+                     gles ? "gles" : "core", qemu_egl_get_error_string());
         return -1;
     }
 
-- 
2.41.0


