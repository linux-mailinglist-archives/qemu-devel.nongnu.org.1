Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E777EBECF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:49:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BZM-0003JS-4j; Wed, 15 Nov 2023 03:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZK-0003Ik-A9; Wed, 15 Nov 2023 03:48:18 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZI-0007ub-N3; Wed, 15 Nov 2023 03:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700038097; x=1731574097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4T25mDurpLt8WQ4FJZmMzpzp4n1j01lUEeg9qooKvDg=;
 b=CFmHTP/5NjS1seAJl6SWSPmcrRmn1veg1htnmWxkrM6Wv1R2N5z10ubs
 xnA0NECR2WPVmqU9qgd3Vds3xYbEg6HHoWBKG5Pf081rUmLr18DnYADaO
 yrJgkP1TO2XwXs6EKQL07nwz+IRZg9oCGukVphGrrH1WjBq3D6YJvoyfB
 h3sjSSWpgNJHlUGkMk08qBh5de2HP+K6SXxgTYvwe1SBpF1kk/HWRnqfS
 r6DvE9WNe5NpxWNaKUhZvX5qKAP4nAYTPFdSsB6kcYlYs0IfQguniHm2V
 5JnpgwUM2DJZoKb43DHt8iVJuR57rAqlMrbZgLQYJt+Disjdem/yFRn0Y A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12385068"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="12385068"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012199457"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="1012199457"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:48:09 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH 4/4] vfio/ccw: Move VFIODevice initializations in
 vfio_ccw_instance_init
Date: Wed, 15 Nov 2023 16:32:18 +0800
Message-Id: <20231115083218.1973627-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Some of the VFIODevice initializations is in vfio_ccw_realize,
move all of them in vfio_ccw_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index b116b10fe7..8de2fd809b 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -594,20 +594,6 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    vbasedev->ops = &vfio_ccw_ops;
-    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
-    vbasedev->dev = dev;
-
-    /*
-     * All vfio-ccw devices are believed to operate in a way compatible with
-     * discarding of memory in RAM blocks, ie. pages pinned in the host are
-     * in the current working set of the guest driver and therefore never
-     * overlap e.g., with pages available to the guest balloon driver.  This
-     * needs to be set before vfio_get_device() for vfio common to handle
-     * ram_block_discard_disable().
-     */
-    vbasedev->ram_block_discard_allowed = true;
-
     ret = vfio_attach_device(cdev->mdevid, vbasedev,
                              &address_space_memory, errp);
     if (ret) {
@@ -695,8 +681,22 @@ static const VMStateDescription vfio_ccw_vmstate = {
 static void vfio_ccw_instance_init(Object *obj)
 {
     VFIOCCWDevice *vcdev = VFIO_CCW(obj);
+    VFIODevice *vbasedev = &vcdev->vdev;
+
+    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
+    vbasedev->ops = &vfio_ccw_ops;
+    vbasedev->dev = DEVICE(vcdev);
+    vbasedev->fd = -1;
 
-    vcdev->vdev.fd = -1;
+    /*
+     * All vfio-ccw devices are believed to operate in a way compatible with
+     * discarding of memory in RAM blocks, ie. pages pinned in the host are
+     * in the current working set of the guest driver and therefore never
+     * overlap e.g., with pages available to the guest balloon driver.  This
+     * needs to be set before vfio_get_device() for vfio common to handle
+     * ram_block_discard_disable().
+     */
+    vbasedev->ram_block_discard_allowed = true;
 }
 
 #ifdef CONFIG_IOMMUFD
-- 
2.34.1


