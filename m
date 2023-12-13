Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858681265D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 05:26:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDdHq-0006Y5-HE; Wed, 13 Dec 2023 23:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHV-0006Xw-UG
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:06 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rDdHS-00047B-SQ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702527902; x=1734063902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6wxqxaULlUE7+5E/y38yXUu9fle7w0xHuXtl3GH8lSA=;
 b=Uanenacu2D8n4mocp9obIA91fOjuiSEJTP7OtVkHJ41dDBQuKY5aCG4Y
 P8h3jog+95zu51FHAReOuanjaULkdQph8djkgznELJcjTx/Z92xOCOnR2
 yh/RcUb+QU+J3E98UOC1MT86lPypIZhp1vaoPvROaUyxb2eSNAIi9S/7D
 m+/jOHwb4T82O2sdm7fp/8jtY4KvoX8fglPqKB0eMb/skkZlxvatg1ujD
 +BDCDY7bu6cVlAcg/jfdE/PCy62MuT6ZeZXcv3cIg1ZWx/UYhkDTrLno3
 aACgQv0B1xIF6lLNo93y1IglZlM6l0C0CCKS1mxaAu9jrIrnemJBTkBW9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481261834"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="481261834"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2023 20:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803127560"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="803127560"
Received: from unknown (HELO localhost.fm.intel.com) ([10.105.154.69])
 by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 20:24:57 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH 2/3] ui/gtk: unblock pipeline only if fence hasn't been
 signaled yet
Date: Wed, 13 Dec 2023 20:24:18 +0000
Message-Id: <20231213202419.15459-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213202419.15459-1-dongwon.kim@intel.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
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

It is needed to unblock the pipeline only if there is an active dmabuf
to be rendered and the fence for it is not yet signaled.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ea8d07833e..073c9eadb8 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,10 +597,16 @@ void gd_hw_gl_flushed(void *vcon)
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
+    }
 }
 
 /** DisplayState Callbacks (opengl version) **/
-- 
2.34.1


