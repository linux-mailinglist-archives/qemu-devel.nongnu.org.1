Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FA75630F
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcQ-0005k3-RH; Mon, 17 Jul 2023 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNc5-0005Ya-Ux
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNc4-0008EZ-Ct
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QWpDZ8cYfLOy/V9/2FO6ewZmYkahgo3N9Qbw4+S1DY=;
 b=IJL+Dw8hLrOnEBkhft/yiRGo1oY07pd62vD5FDbfq2Bm9E8T0Uff/+J18tkGz4q6315Wma
 asUz6x7aCA8CbPx+r1nvdVBLntXHLajvOKNpu42ZXIPAVguFB9Qec6tfF/f/OiX7HuhT5X
 686EGCrlilm7vwe3yXAYMTm6yKAvZFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-nECTegRrNdmjPafOdgWYEw-1; Mon, 17 Jul 2023 08:46:02 -0400
X-MC-Unique: nECTegRrNdmjPafOdgWYEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E526185A7A7;
 Mon, 17 Jul 2023 12:46:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9466B10E58;
 Mon, 17 Jul 2023 12:46:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 03/19] ui/gtk: Make sure the right EGL context is currently
 bound
Date: Mon, 17 Jul 2023 16:45:28 +0400
Message-ID: <20230717124545.177236-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

From: Dongwon Kim <dongwon.kim@intel.com>

Observed a wrong context is bound when changing the scanout mode.
To prevent problem, it is needed to make sure to bind the right
context in gtk_egl_set_scanout_mode/gtk_gl_area_set_scanout_mode
as well as unbind one in the end of gd_egl_update/gd_gl_area_update.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230628191504.17185-1-dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 4 ++++
 ui/gtk-gl-area.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d59b8cd7d7..42db1bb6cf 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -32,6 +32,8 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
         egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
@@ -135,6 +137,8 @@ void gd_egl_update(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
     surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
     vc->gfx.glupdates++;
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, EGL_NO_CONTEXT);
 }
 
 void gd_egl_refresh(DisplayChangeListener *dcl)
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7367dfd793..a9a7fdf50c 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -26,6 +26,7 @@ static void gtk_gl_area_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
+        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
         egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
@@ -115,6 +116,7 @@ void gd_gl_area_update(DisplayChangeListener *dcl,
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
     vc->gfx.glupdates++;
+    gdk_gl_context_clear_current();
 }
 
 void gd_gl_area_refresh(DisplayChangeListener *dcl)
-- 
2.41.0


