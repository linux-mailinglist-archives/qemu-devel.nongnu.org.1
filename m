Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01457392B1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 00:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC6bJ-00069x-6q; Wed, 21 Jun 2023 18:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC6bA-00067k-PF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:46:49 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC6b6-0007YK-U1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 18:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687387605; x=1718923605;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+7rHBmtxbQOLvRWO4pg6KkQW2b2D2DOT29FiHSDpFF0=;
 b=do39ncdUIevYwPmXBUMnUeoA3LIGPSj/KwlYx2GaxC+WIKy0xZ52sTHP
 3a9lLMpZvU7Dz5eI9tYb4fI17PUwhqhIQ7AaDfB+S33ByhgDxPSS2gkgg
 lH7EdV5hRSYs5TCSDhSeLsi8GgQGSP5KBsPoBPOca7f2B4v18mWvmLL6I
 hrecF0vRCCuwaEmAZIpHtYmgxY00JyFOcuzrtJvP4gwUNhC/1E2GwhxyU
 rdiUDbtCstRF304T3ceUWFKigfQunWYT5YNOX/bYldiqEHg+cEbtnhCM0
 4+VvOVs/f6akZZujy7oyQkbK6V2EP+7MsEZRTY7chnS/Ff4pNm8dgwGlM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="362873993"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="362873993"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 15:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717842290"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="717842290"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 15:46:39 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu-udmabuf: create udmabuf for blob even when iov_cnt
 == 1
Date: Wed, 21 Jun 2023 15:27:04 -0700
Message-Id: <20230621222704.29932-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=dongwon.kim@intel.com; helo=mga09.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

There were often cases where a scanout blob sometimes has just 1 entry
that is linked to many pages in it. So just checking whether iov_cnt is 1
is not enough for screening small, non-scanout blobs. Therefore adding
iov_len check as well to make sure it creates an udmabuf only for a scanout
blob, which is at least bigger than one page size.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 69e2cf0bd6..ef1a740de5 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -132,7 +132,8 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     void *pdata = NULL;
 
     res->dmabuf_fd = -1;
-    if (res->iov_cnt == 1) {
+    if (res->iov_cnt == 1 &&
+        res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
         virtio_gpu_create_udmabuf(res);
-- 
2.34.1


