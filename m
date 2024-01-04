Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB070823C8D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 08:18:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLHxY-0001oW-KF; Thu, 04 Jan 2024 02:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <szy0127@sjtu.edu.cn>)
 id 1rLHxU-0001nQ-Jh
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 02:16:04 -0500
Received: from smtp238.sjtu.edu.cn ([202.120.2.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <szy0127@sjtu.edu.cn>)
 id 1rLHxR-0002Bb-4f
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 02:16:03 -0500
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
 by smtp238.sjtu.edu.cn (Postfix) with ESMTPS id C55628569;
 Thu,  4 Jan 2024 15:15:40 +0800 (CST)
Received: from mstore135.sjtu.edu.cn (unknown [10.118.0.135])
 by mta91.sjtu.edu.cn (Postfix) with ESMTP id 9719B37C8F4;
 Thu,  4 Jan 2024 15:15:40 +0800 (CST)
Date: Thu, 4 Jan 2024 15:15:40 +0800 (CST)
From: =?utf-8?B?5rKI5ZOy6LWf?= <szy0127@sjtu.edu.cn>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, david@redhat.com
Message-ID: <799810807.232349.1704352540541.JavaMail.zimbra@sjtu.edu.cn>
Subject: [PATCH] hw/virtio: Add ioeventfd option for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.120.40.82]
X-Mailer: Zimbra 10.0.5_GA_4574 (ZimbraWebClient - GC120 (Win)/10.0.5_GA_4574)
Thread-Index: vsyzaVr5EyRnaKpEfYhyuhv2dZan8Q==
Thread-Topic: hw/virtio: Add ioeventfd option for balloon
Received-SPF: pass client-ip=202.120.2.238; envelope-from=szy0127@sjtu.edu.cn;
 helo=smtp238.sjtu.edu.cn
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SORBS_WEB=1.5,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Traditional mmio in balloon makes Qemu do balloon inflation in the same
thread as vcpu thread. In a CPU overcommitment scenario, host may run
more than one vcpu threads on one host CPU, which makes
madvise_dontneed_free() wait for a long time due to the function
cond_resched() at host side.

If using SEV/ES and the kernel provided by AMD, the overhead will
become even much larger.(From 90s to 1400s when reclaming 4GB)

With ioeventfd, the thread for host to do balloon inflation will
be separated from the VCPU thread, leading to better performance
for the whole process of balloon inflation.(1400s to 263s 
in SEV CPU overcommitment scenario)

As a para-virtual solution, balloon serves for host so the process
of inflation in host needs to run on a host iothread instead of a guest
VCPU thread.

Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
---
 hw/virtio/virtio-balloon-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index ce2645b..7195322 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -35,6 +35,12 @@ struct VirtIOBalloonPCI {
     VirtIOBalloon vdev;
 };
 
+static Property virtio_balloon_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+            VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
@@ -51,6 +57,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = virtio_balloon_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, virtio_balloon_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
--
2.34.1

