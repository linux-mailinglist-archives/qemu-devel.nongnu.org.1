Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4A760411
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 02:36:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO61M-0007GJ-Km; Mon, 24 Jul 2023 20:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qO61J-0007GA-QD
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 20:35:21 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qO61H-0001Ju-AA
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 20:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690245319; x=1721781319;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4PeKoXFrDtbxtxtxMkNdxUhJCHdVDVjQdTH2vvZOsKc=;
 b=GaR8pALexOWGmSoej0RHNW1IUGCcxDvyMl9Lmvgc/Xh9wdoNBL2kAd9M
 ieZnx3+EEBTD+LRuJvcS6yQSCHV4gcHrA7EXQjo4OnSJOjmOjGapaNq4W
 WK5tlre4kz6IK0OHHPfx7UYbJkAm21muhxqU2pjLBmyKXQNdnJcwX/CW8
 nGGUng7/b/NSX7ZzdYt/caXag0amWHjir+H5y4BPPs6p0xvG9tIsGSe+L
 5OeitC3SUDyD0idbRTdmBzf5u7xfVIt/XHpKDUxxAk5ABQm3FJGczK4gT
 MZ5zGE08xm9FOkCCJInqamAWnW/ODvqk+PzN1WHma8udtZFtdKoYl7FeL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367610403"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; d="scan'208";a="367610403"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2023 17:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="725892029"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; d="scan'208";a="725892029"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga002.jf.intel.com with ESMTP; 24 Jul 2023 17:34:55 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: set scanout mode in gd_egl/gd_gl_area_scanout_texture
Date: Mon, 24 Jul 2023 17:11:31 -0700
Message-Id: <20230725001131.24017-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=dongwon.kim@intel.com;
 helo=mga14.intel.com
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
2.34.1


