Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB708ADBE9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 04:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz5sV-0002gl-9x; Mon, 22 Apr 2024 22:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sT-0002gY-SY
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:25 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sS-00034P-7H
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713839244; x=1745375244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=67NgeQ/kFsPNIg8m3af1zHaTrIuCCnTfBkPGdpoYPQc=;
 b=UklmIk4YJXp3446w8scIAFRC27TO9+bJarFgL64vBwcjZvFIrwY/GJoa
 BEdVrEfR0vs2j4YD87qTPtf8KDCD6VM4loE4ALNwoHP041p+gbUO+85l/
 e8i90vZNZPdFgLf8azsajEu6Vg4iMQoyJqcNskEG6+iwZOKxJdHsVj00m
 lrr8kk/JYRSpAUcyCMaRoa3szqhu5PrgNyjO6tl5rCAzC7302xiCCXUlN
 MMPkc/oqGiwvAO2RwQWava/PRhIy88dJ84oWSYzYcNpVsNLNgaHZl10Gs
 o2qowci4KWejxsIqR3OMOKwHwhcClVLEVEiNV8Bt+uJdBRwShxS05LwQX w==;
X-CSE-ConnectionGUID: NCU4ONYgQrSX66N7/mIrSA==
X-CSE-MsgGUID: nt4yl9amR7+3kr06/P7rWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26920036"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="26920036"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 19:27:12 -0700
X-CSE-ConnectionGUID: /VS9X4MLQhK033ywHTBogA==
X-CSE-MsgGUID: Am/BI2ftSnuNZ78H9NYaeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="29009368"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa005.jf.intel.com with ESMTP; 22 Apr 2024 19:27:12 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v10 1/6] ui/gtk: Check if fence_fd is equal to or greater than
 0
Date: Mon, 22 Apr 2024 19:22:48 -0700
Message-Id: <20240423022253.1003295-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423022253.1003295-1-dongwon.kim@intel.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

'fence_fd' needs to be validated always before being referenced
And the passing condition should include '== 0' as 0 is a valid
value for the file descriptor.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     |  2 +-
 ui/gtk-gl-area.c |  2 +-
 ui/gtk.c         | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3af5ac5bcf..955234429d 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -99,7 +99,7 @@ void gd_egl_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
         if (dmabuf) {
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            if (dmabuf->fence_fd >= 0) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 52dcac161e..7fffd0544e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -86,7 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
         if (dmabuf) {
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            if (dmabuf->fence_fd >= 0) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..7819a86321 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,10 +597,12 @@ void gd_hw_gl_flushed(void *vcon)
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 
-    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-    close(dmabuf->fence_fd);
-    dmabuf->fence_fd = -1;
-    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    if (dmabuf->fence_fd >= 0) {
+        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
+        close(dmabuf->fence_fd);
+        dmabuf->fence_fd = -1;
+        graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    }
 }
 
 /** DisplayState Callbacks (opengl version) **/
-- 
2.34.1


