Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09721802CC1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:09:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA40n-0000rN-8H; Mon, 04 Dec 2023 03:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40k-0000qr-AM
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40i-0005of-Nm
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701677339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oR60ATf4YFxCKSXIOQ/fcanosmfsigIJj2/ZsrPHDTk=;
 b=Arsyy/N2l+cydHuHeKSU955fVvDEkAcVyXmaAUdMGqSz77M1Uxlj27d6uL8MJW2q6WLibM
 QZkxPL/Fl+gADybu2DSRM7X3Gi/jx3KI5XcrbgiO+5SUa1FpiIpwY8ROG+3Z5CIlD47DfO
 Wo9+P3VroemY5vVTeVJYBuibB+4YhCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-2hRpUznFP0qAmGAn01W1Sw-1; Mon, 04 Dec 2023 03:08:57 -0500
X-MC-Unique: 2hRpUznFP0qAmGAn01W1Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70D69101A53B;
 Mon,  4 Dec 2023 08:08:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B711719E91;
 Mon,  4 Dec 2023 08:08:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 1/3] ui/gtk-egl: move function calls back to regular code path
Date: Mon,  4 Dec 2023 12:08:48 +0400
Message-ID: <20231204080850.4068242-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
References: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Commit 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing
scanout") introduced a regression when QEMU is running with a
virtio-gpu-gl-device on a host under X11. After the guest has
initialized the virtio-gpu-gl-device, the guest screen only
shows "Display output is not active.".

Commit 6f189a08c1 moved all function calls in
gd_egl_scanout_texture() to a code path which is only called
once after gd_egl_init() succeeds in gd_egl_scanout_texture().
Move all function calls in gd_egl_scanout_texture() back to
the regular code path so they get always called if one of the
gd_egl_init() calls was successful.

Fixes: 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing scanout")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231111104020.26183-1-vr_qemu@t-online.de>
---
 ui/gtk-egl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index cd2f176502..3af5ac5bcf 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -249,14 +249,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
         if (!vc->gfx.esurface) {
             return;
         }
+    }
 
-        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                       vc->gfx.esurface, vc->gfx.ectx);
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
 
-        gtk_egl_set_scanout_mode(vc, true);
-        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                             backing_id, false);
-    }
+    gtk_egl_set_scanout_mode(vc, true);
+    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                         backing_id, false);
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
-- 
2.43.0


