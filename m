Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322F709A87
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tm-000724-55; Fri, 19 May 2023 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tf-0006rx-S1
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tc-0003t1-DJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yp/tSHUOqsrSNAJ6KI0EHry6cJp6FlWfqU2oOq6BEB4=;
 b=SEurRrvXPKROGRP84fPm9IGIVXXXLn03VmEogmhBVELahxw8DdRfmGhNMytXDPurS6zuyx
 V8yR9P2QCYynQZCrbPvbbgWL/N68NQZlh7j/Rp15Dmu07TEmDgsd1GttkWtYntZL+JcVI0
 shyRbvrN9Kvaz/Y8GFyhkiagZ4pPNCA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-iyBweUZSMBCPToCXCRdcvA-1; Fri, 19 May 2023 10:52:54 -0400
X-MC-Unique: iyBweUZSMBCPToCXCRdcvA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f39ae34494so1701277e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507968; x=1687099968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yp/tSHUOqsrSNAJ6KI0EHry6cJp6FlWfqU2oOq6BEB4=;
 b=eK/7aml+1N1vyTsh53mKGKytOUq0JWVtaQzo6Zl8g+f/8UQxf+Shk6opv+wI4bXWQy
 lasEQS8oOF48iOPaJT12/9hxZ4QXlgCKVGlh4ol0jJRoEI0p4Ze+Zp1favCtNczqx0Pw
 42IVc6s3KrYhF1ft76e95EGKfQ7ZJIFZAwoAs0RhIbnYG0TqNZ9TZcMoqvnvE/X62P6/
 udiPjwtU9sqh5FrNEwdYumYr5apIeoQcTUQyT8jAu8FTYCDBBnWIDRfRG2V71oO2Ck+/
 d4Vpwcsluih8UB9L0KtTNfkRCX1F2ucWDFfP3PkHYBPe4uCzW8kqOndo/U5FVZGlAK5f
 0fwg==
X-Gm-Message-State: AC+VfDyZ7nywx6xny12hGRGwTpdea+JOZbDDKqfw1UF4prb29BFe3ig8
 XrySUeScQia2PWtZOHVJvlOA5dX4ymXDDB0vZ+nMU4LUwgbYk7cw6wPHpFgXjuiGPB2k1IGJ+o8
 DaDRW9QlJ9D+ZPZPU4hGAyMv7YDyVLR61vX3dD4/ZxH6b5hQMVhKUrXatPLhKBN+yT9eD
X-Received: by 2002:a05:6512:92c:b0:4f1:4fa4:4f56 with SMTP id
 f12-20020a056512092c00b004f14fa44f56mr757237lft.17.1684507967978; 
 Fri, 19 May 2023 07:52:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76BGAvkBCfB6fTrCdsxWWVg21gnok83BQl+H84cA5GH5PkjOkxDbZYwg4nWqQOl/UXS+0bpQ==
X-Received: by 2002:a05:6512:92c:b0:4f1:4fa4:4f56 with SMTP id
 f12-20020a056512092c00b004f14fa44f56mr757231lft.17.1684507967638; 
 Fri, 19 May 2023 07:52:47 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 p4-20020a19f004000000b004f39868bef1sm616602lfc.209.2023.05.19.07.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:47 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PULL 35/40] virtio-pci: add handling of PCI ATS and Device-TLB
 enable/disable
Message-ID: <206e91d143301414df2deb48a411e402414ba6db.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio-pci.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f6b38f7e9c..af86ed7249 100644
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
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 02fb84a8fa..edbc0daa18 100644
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
-- 
MST


