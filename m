Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69874067A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 00:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEHDr-0003Fj-8q; Tue, 27 Jun 2023 18:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEHDn-0003FS-FZ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 18:31:40 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEHDk-0003TO-CN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 18:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687905096; x=1719441096;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tJTtq6w8/v8JmOAQkuW27MoSXs00uBvKR5b6TKtAP80=;
 b=jHs4Pq101Ql/6DHcKyf7gcmtX+O6GiPUMnca78U6HJ47VbDK73runiBB
 LHVEiqXg+0Py/8TczLJWUBEfv4VFeO29sVcn6UX/6DBrblxr1UpHInaAz
 BKoibCUZOOE7wpYQEeq1QmXL19y/uyolkiu7v0y8F8Hx/OBMbXwk9Alam
 Qwsb37KhvwlJVKXbRWoGflf7bkki58Ik4CM0EV2hWsh9yDo8MmbBFoc+i
 5RHqicGU5VNQAP2bKAMqyfJjjAaKf9qohys2JX7C1t5pB7g+TQ543SIzD
 H9w4LwQcEBL5B7tNLw4N2tFTCIe16GCSfuUhK1w3+5XWh5PVkFyhK6Iek g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427703937"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="427703937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 15:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716696532"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="716696532"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga002.jf.intel.com with ESMTP; 27 Jun 2023 15:31:18 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu: do not replace surface when scanout is disabled
Date: Tue, 27 Jun 2023 15:11:39 -0700
Message-Id: <20230627221139.11250-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dongwon.kim@intel.com; helo=mga07.intel.com
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

Surface is replaced with a place holder whenever the surface res
is unreferenced by the guest message. With this logic, there is
very frequent switching between guest display and the place holder
image, which is looking like a flickering display if the guest driver
is designed to unref the current scanout resource before sending out
a new scanout resource. So it is better to leave the current scanout
image until there is a new one flushed by the guest.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..9d3e922c8f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -387,7 +387,6 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
         res->scanout_bitmask &= ~(1 << scanout_id);
     }
 
-    dpy_gfx_replace_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;
     scanout->width = 0;
-- 
2.34.1


