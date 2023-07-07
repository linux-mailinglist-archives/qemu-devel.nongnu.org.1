Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E074AEA6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHiXn-0002er-Lh; Fri, 07 Jul 2023 06:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qHiXl-0002ee-Pj
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:18:30 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qHiXi-0005Ji-Lk
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688725106; x=1720261106;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Sl7xMsGIhvNhKg/eMTS/28YkxbVhCFm9LQgsWu9Ws08=;
 b=VOQR11pzUjFb3d4EZvT5ZsktrCj9qlFdrp9AFaAycSB6t66bxk28aFtx
 zPMPdFLZkR4VmSqgamLlpCbJ00GY7RoXcPLG5imMfxAB8HNxu9RqS2rmn
 GvoH84CuXKk8phkxeWly2q216KNVideMokJPEC7lALJezXSLrOLuvG9QK
 SMsC+SEaeBHdUpBfv8QmtCw2pWJuxqxD6cRNx5/pQXFVXMpUQwflniEus
 Q5RhViy0ngoHT1ZuRM+IEwEZQl1I9d3b5GDZkhh5+0lxgIqDcJMySSo3C
 w40n7tm5xt88kxg6conZrfwt/3bvc8CVjHzSo7/50u4lAv5Yo7lIEfKqN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429919049"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="429919049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2023 03:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="1050496750"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="1050496750"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 03:18:21 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] vhost_vdpa: no need to fetch vring base when poweroff
Date: Sat,  8 Jul 2023 02:18:26 +0800
Message-Id: <20230707181826.10946-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=lingshan.zhu@intel.com; helo=mga07.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
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

In the poweroff routine, no need to fetch last available index.

This commit also provides a better debug message in the vhost
caller vhost_virtqueue_stop, because if vhost does not fetch
the last avail idx successfully, maybe the device does not
suspend, vhost will sync last avail idx to vring used idx as a
work around, not a failure.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++++
 hw/virtio/vhost.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e..f62952e1c7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
 
 /*
  * Return one past the end of the end of section. Be careful with uint64_t
@@ -1391,6 +1392,9 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
     struct vhost_vdpa *v = dev->opaque;
     int ret;
 
+    if (runstate_check(RUN_STATE_SHUTDOWN))
+        return 0;
+
     if (v->shadow_vqs_enabled) {
         ring->num = virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
         return 0;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 82394331bf..84712743e0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
-        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+        VHOST_OPS_DEBUG(r, "sync last avail idx to the used idx for vhost VQ %u", idx);
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
-- 
2.39.3


