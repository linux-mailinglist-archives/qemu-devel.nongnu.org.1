Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4C73EFE3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 02:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDwyh-0003F6-RG; Mon, 26 Jun 2023 20:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDwyf-0003Ey-B3
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 20:54:41 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDwyc-000194-VW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 20:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687827278; x=1719363278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BkFEIohU/c/73IIEDDdeS0g8VwJ++s9LnOtogmOtBn8=;
 b=V4XBIYGosJeXd1IV5bn4gc0ot3JqPWiZeAD5+FSFjDW12rCM3L1PpZ0Y
 qSk68cSixoQMFzHZmjkd+q8UNeEOYv640tAfXHRt2KK6ePy8oa3SMJ3wt
 SwDa/Q/MMREnhs1m5WaD6pc3LAbzIYv7zsgm/xATvcMnx5TlbYCBgArDE
 VFzBXL9rwhfbdD5msJdMHlwBcS9xMlmsZqZlImp+NhjDp9LVtnA51iN5i
 fQ9WIXI9lfRyPO+8GhhQwig7+LQfG1fZy3H8NY7DnmbXy8GDN5EzO5/yj
 pP4tHKdLIt4MhYdTQWh14Kt1jZvbyayfxeNRCCQ5gsuVtdORyB8ZtY2DD A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351218044"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="351218044"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 17:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719583349"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="719583349"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 17:54:36 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v2] virtio-gpu: OUT_OF_MEMORY if failing to create udmabuf
Date: Mon, 26 Jun 2023 17:34:53 -0700
Message-Id: <20230627003453.5321-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJ+F1CJhDBPHY12xYh74g1t6K+WXhZ2ThKFw09QDNnTNA49RzQ@mail.gmail.com>
References: <CAJ+F1CJhDBPHY12xYh74g1t6K+WXhZ2ThKFw09QDNnTNA49RzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mga02.intel.com
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

Respond with VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY if it fails to create
an udmabuf for the blob resource.

v2: consolidated return statments and removed an unnecessary style change

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..ce019941b8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -634,8 +634,10 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
         if (console_has_gl(scanout->con)) {
             if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
                 virtio_gpu_update_scanout(g, scanout_id, res, r);
-                return;
+            } else {
+                *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
             }
+            return;
         }
 
         data = res->blob;
-- 
2.34.1


