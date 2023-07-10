Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109C74D0A7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImeX-0001c8-Jd; Mon, 10 Jul 2023 04:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qImeU-0001bM-Fm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:53:50 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qImeR-00011B-Vo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688979227; x=1720515227;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2JMY+R2zhjMIfPX9EsMtltN7iUqyvJfnKW4xh5/9eVU=;
 b=LK4DWgFdm5iZV6dLw9VHnngv346xNHLz/2WfMTFUhqn7n66QjIQU3oyP
 sze+x71Ux7x24OH5Emp3IWi+eMHSeYY90J9ryKQajVhnlDq3MIrLd3nEd
 lRgtSQ5rH+RZqrsCXH9vIfT1AEJQJmxWpmHxK3Vpg2X5HYrqvjeYyX6eX
 qYXhBo/JRnzq58F2jmUNzmPd92Wzud1T+g0Zr35ENUEZMLRU51gDmhaNM
 tsnOfyMGRi7HVvsogFqcBtrrlfzT04RRtF+GxYdD44wv3NAd3l1lkjkpR
 oEqQnTVwGlqRdvbIW2vzv9KjNzyN2AbouIe5uLyx0i2cxUxHrh4/3uM2w w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430365145"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="430365145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2023 01:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="786077348"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="786077348"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2023 01:53:32 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
Date: Tue, 11 Jul 2023 00:53:33 +0800
Message-Id: <20230710165333.17506-1-lingshan.zhu@intel.com>
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
 hw/virtio/vhost-vdpa.c | 10 ++++++++++
 hw/virtio/vhost.c      |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e..10b445f64e 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
 
 /*
  * Return one past the end of the end of section. Be careful with uint64_t
@@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
     struct vhost_vdpa *v = dev->opaque;
     int ret;
 
+    if (runstate_check(RUN_STATE_SHUTDOWN)) {
+        /*
+         * Some devices do not support this call properly,
+         * and we don't need to retrieve the indexes
+         * if it is shutting down
+         */
+        return 0;
+    }
+
     if (v->shadow_vqs_enabled) {
         ring->num = virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
         return 0;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 82394331bf..7dd90cff3a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
-        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
+        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used idx for vhost VQ %u", idx);
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
-- 
2.39.3


