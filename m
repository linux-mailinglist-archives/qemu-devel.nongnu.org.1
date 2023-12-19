Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C314819046
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfLh-0000UY-2N; Tue, 19 Dec 2023 14:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKP-0007cf-H1
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:38 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKM-0007sc-PK
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmGw2jPpz4xCp;
 Wed, 20 Dec 2023 06:00:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmGq5MF0z4wc3;
 Wed, 20 Dec 2023 06:00:19 +1100 (AEDT)
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
Subject: [PULL 41/47] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Date: Tue, 19 Dec 2023 19:56:37 +0100
Message-ID: <20231219185643.725448-42-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Some of the VFIODevice initializations is in vfio_realize,
move all of them in vfio_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 445d58c8e59b0a00a8336d092c2b8cec7e39b396..87405584d774810c8349825fafec34945a915121 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2969,9 +2969,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vfio_device_get_name(vbasedev, errp) < 0) {
         return;
     }
-    vbasedev->ops = &vfio_pci_ops;
-    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
-    vbasedev->dev = DEVICE(vdev);
 
     /*
      * Mediated devices *might* operate compatibly with discarding of RAM, but
@@ -3320,6 +3317,7 @@ static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
                                   "bootindex", NULL,
@@ -3328,7 +3326,11 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
-    vdev->vbasedev.fd = -1;
+
+    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
+    vbasedev->ops = &vfio_pci_ops;
+    vbasedev->dev = DEVICE(vdev);
+    vbasedev->fd = -1;
 
     vdev->nv_gpudirect_clique = 0xFF;
 
-- 
2.43.0


