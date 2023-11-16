Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E9C7EDCBC
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XWa-0004qP-CP; Thu, 16 Nov 2023 03:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWZ-0004pt-3s; Thu, 16 Nov 2023 03:14:55 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWX-0008Vt-DP; Thu, 16 Nov 2023 03:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700122493; x=1731658493;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YVbEKZd66Jom2GOiFJWFfBxG+jh9Pn412EcUVdE1mx8=;
 b=Y36fugL+C+pCHTripXAVWBwXTeNEexlW0aLfgbyY2rOP5loY2M9avKgc
 csi0zTx6x8oP6TkbJjX5hDSxi+C/iUskB5E+5p3/I5I7ojqWVgHJJ4vAP
 kOG/bC9NyNZZ9Zugovsw/DIdtMIj9Da+lelpHw2+NWBNxkFmwXY9otb5T
 qAah66VfdgmUrEEaWYlz7N4nf/PhtpBagnSmNrdYF4Ezi+gjgu8VBGk2t
 V6mtTnw8asBinpQm6vSiiLK0lUr7+jyR/ocCbbI8DU1HOmgcgYGXDW2q6
 v8eLo6nrbOZQ35QAorCWwXI2VMQnYT6RuhfDyShQzPyu9/jt4j7l5S/U2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389898265"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="389898265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768846144"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="768846144"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:46 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH v2 3/5] vfio/ap: Move VFIODevice initializations in
 vfio_ap_instance_init
Date: Thu, 16 Nov 2023 15:59:07 +0800
Message-Id: <20231116075909.1987656-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
References: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Some of the VFIODevice initializations is in vfio_ap_realize,
move all of them in vfio_ap_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
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


