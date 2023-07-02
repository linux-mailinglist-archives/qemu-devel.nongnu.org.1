Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3120744F98
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SH-0000jN-4r; Sun, 02 Jul 2023 14:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rr-0000cp-Ov; Sun, 02 Jul 2023 14:05:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rp-0005Ix-Vz; Sun, 02 Jul 2023 14:05:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4CA610DF2;
 Sun,  2 Jul 2023 21:04:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 06D4011206;
 Sun,  2 Jul 2023 21:04:53 +0300 (MSK)
Received: (nullmailer pid 2122378 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Longpeng <longpeng2@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 63/65] vfio/pci: Call vfio_prepare_kvm_msi_virq_batch()
 in MSI retry path
Date: Sun,  2 Jul 2023 21:04:36 +0300
Message-Id: <20230702180439.2122316-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

When vfio_enable_vectors() returns with less than requested nr_vectors
we retry with what kernel reported back. But the retry path doesn't
call vfio_prepare_kvm_msi_virq_batch() and this results in,

qemu-system-aarch64: vfio: Error: Failed to enable 4 MSI vectors, retry with 1
qemu-system-aarch64: ../hw/vfio/pci.c:602: vfio_commit_kvm_msi_virq_batch: Assertion `vdev->defer_kvm_irq_routing' failed

Fixes: dc580d51f7dd ("vfio: defer to commit kvm irq routing when enable msi/msix")
Reviewed-by: Longpeng <longpeng2@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit c17408892319712c12357e5d1c6b305499c58c2a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d5670c163e..4773cc1f2b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -663,6 +663,8 @@ static void vfio_msi_enable(VFIOPCIDevice *vdev)
 
     vfio_disable_interrupts(vdev);
 
+    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
+retry:
     /*
      * Setting vector notifiers needs to enable route for each vector.
      * Deferring to commit the KVM routes once rather than per vector
@@ -670,8 +672,6 @@ static void vfio_msi_enable(VFIOPCIDevice *vdev)
      */
     vfio_prepare_kvm_msi_virq_batch(vdev);
 
-    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
-retry:
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
-- 
2.39.2


