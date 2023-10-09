Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F247BD1F3
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 04:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpfv0-0004Ic-9o; Sun, 08 Oct 2023 22:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfuw-0004Go-Qe; Sun, 08 Oct 2023 22:22:46 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfuh-0003cV-87; Sun, 08 Oct 2023 22:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696818151; x=1728354151;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bamSNKPwX38SaNOGbpA7g4VPeogmj9js2zOppJ2gwGg=;
 b=DsVx3UNTJzcsC4qU+ws7lA7vWAED8Z7e1a77m2xLhHVyqJgvfONZ1XGL
 Qi7SovkJXbwIdpcHgIwlhsBL5dEjpfZJOpSeaQxJnGh4nwJmHx1LQMH3o
 jykD27VVZUquxYCFo6UVfam1X3hXCSdu7HA4UYjOfvgWvMJDe+N4ZNbaH
 kzsJmG7QOcWRovVnGnrcgqOfPMs2i/HTbXQPwhjVNx5lrw5OxlrcPfJPz
 CNosTnJVDehUQFB67GffNQX+SK1G06D8Ob6s9IHLwZMGIPcnj+VbFXBoo
 eDOAr9w49tAwnKmKZ5Z7CfrngZIB/m8SBFItjDbFbkYfFQ3w0qLH/yqyZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387916672"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="387916672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752860853"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="752860853"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
Subject: [PATCH 2/3] vfio/ap: Remove pointless apdev variable
Date: Mon,  9 Oct 2023 10:20:47 +0800
Message-Id: <20231009022048.35475-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009022048.35475-1-zhenzhong.duan@intel.com>
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No need to double-cast, call VFIO_AP_DEVICE() on DeviceState.

No functional changes.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 22e564f4f7..e083a19eac 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -156,8 +156,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     int ret;
     Error *err = NULL;
-    APDevice *apdev = AP_DEVICE(dev);
-    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
+    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
     vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
@@ -195,8 +194,7 @@ error:
 
 static void vfio_ap_unrealize(DeviceState *dev)
 {
-    APDevice *apdev = AP_DEVICE(dev);
-    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
+    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
     vfio_detach_device(&vapdev->vdev);
@@ -211,8 +209,7 @@ static Property vfio_ap_properties[] = {
 static void vfio_ap_reset(DeviceState *dev)
 {
     int ret;
-    APDevice *apdev = AP_DEVICE(dev);
-    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
+    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
 
     ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
     if (ret) {
-- 
2.34.1


