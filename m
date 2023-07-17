Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8705755FB2
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 11:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLKmM-00022Q-F7; Mon, 17 Jul 2023 05:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qLKmJ-00021p-RU
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:44:27 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qLKmH-0006PS-DW
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 05:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689587065; x=1721123065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hwdvJ8BR9IZZL/dpbQmOJvAnME6Empxc8mFkr/gOwgs=;
 b=TLrKkEs0hZEY9TIHR7ODhWtm6BGOJdIXdV2dhPrMhr7cuNi8XxycOAGa
 jkHT5uGt05FmCDO4gvT76CM+jJlAug85cphgNJH5q4yu39MeH4Rmm2b/i
 /6SgbfKaiXtDuPop+yLA7omL2RkhqbQxHceOPnLuvPu1WngTY9FhcAbFv
 jQ+514mPUPM/7Kd7tVO26E7lg6NyC+x0cUoiiADuEDhUR6RP7KcFd9a8D
 qZtZou2uaq16VmsfUsR+IdiF8xT6/Vt9Bdj5kydI7qt7ZwEEsI5ItM0zr
 HJC5rqrdr3fgtzM8xy1Wr+EUIcCCiqeYafapguOnZ/MuoiZJ56pXZfTkT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363353533"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; d="scan'208";a="363353533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 02:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="813255207"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; d="scan'208";a="813255207"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 02:44:16 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] vhost: disable VHOST_OPS_DEBUG by default
Date: Tue, 18 Jul 2023 01:44:05 +0800
Message-Id: <20230717174405.293668-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=lingshan.zhu@intel.com;
 helo=mga11.intel.com
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

This commit disables VHOST_OPS_DEBUG by default
These information are ususally only required in development
environment

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 hw/virtio/vhost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 82394331bf..ec435a3079 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -29,7 +29,9 @@
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
-#define _VHOST_DEBUG 1
+
+/* uncomment macro _VHOST_DEBUG to enable VHOST_OPS_DEBUG */
+/* #define _VHOST_DEBUG 1 */
 
 #ifdef _VHOST_DEBUG
 #define VHOST_OPS_DEBUG(retval, fmt, ...) \
@@ -1318,7 +1320,10 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
     struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
                                               error_notifier);
     struct vhost_dev *dev = vq->dev;
+
+#ifdef _VHOST_DEBUG
     int index = vq - dev->vqs;
+#endif
 
     if (event_notifier_test_and_clear(n) && dev->vdev) {
         VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
-- 
2.39.3


