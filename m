Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2313744C3A
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 06:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFos0-0007r5-1B; Sun, 02 Jul 2023 00:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qForw-0007qI-Vd; Sun, 02 Jul 2023 00:39:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qForv-0002U7-4L; Sun, 02 Jul 2023 00:39:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1818A10D1C;
 Sun,  2 Jul 2023 07:39:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 60FA4110AB;
 Sun,  2 Jul 2023 07:39:08 +0300 (MSK)
Received: (nullmailer pid 2090172 invoked by uid 1000);
 Sun, 02 Jul 2023 04:39:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 48/49] vfio/pci: Fix a segfault in vfio_realize
Date: Sun,  2 Jul 2023 07:38:48 +0300
Message-Id: <20230702043850.2090131-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

The kvm irqchip notifier is only registered if the device supports
INTx, however it's unconditionally removed in vfio realize error
path. If the assigned device does not support INTx, this will cause
QEMU to crash when vfio realize fails. Change it to conditionally
remove the notifier only if the notify hook is setup.

Before fix:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
Connection closed by foreign host.

After fix:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
Error: vfio 0000:81:11.1: xres and yres properties require display=on
(qemu)

Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 357bd7932a136613d700ee8bc83e9165f059d1f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 939dcc3d4a..63eda94af7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3159,7 +3159,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
 out_deregister:
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
-    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    if (vdev->irqchip_change_notifier.notify) {
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
-- 
2.39.2


