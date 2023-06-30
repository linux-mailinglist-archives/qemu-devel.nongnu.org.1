Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15832743418
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bX-0008K1-BD; Fri, 30 Jun 2023 01:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bK-0008Ej-5W
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bI-0004am-Dx
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHV0SHfz4wpQ;
 Fri, 30 Jun 2023 15:23:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHQ6p4Pz4wZy;
 Fri, 30 Jun 2023 15:23:14 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Longpeng <longpeng2@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/16] vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI
 retry path
Date: Fri, 30 Jun 2023 07:22:30 +0200
Message-ID: <20230630052235.1934154-12-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de12..8fb2c53a63bf 100644
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
2.41.0


