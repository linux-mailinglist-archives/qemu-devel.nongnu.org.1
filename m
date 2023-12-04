Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E0804527
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 03:41:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rALMY-0007SL-3b; Mon, 04 Dec 2023 21:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rALMQ-0007Re-9A
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 21:40:35 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rALMM-0005QE-Cx
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 21:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701744030; x=1733280030;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BStm0IG0TGW8yLK+dWHICb7ZIscZLOYUIoVfC1+k9gg=;
 b=WjmHmWMIUMU7Y0PPlsd9tOvhR9gw7iI1AAVKNrg6IkiLlCwGskv7wG71
 tPzHSFyc4XznC0l2d8/5xH3VH8QV1x/8UwP0SkuEBz8DptU4y5TXtks4F
 HfF1a8HeZG4dC64za7N45/3ae2fob9CuBSbchYtKcDHD9jhlk5qsK930C
 O6dbkr9RMC/KOl+CioTLid+u8dXgcKLjqajOXuYcklSHYPTFp5Dsq2S5b
 r1Td66/reoEAT5d+2QqpO5MSjtaYqauXAS7Mkyj/mm+/l7yr4Lu2QnTRX
 mmilufnCq2i2nf1WfrHeeNzJTPBSRXa8d/WuGlQsMCgARXvJu1PXqZ+Y6 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458153847"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; d="scan'208";a="458153847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 18:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; d="scan'208";a="18799006"
Received: from unknown (HELO localhost.fm.intel.com) ([10.105.154.69])
 by orviesa001.jf.intel.com with ESMTP; 04 Dec 2023 18:40:25 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
Date: Mon,  4 Dec 2023 18:40:51 +0000
Message-Id: <20231204184051.16873-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If the guest state is paused before it gets a response for the current
scanout frame submission (resource-flush), it won't start submitting
new frames after being restored as it still waits for the old response,
which is accepted as a scanout render done signal. So it's needed to
unblock the current scanout render pipeline before the run state is
changed to make sure the guest receives the response for the current
frame submission.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..0f6237dd2f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -678,6 +678,18 @@ static const DisplayGLCtxOps egl_ctx_ops = {
 static void gd_change_runstate(void *opaque, bool running, RunState state)
 {
     GtkDisplayState *s = opaque;
+    int i;
+
+    if (state == RUN_STATE_SAVE_VM) {
+        for (i = 0; i < s->nb_vcs; i++) {
+            VirtualConsole *vc = &s->vc[i];
+
+            if (vc->gfx.guest_fb.dmabuf) {
+                /* force flushing current scanout blob rendering process */
+                gd_hw_gl_flushed(vc);
+            }
+        }
+    }
 
     gd_update_caption(s);
 }
-- 
2.34.1


