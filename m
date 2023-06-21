Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C87391CD
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 23:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC5kZ-0003Tz-Cw; Wed, 21 Jun 2023 17:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC5kX-0003TK-2d
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:52:25 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC5kU-0004Dd-Sc
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687384342; x=1718920342;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5aO41xUSSwh5cdJC98draqCfco7vLE8yPbubUixOYi8=;
 b=TuMy1dwP1qiE968B4VdR8Adx3llun1/Ozs/Me1es6hLGhcHwbopSEKl+
 SQvje+9X8pl00KUSyz9VchMY0bE+hpIp40dnHMg4dFuGKZl+UO9+sFcWZ
 i9/8DP3B5OTi3sR1c32xrQJPvR1w8FiOotqpZ/aj4oT7khTqZbBtiHhyo
 7nilbJ16KpBJfZpek5JiStlSCB21kRcn6J4RsjtzX3iBrMC5SiH5PVILD
 cG0i5NEZI3IKsmmpRzOPzhnrVHq66wICuLOqEyRab8U+nrfDr220cQBjN
 D2N52Mbl4//WAtIJ4FGwmxhz6od4GXstg2hw2adbuKnAhutxK1YJiJBM7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359183975"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="359183975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 14:51:28 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="748895341"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="748895341"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga001.jf.intel.com with ESMTP; 21 Jun 2023 14:51:27 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: set the area of the scanout texture correctly
Date: Wed, 21 Jun 2023 14:31:50 -0700
Message-Id: <20230621213150.29573-1-dongwon.kim@intel.com>
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

x and y offsets and width and height of the scanout texture
is not correctly configured in case guest scanout frame is
dmabuf.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 3 ++-
 ui/gtk-gl-area.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..e99e3b0d8c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -257,7 +257,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
                            dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           0, 0, dmabuf->width, dmabuf->height);
+                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                           dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..1605818bd1 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -299,7 +299,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
                                dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               0, 0, dmabuf->width, dmabuf->height);
+                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
+                               dmabuf->scanout_height);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.34.1


