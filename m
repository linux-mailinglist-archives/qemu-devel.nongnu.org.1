Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9172E551
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94ki-0001EA-Ub; Tue, 13 Jun 2023 10:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1q94kf-0001Di-PH
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:12:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1q94kd-0002ba-Ec
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:12:05 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgVpB2fHZz6J7qD;
 Tue, 13 Jun 2023 22:10:58 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:11:34 +0100
To: <alex.williamson@redhat.com>, <clg@redhat.com>
CC: <qemu-devel@nongnu.org>, <chenxiang66@hisilicon.com>,
 <longpeng2@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH] vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI retry
 path
Date: Tue, 13 Jun 2023 15:09:43 +0100
Message-ID: <20230613140943.1786-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When vfio_enable_vectors() returns with less than requested nr_vectors
we retry with what kernel reported back. But the retry path doesn't
call vfio_prepare_kvm_msi_virq_batch() and this results in,

qemu-system-aarch64: vfio: Error: Failed to enable 4 MSI vectors, retry with 1
qemu-system-aarch64: ../hw/vfio/pci.c:602: vfio_commit_kvm_msi_virq_batch: Assertion `vdev->defer_kvm_irq_routing' failed

Fixes: dc580d51f7dd ("vfio: defer to commit kvm irq routing when enable msi/msix")
Reviewed-by: Longpeng <longpeng2@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de..8fb2c53a63 100644
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
2.34.1


