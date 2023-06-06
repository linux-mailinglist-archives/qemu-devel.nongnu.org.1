Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FC724190
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VKt-0001W0-DE; Tue, 06 Jun 2023 07:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKR-0000mC-34
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKO-0005w3-JU
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/sY44RWB9rTaWjpKipGVlF7w0jh7ExDt4ITjGoq9Cc=;
 b=PQ62kUzcQ6FX9+/hzyK31FO7TkBE1UYWXy34fMVx6FFdcWsmiiVp/M8NcWtVQq6pKyMtRe
 bUGZbgBGTlfZ+ZrUhFXFnVEkafspNy55x0jFXvYK0eOshqXgMah5C33iCru1JquaqR351B
 gRctYdtjaPivomcJyzpQtctc26TLyFA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-Xm8nlF5uP-KnhdCVtKRoig-1; Tue, 06 Jun 2023 07:58:17 -0400
X-MC-Unique: Xm8nlF5uP-KnhdCVtKRoig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 330091C01E82
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:58:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77AF11121314;
 Tue,  6 Jun 2023 11:58:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 14/21] ui: add egl_fb_read_rect()
Date: Tue,  6 Jun 2023 15:56:51 +0400
Message-Id: <20230606115658.677673-15-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
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

Similar to egl_fb_read(), same limitations, but with extra arguments to
read a subset of the framebuffer. Used in following commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h |  1 +
 ui/egl-helpers.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 6c4eb5dd70..6e2f0c49a6 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -31,6 +31,7 @@ void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
 void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
 void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
 void egl_fb_read(DisplaySurface *dst, egl_fb *src);
+void egl_fb_read_rect(DisplaySurface *dst, egl_fb *src, int x, int y, int w, int h);
 
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 1c718b0b98..1169e19adb 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -169,6 +169,20 @@ void egl_fb_read(DisplaySurface *dst, egl_fb *src)
                  GL_BGRA, GL_UNSIGNED_BYTE, surface_data(dst));
 }
 
+void egl_fb_read_rect(DisplaySurface *dst, egl_fb *src, int x, int y, int w, int h)
+{
+    assert(surface_width(dst) == src->width);
+    assert(surface_height(dst) == src->height);
+    assert(surface_format(dst) == PIXMAN_x8r8g8b8);
+
+    glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
+    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
+    glPixelStorei(GL_PACK_ROW_LENGTH, surface_stride(dst) / 4);
+    glReadPixels(x, y, w, h,
+                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(dst) + x * 4);
+    glPixelStorei(GL_PACK_ROW_LENGTH, 0);
+}
+
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip)
 {
     glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
-- 
2.40.1


