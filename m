Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D962581265C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 05:26:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDdI0-0006aA-5p; Wed, 13 Dec 2023 23:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHZ-0006YC-Jz
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:12 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHS-00042h-SP
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702527902; x=1734063902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZkrEvWMsfvQM9NsB8lnuFgtnYVsBPS+AeVFa+EbApSE=;
 b=CyzM4VeYBJcqibUTOaolUOVZnxwcEMWHnmQQdwyfhTot5i7JT+NEJSOq
 KsuiRknrcPjNrJehFSB0BjHYAexhxFFyX2toi319jK9AoD+iZebEEqLVo
 8VvNG/lnBZF0UdxlSnxBlgKD9sbJo5mYoBD0uMNtrD6mmNuYSMgMY58I8
 tb1nYIAm7+xDoT7R383PKKYibkR4LeHqirUWEStngUtDtny8xRk2DHx19
 jS36Ufgw75mMQM0BEmEpNqyTWx91bSW4x0j7fRrKQdrrQoGk/usqRRgYt
 Md1b25+JeA5k3Gl+oGWQoRehvjq/p34jv1uZoZrcGcivD6ToP6+oleh4q g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481261830"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="481261830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2023 20:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803127551"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="803127551"
Received: from unknown (HELO localhost.fm.intel.com) ([10.105.154.69])
 by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 20:24:56 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
Date: Wed, 13 Dec 2023 20:24:17 +0000
Message-Id: <20231213202419.15459-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204184051.16873-1-dongwon.kim@intel.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

If the guest state is paused before it gets a response for the current
scanout frame submission (resource-flush), it won't flush new frames
after being restored as it still waits for the old response, which is
accepted as a scanout render done signal. So it's needed to unblock
the current scanout render pipeline before the run state is changed
to make sure the guest receives the response for the current frame
submission.

v2: Giving some time for the fence to be signaled before flushing
    the pipeline

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..ea8d07833e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -678,6 +678,25 @@ static const DisplayGLCtxOps egl_ctx_ops = {
 static void gd_change_runstate(void *opaque, bool running, RunState state)
 {
     GtkDisplayState *s = opaque;
+    int i;
+
+    if (state == RUN_STATE_SAVE_VM) {
+        for (i = 0; i < s->nb_vcs; i++) {
+            VirtualConsole *vc = &s->vc[i];
+
+            if (vc->gfx.guest_fb.dmabuf &&
+                vc->gfx.guest_fb.dmabuf->fence_fd >= 0) {
+                eglClientWaitSync(qemu_egl_display,
+                                  vc->gfx.guest_fb.dmabuf->sync,
+                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
+                                  100000000);
+
+                /* force flushing current scanout blob rendering process
+                 * just in case the fence is still not signaled */
+                gd_hw_gl_flushed(vc);
+            }
+        }
+    }
 
     gd_update_caption(s);
 }
-- 
2.34.1


