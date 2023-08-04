Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32C7708E9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IH-0000If-U7; Fri, 04 Aug 2023 15:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IG-0000I8-4v; Fri, 04 Aug 2023 15:17:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IE-0006tc-At; Fri, 04 Aug 2023 15:16:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2CF5318455;
 Fri,  4 Aug 2023 22:17:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B16751B898;
 Fri,  4 Aug 2023 22:16:49 +0300 (MSK)
Received: (nullmailer pid 1875696 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Viktor Prutyanov <viktor@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 35/63] virtio-pci: add handling of PCI ATS and
 Device-TLB enable/disable
Date: Fri,  4 Aug 2023 22:16:18 +0300
Message-Id: <20230804191647.1875608-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Viktor Prutyanov <viktor@daynix.com>

According to PCIe Address Translation Services specification 5.1.3.,
ATS Control Register has Enable bit to enable/disable ATS. Guest may
enable/disable PCI ATS and, accordingly, Device-TLB for the VirtIO PCI
device. So, raise/lower a flag and call a trigger function to pass this
event to a device implementation.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Message-Id: <20230512135122.70403-2-viktor@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 206e91d143301414df2deb48a411e402414ba6db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 247325c193..798eba9d6e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -716,6 +716,38 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     }
 }
 
+static void virtio_pci_ats_ctrl_trigger(PCIDevice *pci_dev, bool enable)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+
+    vdev->device_iotlb_enabled = enable;
+
+    if (k->toggle_device_iotlb) {
+        k->toggle_device_iotlb(vdev);
+    }
+}
+
+static void pcie_ats_config_write(PCIDevice *dev, uint32_t address,
+                                  uint32_t val, int len)
+{
+    uint32_t off;
+    uint16_t ats_cap = dev->exp.ats_cap;
+
+    if (!ats_cap || address < ats_cap) {
+        return;
+    }
+    off = address - ats_cap;
+    if (off >= PCI_EXT_CAP_ATS_SIZEOF) {
+        return;
+    }
+
+    if (range_covers_byte(off, len, PCI_ATS_CTRL + 1)) {
+        virtio_pci_ats_ctrl_trigger(dev, !!(val & PCI_ATS_CTRL_ENABLE));
+    }
+}
+
 static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
                                 uint32_t val, int len)
 {
@@ -729,6 +761,10 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
         pcie_cap_flr_write_config(pci_dev, address, val, len);
     }
 
+    if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
+        pcie_ats_config_write(pci_dev, address, val, len);
+    }
+
     if (range_covers_byte(address, len, PCI_COMMAND)) {
         if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
             virtio_set_disabled(vdev, true);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f236e94ca6..bd3092a1ab 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -155,6 +155,7 @@ struct VirtIODevice
     QLIST_HEAD(, VirtQueue) *vector_queues;
     QTAILQ_ENTRY(VirtIODevice) next;
     EventNotifier config_notifier;
+    bool device_iotlb_enabled;
 };
 
 struct VirtioDeviceClass {
@@ -212,6 +213,7 @@ struct VirtioDeviceClass {
     const VMStateDescription *vmsd;
     bool (*primary_unplug_pending)(void *opaque);
     struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
+    void (*toggle_device_iotlb)(VirtIODevice *vdev);
 };
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
-- 
2.39.2


