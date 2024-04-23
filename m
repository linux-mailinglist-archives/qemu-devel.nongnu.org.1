Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AD8ADBEE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 04:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz5sa-0002iZ-IL; Mon, 22 Apr 2024 22:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sZ-0002i9-5W
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:31 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sX-00035E-HS
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713839249; x=1745375249;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zJ6Wz69m+E2ghL8V6x+qCW+Dl770RB/nt11Jxl9AGhI=;
 b=cj5UCRMsohBInlCOlCfFsn8pDcsjyHLcMrv0cnb7LO70T31As8acEIoD
 SrTXQZbgukGlrmEN2Z4DfV4zriolmibWwcJj1Jf2XDIxa9LeBFywpJ+VN
 l+8khDO23+b1sFF8lYGyonknDKcdFabXOUrBVDitO+4JsVMVMLJqUmbDY
 ffE85pmhqX9aWGrA1T0PjGqPel8uHlUP4/fG2Wpo5FXEQ7CdmWaFHNEr7
 v5f8Ov3d9bk7EnVpNnWCnZTx4orhy0RwGXH2mzZNEQ8UcKTrorE2WGSDD
 W8SgKeCPQJTSHpSjk4FIgwY6RO/QgMnWqA5ZlfijOUmzfLVBYo1+SIW7I Q==;
X-CSE-ConnectionGUID: YxyMUE48QOaGZEm4HMu5ww==
X-CSE-MsgGUID: Jbvp3nzmQeGDxouU17u8PA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26920052"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="26920052"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 19:27:13 -0700
X-CSE-ConnectionGUID: 0is9LUd1Q6qoY/CUAfUN6g==
X-CSE-MsgGUID: BrscyCnaTZ+YP2EMtqCcMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="29009375"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa005.jf.intel.com with ESMTP; 22 Apr 2024 19:27:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v10 6/6] ui/console: move QemuDmaBuf struct def to dmabuf.c
Date: Mon, 22 Apr 2024 19:22:53 -0700
Message-Id: <20240423022253.1003295-7-dongwon.kim@intel.com>
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

To complete privatizing process of QemuDmaBuf, QemuDmaBuf struct def
is moved to dmabuf.c

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/dmabuf.h | 19 +------------------
 ui/dmabuf.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 7a60116ee6..80d89ac461 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -10,24 +10,7 @@
 #ifndef DMABUF_H
 #define DMABUF_H
 
-typedef struct QemuDmaBuf {
-    int       fd;
-    uint32_t  width;
-    uint32_t  height;
-    uint32_t  stride;
-    uint32_t  fourcc;
-    uint64_t  modifier;
-    uint32_t  texture;
-    uint32_t  x;
-    uint32_t  y;
-    uint32_t  backing_width;
-    uint32_t  backing_height;
-    bool      y0_top;
-    void      *sync;
-    int       fence_fd;
-    bool      allow_fences;
-    bool      draw_submitted;
-} QemuDmaBuf;
+typedef struct QemuDmaBuf QemuDmaBuf;
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                                    uint32_t stride, uint32_t x,
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index f447cce4fe..7f092333b4 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -10,6 +10,25 @@
 #include "qemu/osdep.h"
 #include "ui/dmabuf.h"
 
+struct QemuDmaBuf {
+    int       fd;
+    uint32_t  width;
+    uint32_t  height;
+    uint32_t  stride;
+    uint32_t  fourcc;
+    uint64_t  modifier;
+    uint32_t  texture;
+    uint32_t  x;
+    uint32_t  y;
+    uint32_t  backing_width;
+    uint32_t  backing_height;
+    bool      y0_top;
+    void      *sync;
+    int       fence_fd;
+    bool      allow_fences;
+    bool      draw_submitted;
+};
+
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                             uint32_t stride, uint32_t x,
                             uint32_t y, uint32_t backing_width,
-- 
2.34.1


