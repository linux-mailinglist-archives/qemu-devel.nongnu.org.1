Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B37EBECD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BZB-0003I6-Sk; Wed, 15 Nov 2023 03:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZ9-0003Hy-CZ
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:48:07 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZ7-0007nA-Ta
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700038086; x=1731574086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DXZgRlcEsVhbTjmQcjBUO2mDr+hNClUzdVf9Lc2eios=;
 b=MZHUmAeZEory7vWPmgi0iZHB0SVBeX7SGFHbbz8ze8XJ/+fihqhM8ckP
 VxF1Lz2afkanlcVVDiNIZe/FOpSBxvXUGRVb9OUX7+CZi7V7P9/sCrQ6C
 fR02aqUuWF26prQLVQgUCMIIHmvJt6ExFnpBMBUYbQS+YGej/eG1x4b4O
 n/r3Co1xx1Kf63vH0xMbmO5/AWZ76nnhPZKRBXDTAxUjf6PfMd0IIgfLZ
 JMKJIcsOiw2YXD7lHAUopOUmIpnWIIyAOdXQJknavdg0hkLFuAksZeZUP
 xTPeobzZYPmF2gkpVlHIVWRCWB7IU3QaDlgSChBzzsES9a4vwcJe05YB1 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12385050"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="12385050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012199429"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="1012199429"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:47:58 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/4] vfio/platform: Move VFIODevice initializations in
 vfio_platform_instance_init
Date: Wed, 15 Nov 2023 16:32:16 +0800
Message-Id: <20231115083218.1973627-3-zhenzhong.duan@intel.com>
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

Some of the VFIODevice initializations is in vfio_platform_realize,
move all of them in vfio_platform_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


