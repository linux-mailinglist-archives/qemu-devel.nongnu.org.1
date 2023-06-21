Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D3737889
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGG-0007pA-St; Tue, 20 Jun 2023 21:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGF-0007oY-0p
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:51 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGD-0001GW-9c
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309429; x=1718845429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jsUvvs3uPDjPnHLHhR8XgDCXj27+som4PR/bEyALolQ=;
 b=F2/1P5vd6T/rN3biRJLkW99xS7EI4l1SDoGhiQ4L4Ms0kFuUvfX13B2o
 Uag9Q7qrgYqr9dlWT+nmAZ6Hcsy4bsZB36/Wo07qz6oE7qw1Rvfwmd5zb
 qX9/V69lrSGKAqN9vXsm8bfYcbS7CTPL04hLP0ti6YJKXIn248/boDIgS
 HUcFizMQsxdZB5qeP9J6L+7tq5kVFSxk48GGVwjIrm5Ec/Awm/3OUlkBF
 wi3HdyaggFM01Zi3ecL8JG0y9dG3y8VhjLGEuHmoo7ONLaalA8zZbXlOy
 WuEebHjhJCuJBDX73Un/lQ8ne24G2URsPxJw74efRmy+/X+JAp/V7OWgM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522835"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522835"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429576"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429576"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:43 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 7/9] ui/gtk: unblock gl if draw submitted already or fence
 is not yet signaled
Date: Tue, 20 Jun 2023 17:43:53 -0700
Message-Id: <20230621004355.19920-8-dongwon.kim@intel.com>
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

Remove monitor while a guest frame is still being processed could block
the guest (virtio-gpu) scanout pipe line. It is needed to manually flush
the pipeline to prevent the permanent lockup.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index f4c71454a3..e4ef1f7173 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -598,10 +598,21 @@ void gd_hw_gl_flushed(void *vcon)
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 
-    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-    close(dmabuf->fence_fd);
-    dmabuf->fence_fd = -1;
-    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    if (!dmabuf) {
+        return;
+    }
+
+    if (dmabuf->fence_fd > 0) {
+        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
+        close(dmabuf->fence_fd);
+        dmabuf->fence_fd = -1;
+        graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    } else if (dmabuf->draw_submitted) {
+        /* if called after a frame is submitted but render event
+         * is not scheduled yet, cancel submitted draw. */
+        dmabuf->draw_submitted = false;
+        graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    }
 }
 
 /** DisplayState Callbacks (opengl version) **/
@@ -742,6 +753,9 @@ static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
     dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
 }
 
+static gboolean gd_window_state_event(GtkWidget *widget, GdkEvent *event,
+                                      void *opaque);
+
 static void gd_ui_hide(VirtualConsole *vc)
 {
     QemuUIInfo info;
@@ -751,6 +765,8 @@ static void gd_ui_hide(VirtualConsole *vc)
     info.width = 0;
     info.height = 0;
     dpy_set_ui_info(vc->gfx.dcl.con, &info, false);
+    /* forcefully cancel rendering sequence */
+    gd_hw_gl_flushed(vc);
 }
 
 static void gd_ui_show(VirtualConsole *vc)
@@ -1460,11 +1476,6 @@ static gboolean gd_window_state_event(GtkWidget *widget, GdkEvent *event,
 
     if (event->window_state.new_window_state & GDK_WINDOW_STATE_ICONIFIED) {
         gd_ui_hide(vc);
-        if (vc->gfx.guest_fb.dmabuf &&
-            vc->gfx.guest_fb.dmabuf->draw_submitted) {
-            vc->gfx.guest_fb.dmabuf->draw_submitted = false;
-            graphic_hw_gl_block(vc->gfx.dcl.con, false);
-        }
     } else {
         gd_ui_show(vc);
     }
-- 
2.34.1


