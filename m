Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01251819050
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfLk-0000eQ-EH; Tue, 19 Dec 2023 14:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKn-0007ny-VF
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:54 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKY-0007tg-ED
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmH65cK3z4xSQ;
 Wed, 20 Dec 2023 06:00:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmH217Yrz4wc3;
 Wed, 20 Dec 2023 06:00:29 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 43/47] vfio/ap: Move VFIODevice initializations in
 vfio_ap_instance_init
Date: Tue, 19 Dec 2023 19:56:39 +0100
Message-ID: <20231219185643.725448-44-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some of the VFIODevice initializations is in vfio_ap_realize,
move all of them in vfio_ap_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index f180e4a32aa00f391f02e49b6c1bc2e8ebd2fecb..95fe7cd98b6fdad5d8ca12a798f9aff91ca5b3f4 100644
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
2.43.0


