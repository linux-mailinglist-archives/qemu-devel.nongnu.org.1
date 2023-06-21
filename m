Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589167391BD
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 23:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC5YE-0000QB-Dy; Wed, 21 Jun 2023 17:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC5YA-0000Pf-Qp
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:39:39 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qC5Y9-00065j-0D
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 17:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687383577; x=1718919577;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p9BLet2xnL8h3a+xaxicCdxCNPe/jFBenIJbP6jnUR4=;
 b=mbXYH4LheL/gIFke0ML6c+x8KRJTxbzcAgx91TkThsOXZ0SeJeG7PotX
 MCe+TIZ83Vyq0y0iMxkFAIb4lmmZMRtpUmr0shkQDVmXEmy27jJ5RG4yY
 VR30AHMZ1bbx9nRRicMpI2Ima25SwFAA+F3XjH8IjL2sNAMZXR5+DFmRi
 79xmFoOTIQK0fhaN/vLh4GJLECP/7E/nedh+L6fVpjhkFiZLiWH3ETW+f
 aNh5KXeT41wwj1jfNEgaELbdac4fMyKZiaieekyN3A/w8sJhPDlgTlQjc
 To4bX+1w27tQsPUerpM/vcIyDm8USQUU3jTKAWO9LXVyzfaKcnIqd1Gd5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357808665"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="357808665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 14:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="784665841"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; d="scan'208";a="784665841"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2023 14:39:04 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu: OUT_OF_MEMORY if failing to create udmabuf
Date: Wed, 21 Jun 2023 14:19:31 -0700
Message-Id: <20230621211931.29448-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
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

Respond with VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY if it fails to create
an udmabuf for the blob resource.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..efe66ca7a3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -635,9 +635,11 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
             if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
                 virtio_gpu_update_scanout(g, scanout_id, res, r);
                 return;
+            } else {
+                *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+                return;
             }
         }
-
         data = res->blob;
     } else {
         data = (uint8_t *)pixman_image_get_data(res->image);
-- 
2.34.1


