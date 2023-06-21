Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5E73788F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGE-0007oI-Vf; Tue, 20 Jun 2023 21:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGC-0007nC-RO
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:48 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGB-0001Fp-3H
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309427; x=1718845427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NzRNLrigI1mTX2rfYDAoYeRMXBVawCRCZ4B/zs9bAh4=;
 b=Ll4JLANsvskJi0GlYGsedDV7pkEzdMOCSgDDm0BBcZSgy6rZ3ZoIRabJ
 kCVzFR/2334GDajbB63t8MqrYAd7EzOOaf16BWHQCIcuDdGUsUTO9zipq
 lwLvQ8z/S2A1dW1lbuJ3vuomqkKSMZgNIc/vYTmDJVwEIR4x78eQMVYVT
 xp0QkPtHnPsgo4jSh4G8weXWOW8qpI6tIUVmD81b9I5oX3KzDyhFw12u5
 RYEaikf6Ru622dWUjKlsH8R+yD845mF07tcZB/jmsXBS+nplsYwLFF6ik
 Tw2Iol/15ZcAB40EdGEBbqvMM1Nncd4xXJod7MdvpGA+95a7YG1kfoGrC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522819"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522819"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429566"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429566"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:41 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 4/9] ui/gtk: Disable the scanout when a detached tab is
 closed
Date: Tue, 20 Jun 2023 17:43:50 -0700
Message-Id: <20230621004355.19920-5-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230621004355.19920-1-dongwon.kim@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

When a detached tab window is closed, the underlying (EGL) context
is destroyed; therefore, disable the scanout which also destroys the
underlying framebuffer (id) and other objects. Also add calls to
make the context current in disable scanout and other missing places.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 3 +++
 ui/gtk-gl-area.c | 2 ++
 ui/gtk.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 443873e266..aa22ebbd98 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -214,6 +214,9 @@ void gd_egl_scanout_disable(DisplayChangeListener *dcl)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
+
     vc->gfx.w = 0;
     vc->gfx.h = 0;
     gtk_egl_set_scanout_mode(vc, false);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 68b16a5ff1..8228cc9f3f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -270,6 +270,7 @@ void gd_gl_area_scanout_disable(DisplayChangeListener *dcl)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     gtk_gl_area_set_scanout_mode(vc, false);
 }
 
@@ -282,6 +283,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
         return;
     }
 
+    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
diff --git a/ui/gtk.c b/ui/gtk.c
index f9096aea14..90ecb8b82f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1400,6 +1400,7 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
 
     vc->gfx.visible = false;
     gd_set_ui_size(vc, 0, 0);
+    dpy_gl_scanout_disable(vc->gfx.dcl.con);
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
     gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
-- 
2.34.1


