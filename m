Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D80247E37E6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQW-0002dE-99; Tue, 07 Nov 2023 04:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQR-0002cG-6w
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQM-0003ZY-TC
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FV+oA8PeFqi252cEWbjkxa4kBY7+0tBcjACmKudz0w8=;
 b=Xs0yjJJmf3KQVtWctgNnOJbfYF8gNN/3Yk3G6rsjpxq+84nxTOYthdrEinhehiw76Ba7aw
 xStf5hgGX0ybMpTgtVJA92CoPoRXgrv0PGaaANjZLKzYk2ojvo8svYvhmiXXtIbuT2VX/F
 c+qL14K4xYSs5sreqcrBY8oCkkC3TtM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-jYK6joDwO46dNLW7sBoP0w-1; Tue,
 07 Nov 2023 04:30:49 -0500
X-MC-Unique: jYK6joDwO46dNLW7sBoP0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 514923C0278C;
 Tue,  7 Nov 2023 09:30:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35792492BE0;
 Tue,  7 Nov 2023 09:30:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>
Subject: [PULL 2/5] ui/gtk-egl: Check EGLSurface before doing scanout
Date: Tue,  7 Nov 2023 13:30:32 +0400
Message-ID: <20231107093035.2746581-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

From: Antonio Caggiano <quic_acaggian@quicinc.com>

The first time gd_egl_scanout_texture() is called, there's a possibility
that the GTK drawing area might not be realized yet, in which case its
associated GdkWindow is NULL. This means gd_egl_init() was also skipped
and the EGLContext and EGLSurface stored in the VirtualGfxConsole are
not valid yet.

Continuing with the scanout in this conditions would result in hitting
an assert in libepoxy: "Couldn't find current GLX or EGL context".

A possible workaround is to just ignore the scanout request, giving the
the GTK drawing area some time to finish its realization. At that point,
the gd_egl_init() will succeed and the EGLContext and EGLSurface stored
in the VirtualGfxConsole will be valid.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231016123215.2699269-1-quic_acaggian@quicinc.com>
---
 ui/gtk-egl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index a1060fd80f..3e8d1c1d02 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -243,12 +243,19 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     vc->gfx.h = h;
     vc->gfx.y0_top = backing_y_0_top;
 
-    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                   vc->gfx.esurface, vc->gfx.ectx);
+    if (!vc->gfx.esurface) {
+        gd_egl_init(vc);
+        if (!vc->gfx.esurface) {
+            return;
+        }
+
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
 
-    gtk_egl_set_scanout_mode(vc, true);
-    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                         backing_id, false);
+        gtk_egl_set_scanout_mode(vc, true);
+        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                             backing_id, false);
+    }
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
-- 
2.41.0


