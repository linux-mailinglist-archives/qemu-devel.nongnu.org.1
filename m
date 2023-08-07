Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7377730A8
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT798-00068B-NT; Mon, 07 Aug 2023 16:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT796-00065o-OQ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT795-0006kG-62
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ZFlSe/0/0xC1+2/G1PqGE3LwwZEexuiUCyAWa0dhA=;
 b=HQoUowEq39fckmEVomHWNDLf9iLIDblb2nySFDYe330PYJC0RjEo81GCq/B8aVdXlUoJ43
 lyr+QkIPZlkC0tzkfbFGeO05LTVanvx8D7/bL9T47Pj/wDZsOOSwsJPvilF7+jG9CSPgxI
 3hcNt9eoeD/YYQRJP7yLd+CrYOwmfs0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-fY7TS5_vPbaN19ET7-x27g-1; Mon, 07 Aug 2023 16:48:01 -0400
X-MC-Unique: fY7TS5_vPbaN19ET7-x27g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B98C11C05157;
 Mon,  7 Aug 2023 20:48:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 637F640C2076;
 Mon,  7 Aug 2023 20:47:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 6/6] ui/gtk: set scanout mode in
 gd_egl/gd_gl_area_scanout_texture
Date: Tue,  8 Aug 2023 00:47:17 +0400
Message-ID: <20230807204717.2483983-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixing a regression (black screen) caused by a commit 92b58156e7
("ui/gtk: set scanout-mode right before scheduling draw").

The commit 92b58156e7 was made with an assumption that the scanout
mode needs to be set only if the guest scanout is a dmabuf but there
are cases (e.g. virtio-gpu-virgl) where the scanout is still processed
in a form of a texture but is not backed by dmabuf. So it is needed
to put back the line that sets scanout mode in gd_egl_scanout_texture
and gd_gl_area_scanout_texture.

Fixes: 92b58156e7 ("ui/gtk: set scanout-mode right before scheduling draw)
Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230725001131.24017-1-dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 1 +
 ui/gtk-gl-area.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 4c29ac10d0..a1060fd80f 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -246,6 +246,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
+    gtk_egl_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 1ce34a249e..52dcac161e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -268,6 +268,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
         return;
     }
 
+    gtk_gl_area_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
-- 
2.41.0


