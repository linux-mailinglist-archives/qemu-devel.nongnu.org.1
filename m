Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940B7406BE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 01:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEHjn-0002f9-To; Tue, 27 Jun 2023 19:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEHjk-0002cG-B8
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 19:04:40 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEHjh-0002YY-A6
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 19:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687907077; x=1719443077;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OrrNW7epNRgmk8QGefyjWm1Wj/F4UBCFSZXKzY4hkHA=;
 b=gS+/NkgmsX6JVNV9UwhZY8rItD1JdBBPa4sT65GCo/lKNzLRYXsZyZnW
 BkQlaJ9t0hsh2EV4uEoTiiytz42b+rSPIKLhy+nkn2uv6mF3Jdll8vXeZ
 2X4rU4VeuHh5kZxiWLN/o1Fv0n9/zdPvsttMgiEng5NqphLPBDCMwL3FQ
 JE/sqzunAu1WQavkIdopGf1nn7on+6ctAiQsDlwfvALDHYf/S3emN5PVD
 3md+iIJs933oQWbMHRiCUAfLxlMznOXK88DarXzGhoy7N4kKjlAQpYCq9
 Bg9wU+8g4gr/cKO2E9+uLko5gy5+WySas9fs4nH8P5IBWNm5MrKslf2MZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="360557908"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="360557908"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 16:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666879726"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="666879726"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 16:04:28 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu: replace the surface with null surface when
 resetting
Date: Tue, 27 Jun 2023 15:44:51 -0700
Message-Id: <20230627224451.11739-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=dongwon.kim@intel.com;
 helo=mga04.intel.com
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

The primary guest scanout shows the booting screen right after reboot
but additional guest displays (i.e. max_ouptuts > 1) will keep displaying
the old frames until the guest virtio gpu driver gets initialized, which
could cause some confusion. A better way is to to replace the surface with
a place holder that tells the display is not active during the reset of
virtio-gpu device.

And to immediately update the surface with the place holder image after
the switch, displaychangelistener_gfx_switch needs to be called with
'update == TRUE' in dpy_gfx_replace_surface when the new surface is NULL.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c |  5 +++++
 ui/console.c            | 11 ++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..de92f003b5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1354,6 +1354,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     VirtIOGPU *g = VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
     struct virtio_gpu_ctrl_command *cmd;
+    int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         virtio_gpu_resource_destroy(g, res);
@@ -1372,6 +1373,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)
         g_free(cmd);
     }
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
+    }
+
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 }
 
diff --git a/ui/console.c b/ui/console.c
index e173731e20..768f39697c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1787,6 +1787,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     static const char placeholder_msg[] = "Display output is not active.";
     DisplayState *s = con->ds;
     DisplaySurface *old_surface = con->surface;
+    DisplaySurface *new_surface = surface;
     DisplayChangeListener *dcl;
     int width;
     int height;
@@ -1800,19 +1801,19 @@ void dpy_gfx_replace_surface(QemuConsole *con,
             height = 480;
         }
 
-        surface = qemu_create_placeholder_surface(width, height, placeholder_msg);
+        new_surface = qemu_create_placeholder_surface(width, height, placeholder_msg);
     }
 
-    assert(old_surface != surface);
+    assert(old_surface != new_surface);
 
     con->scanout.kind = SCANOUT_SURFACE;
-    con->surface = surface;
-    dpy_gfx_create_texture(con, surface);
+    con->surface = new_surface;
+    dpy_gfx_create_texture(con, new_surface);
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != (dcl->con ? dcl->con : active_console)) {
             continue;
         }
-        displaychangelistener_gfx_switch(dcl, surface, FALSE);
+        displaychangelistener_gfx_switch(dcl, new_surface, surface ? FALSE : TRUE);
     }
     dpy_gfx_destroy_texture(con, old_surface);
     qemu_free_displaysurface(old_surface);
-- 
2.34.1


