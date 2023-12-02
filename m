Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF3A801B46
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kvk-0004Jf-43; Sat, 02 Dec 2023 03:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KvY-0004I8-Id
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:43 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KvV-0004wL-Pz
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:40 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1faf56466baso896786fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504035; x=1702108835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nifxH5Ik7WtdTWPOluQ6Dk90tFkOKKIHCCiZQjqggm0=;
 b=tKWyFLVGdx5JF3IoLtjdPuhpXwKcx7LRFR109SjAQ9Mcwxq6WMZ7Ow/RCrEpcsRjB/
 D9jQS7n5LzqudmvbtBBcTKKXkvpKUifuQf01ZqHDPpofgGdRGiGHcQo9+mtkjuypcEUI
 vPTexbgskTqp3Z/ZJ2q2uQO0geiKB1YnIBiPSMQs4oIuS/0GhvGMSCzxmd04LzDQey8j
 QGR/sMEZbK2Mapxbydh1WaegAr3ip6+nxNNbvEZLZFJpefoSuSxd2/8i4kyS22vohlCO
 TEP7kDRBacHfVxEGD9WHNBUJKXNtj6Jg4JYXaXfwwphrfX3/mgwjPqxPf8grc1sJ5RO6
 cjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504035; x=1702108835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nifxH5Ik7WtdTWPOluQ6Dk90tFkOKKIHCCiZQjqggm0=;
 b=TdhhrbSVGUEedS4XaxMX5PKqTlGz73uW3qLNsg32c/jiVWyHlIgGpKWaawLA8TxgpF
 1yWdkBlidGqL0HrkSfJZwxPFEGkDZ49UWkh7kOGAbJhwI+8r2X61KXF+GHFVFVBNQN9u
 KbaQ61b8FFQVzc/G5RVeGkVC3RYOSf/cX2zd5f1kUVtQl5sfMMDbWnX32zKnLO92B5Wu
 vVMRsI9RMVfpV4/e06itNcFuNDeqLURLnuSHONSWtkjAKU91zgzUsh42XHgQUcBAH1F7
 6bQtShXpP5t0WhjO5VZINWOHUqbc9t8VMDJJbAvBu08rUU7bLhAVpO3Edptbq5VzIX7t
 BmaA==
X-Gm-Message-State: AOJu0Yw+S4gifJCKsCgRCC/nCQphYHgpPjkNR0lXYs7rmVsI5Qp9dW7u
 SQRWSK18VS+k5DyZNVbnlBhLVQ==
X-Google-Smtp-Source: AGHT+IFvn1mUUHFyNEu1N1UpK1OajUfnJSAZsNIBLWwj+zcI6v2p0dT2kmY8PUL5XcXsJ3Fj8e5EAA==
X-Received: by 2002:a05:6870:f78e:b0:1fb:75b:2fb5 with SMTP id
 fs14-20020a056870f78e00b001fb075b2fb5mr1236316oab.76.1701504035166; 
 Sat, 02 Dec 2023 00:00:35 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 z23-20020a17090a015700b00285be64e529sm404492pje.39.2023.12.02.00.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:24 +0900
Subject: [PATCH 01/14] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-1-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface.

Instead of inspecting QDict, inspect PCIDevice::rom_bar.
PCIDevice::rom_bar is changed to have -1 by the default to tell rombar
is explicitly enabled. It is consistent with other properties like addr
and romsize.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 3 +--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..5b6436992f 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return d->rom_bar && d->rom_bar != -1;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c49417abb2..53c59a5b9f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b6..bc29ce9194 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1008,7 +1008,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1042,7 +1041,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.0


