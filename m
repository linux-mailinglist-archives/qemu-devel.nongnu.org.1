Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B57F27FF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:50:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MQj-0001d8-VM; Tue, 21 Nov 2023 03:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MQd-0000zk-DM
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:19 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MQZ-0002Dg-SI
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556495; x=1732092495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vBzP3WlnfEWRiydsgFq9tEsSz3B2gVoYx0Pa8U2lpLY=;
 b=U4k8NwIsN+QVaJyRkwZYbNkN0u1xkhoz3yI7HPmsRK2Unvt2FHmIIrrK
 yLDvecsvDnxSSV9sGHRoFKA0OkqMlJjjEUP3Q0W9TuyhYYZYMI08lEL7n
 j8a5KxtTJGD5UtQcTa16GWhCFqgU9rdZdwQ1ORk0mCFvj4ZGzap/GNw2v
 pJ/Gzgcy+VGmnNGHtssHgwtDRn21RucVU0lLh0xPfNAUpfQT+1/H6ype3
 E6+TqTZ/PinL9ZvF6uy3MZa/mobMrPfyXAUbtQduSDUph17Rohrg48GRE
 gbxM0lyU810KMO3MxsH3N3FWGHLAuQHdUBq4ryJrrJ9bpfRxWkk872MNM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722314"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884125200"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884125200"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:49 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 23/27] vfio/platform: Move VFIODevice initializations in
 vfio_platform_instance_init
Date: Tue, 21 Nov 2023 16:44:22 +0800
Message-Id: <20231121084426.1286987-24-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Some of the VFIODevice initializations is in vfio_platform_realize,
move all of them in vfio_platform_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a97d9c6234..506eb8193f 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -581,10 +581,6 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
 
-    vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
-    vbasedev->dev = dev;
-    vbasedev->ops = &vfio_platform_ops;
-
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
@@ -659,8 +655,12 @@ static Property vfio_platform_dev_properties[] = {
 static void vfio_platform_instance_init(Object *obj)
 {
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
-    vdev->vbasedev.fd = -1;
+    vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
+    vbasedev->ops = &vfio_platform_ops;
+    vbasedev->dev = DEVICE(vdev);
+    vbasedev->fd = -1;
 }
 
 #ifdef CONFIG_IOMMUFD
-- 
2.34.1


