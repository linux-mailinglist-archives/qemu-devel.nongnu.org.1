Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136C7EBECE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:49:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BZL-0003Iv-GP; Wed, 15 Nov 2023 03:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZJ-0003IX-Ab; Wed, 15 Nov 2023 03:48:17 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZH-0007uT-Mu; Wed, 15 Nov 2023 03:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700038096; x=1731574096;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vnso+25nvjyRZ+a3ImY5eYjjdq0AgeyWNE86VlUd59Y=;
 b=VcdGfEMemTRpjfvQmI+9amFo91mj8bp3eox5lTuOAim8Dj22Ye3JIClO
 VA6ZwjXm+bFs+Oy5OENkqV+5RzyHvID5MVHBPYIltU5kXdMycTWqubygN
 5kvqWyuVN4zCt1b+SahwvO6mniAwocVjm7IAbY8ESUWoRanqGOke46B/+
 kJWroeI5EWKQMoT4uyiLlUNvpcEuur/ESTTrI5vJFfKN4+rSp9hS5Ilhe
 J1+ulRblL85YIYoxfg7l2ngnBh9x1KroHKEY/RXqxfCtQZmRJLLcFn9f/
 st0tEiQgSh0BquyqOyFFmWpB+yyCpvLAeuLLnpyhBVwfwNQplp9q2+GoJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12385059"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="12385059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012199443"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="1012199443"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:48:04 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH 3/4] vfio/ap: Move VFIODevice initializations in
 vfio_ap_instance_init
Date: Wed, 15 Nov 2023 16:32:17 +0800
Message-Id: <20231115083218.1973627-4-zhenzhong.duan@intel.com>
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

Some of the VFIODevice initializations is in vfio_ap_realize,
move all of them in vfio_ap_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index b21f92291e..31ea9644c5 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -164,18 +164,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    vbasedev->ops = &vfio_ap_ops;
-    vbasedev->type = VFIO_DEVICE_TYPE_AP;
-    vbasedev->dev = dev;
-
-    /*
-     * vfio-ap devices operate in a way compatible with discarding of
-     * memory in RAM blocks, as no pages are pinned in the host.
-     * This needs to be set before vfio_get_device() for vfio common to
-     * handle ram_block_discard_disable().
-     */
-    vapdev->vdev.ram_block_discard_allowed = true;
-
     ret = vfio_attach_device(vbasedev->name, vbasedev,
                              &address_space_memory, errp);
     if (ret) {
@@ -236,8 +224,20 @@ static const VMStateDescription vfio_ap_vmstate = {
 static void vfio_ap_instance_init(Object *obj)
 {
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
+    VFIODevice *vbasedev = &vapdev->vdev;
 
-    vapdev->vdev.fd = -1;
+    vbasedev->type = VFIO_DEVICE_TYPE_AP;
+    vbasedev->ops = &vfio_ap_ops;
+    vbasedev->dev = DEVICE(vapdev);
+    vbasedev->fd = -1;
+
+    /*
+     * vfio-ap devices operate in a way compatible with discarding of
+     * memory in RAM blocks, as no pages are pinned in the host.
+     * This needs to be set before vfio_get_device() for vfio common to
+     * handle ram_block_discard_disable().
+     */
+    vbasedev->ram_block_discard_allowed = true;
 }
 
 #ifdef CONFIG_IOMMUFD
-- 
2.34.1


