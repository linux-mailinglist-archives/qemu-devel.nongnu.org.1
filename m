Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C962A7E37E8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQV-0002cl-MB; Tue, 07 Nov 2023 04:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQL-0002bp-Rh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQK-0003ZE-EG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NB4Cyg7NU27xGvm88rDByN/DYk4hfeQRcyLuZ6i8Am0=;
 b=Q+CZVomPbuPLqVhJZ9EJOtiS+2awkvcDbSGuFurYK2RTEFQvwlZACmXe6grVTIPBEoNTs4
 JXeAP34dzdmlmOrmEMwoDjBQj+hkOpxYFAFxOotoBAapiqfMTG0YaZuD6FYlLZDLU4EYeD
 b/HCpbZpFh2Q3GfuQAQfRFpabjyESI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-7VhhGIcxPxqYTI9pTg-D3g-1; Tue,
 07 Nov 2023 04:30:53 -0500
X-MC-Unique: 7VhhGIcxPxqYTI9pTg-D3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0097D280D587;
 Tue,  7 Nov 2023 09:30:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E95A492A;
 Tue,  7 Nov 2023 09:30:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PULL 3/5] ui/gtk-egl: apply scale factor when calculating window's
 dimension
Date: Tue,  7 Nov 2023 13:30:33 +0400
Message-ID: <20231107093035.2746581-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

From: Dongwon Kim <dongwon.kim@intel.com>

Scale factor needs to be applied when calculating width/height of the
GTK windows.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231012222643.13996-1-dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3e8d1c1d02..cd2f176502 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -69,15 +69,16 @@ void gd_egl_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
-    int ww, wh;
+    int ww, wh, ws;
 
     if (!vc->gfx.gls) {
         return;
     }
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ws = gdk_window_get_scale_factor(window);
+    ww = gdk_window_get_width(window) * ws;
+    wh = gdk_window_get_height(window) * ws;
 
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
@@ -319,7 +320,7 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
-    int ww, wh;
+    int ww, wh, ws;
 
     if (!vc->gfx.scanout_mode) {
         return;
@@ -332,8 +333,9 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ws = gdk_window_get_scale_factor(window);
+    ww = gdk_window_get_width(window) * ws;
+    wh = gdk_window_get_height(window) * ws;
     egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
-- 
2.41.0


