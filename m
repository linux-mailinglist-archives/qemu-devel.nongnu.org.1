Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB507BD3CA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:50:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpk4y-0006Qh-Vq; Mon, 09 Oct 2023 02:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk4w-0006Ps-ED
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:22 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk4u-0007Gy-Rd
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S3qQ244hcz4xWc;
 Mon,  9 Oct 2023 17:49:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3qPz69DZz4xWP;
 Mon,  9 Oct 2023 17:49:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/6] vfio/pci: rename vfio_put_device to vfio_pci_put_device
Date: Mon,  9 Oct 2023 08:48:56 +0200
Message-ID: <20231009064900.1465361-3-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009064900.1465361-1-clg@redhat.com>
References: <20231009064900.1465361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=qD0P=FX=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vfio_put_device() is a VFIO PCI specific function, rename it with
'vfio_pci' prefix to avoid confusing.

No functional change.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3b2ca3c24ca2ed91c03b5c6bef65bb5a0fb0298a..b2d5010b9f0effbe85a3f57b43e282e837b6383f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2826,7 +2826,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     }
 }
 
-static void vfio_put_device(VFIOPCIDevice *vdev)
+static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     g_free(vdev->vbasedev.name);
     g_free(vdev->msix);
@@ -3317,7 +3317,7 @@ static void vfio_instance_finalize(Object *obj)
      *
      * g_free(vdev->igd_opregion);
      */
-    vfio_put_device(vdev);
+    vfio_pci_put_device(vdev);
     vfio_put_group(group);
 }
 
-- 
2.41.0


