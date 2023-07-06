Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A374A405
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU9m-0000Ts-J6; Thu, 06 Jul 2023 14:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHU9f-0000T5-JV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:56:40 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHU9c-000347-PA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688669796; x=1720205796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JwUaUdYFJwdjZQvydfHaexDtxxAqjQ/7S8NfQja+8VQ=;
 b=RaxXpRRT5xLZol2bQ4KEW0i6faWA+wdOK+/paDaMv8O/i6yLR8YV5LZ+
 EN0KlNlpq8mqZ2o+7cGWaxXYbOhjTWKwKCA2pf8rFjvqbYKiYxzpE34SH
 wX6Lapip7JXX203yCScJADc/Jh6qrytIQi/KEsYgHjnfcXSdH0r+y9T4v
 EZbTIz9FOtR10KteUHBXzk5z8vi5nW33GizrCxsdJcsOunMOZYBtN7Pe9
 dvOzdatbW1q3vkyv1KeNvWjKmv6BnQEFpq2sbQCBNojv43Pxw0kuZOjjg
 mbIPSRhgZU6zYM0j12699jggVlAdUEzDhJaZBdNNMoNLZeyn/fQwrzC2t g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344024312"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="344024312"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 11:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="809755784"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="809755784"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2023 11:56:31 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: set scanout-mode right before scheduling draw
Date: Thu,  6 Jul 2023 11:33:54 -0700
Message-Id: <20230706183355.29361-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
References: <CAJ+F1C+9hbdgv7tLibnYKS-3fOBotVU=MHwYq6Ly2Wccf-Dd_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=dongwon.kim@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Setting scanout mode is better to be done very last minute
right because the mode can be reset anytime after it is set in
dpy_gl_scanout_texture by any asynchronouse dpy_refresh call,
which eventually cancels drawing of the guest scanout texture.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 2 +-
 ui/gtk-gl-area.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d59b8cd7d7..b0356d1969 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -238,7 +238,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
-    gtk_egl_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
@@ -347,6 +346,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
     }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7367dfd793..cc8c2f8061 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -262,7 +262,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
         return;
     }
 
-    gtk_gl_area_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
@@ -282,6 +281,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
 }
-- 
2.34.1


