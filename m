Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C477801B56
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwA-0004O2-OJ; Sat, 02 Dec 2023 03:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvl-0004K6-TM
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:53 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvk-0004zd-7l
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:53 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35c18e55633so12373205ab.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504051; x=1702108851;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bj8XVIcfBYxFCt7yVr0gyoBi8ZlaEENnjEghOjifY8I=;
 b=jrIIeuK9mldjdWmrTFtJDYi54EqW0GcbmzTMs1zBt8Tmrw/27Ldx1MLakuywnnherw
 kzvKASXC8CP1T0lplz4srN1ynT22Sla7W3+BiJ8TG6rU3EtrkZillHO3H08jaCVbO63n
 xLx9tMq7+NWM/DiQ5n+9nZYbm+J0YqBL1R/3pvWWp8cJGWE3FzxN47LhkEcmJ3NaXOkf
 ryAz2/aykkCTC6OM4sdT/0kQGks8en9nlm+9FCZPZQzRa5I8OXK17LepdxaJGIVHFpxK
 WF4B22VbBcansVTF00cC8EZSwikG1UNuolD+CVJjwp07ModOdAMnkCk7dlamOBI5XdX3
 LM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504051; x=1702108851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bj8XVIcfBYxFCt7yVr0gyoBi8ZlaEENnjEghOjifY8I=;
 b=bEkqj/FQiZDeHf74MaSCfQkKFkUtJ28gNLoipPKn+CNVyD8pG8IlvqkxqVMyQOhHIv
 jm51+PX0S5Kzmc8wDdgtayyqmqzjElHLPsTVbDjUEof+WCEbLtpGL01gkUTSme6WxnCO
 j0zlR8X1qZpL4gjeiPkLr32lQfPCvTH1xSKYQufbT1laNUCe2sI8X+bQEayP8x63r6Om
 9g3C51gLTKjfRKdxPqyVeDtQQvJksxSGV9n3QFhQbcImI2bLD8NY3AheabCWoITPW8sZ
 YsJ1oW2j0NNmAdfLLKsJINXweih+gkOO1IRJ5VwnEz6TZEGFHL5IHTRqgrUYiRQYZYHE
 YhBw==
X-Gm-Message-State: AOJu0YwNeESJqosECA9Hiby2vbvbl5AJb/P4yT4sMGMklE697qh6Smi4
 bGE1O2uHxvPQaUMJx2jKzsm1yg==
X-Google-Smtp-Source: AGHT+IG6Xiul2ufJptSl6rNTgX/WyEaTOhl3ssbdyNFFtxdeVXcZh8guEm61cpqewSpBe2uVM9+hZg==
X-Received: by 2002:a92:cb4d:0:b0:35d:5995:798b with SMTP id
 f13-20020a92cb4d000000b0035d5995798bmr1130440ilq.37.1701504050726; 
 Sat, 02 Dec 2023 00:00:50 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 bg6-20020a17090b0d8600b00286558ad352sm2735558pjb.8.2023.12.02.00.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:27 +0900
Subject: [PATCH 04/14] hw/pci: Add pci-failover
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-4-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pci-failover allows to create a device capable of failover without
relying on DeviceListener::hide_device(), which intrudes the
pci-device implementation from outside.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 14 ++++++++++++++
 hw/pci/pci.c                | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8e287c5414..a7bfb192e8 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -9,6 +9,11 @@ typedef struct PCIDeviceClass PCIDeviceClass;
 DECLARE_OBJ_CHECKERS(PCIDevice, PCIDeviceClass,
                      PCI_DEVICE, TYPE_PCI_DEVICE)
 
+#define TYPE_PCI_FAILOVER "pci-failover"
+typedef struct PCIFailoverClass PCIFailoverClass;
+DECLARE_CLASS_CHECKERS(PCIFailoverClass, PCI_FAILOVER, TYPE_PCI_FAILOVER)
+#define PCI_FAILOVER(obj) INTERFACE_CHECK(PciFailover, (obj), TYPE_PCI_FAILOVER)
+
 /*
  * Implemented by devices that can be plugged on CXL buses. In the spec, this is
  * actually a "CXL Component, but we name it device to match the PCI naming.
@@ -162,6 +167,15 @@ struct PCIDevice {
     uint32_t acpi_index;
 };
 
+struct PCIFailoverClass {
+    /* private */
+    InterfaceClass parent_class;
+
+    /* public */
+    bool (* set_primary)(DeviceState *dev, const QDict *device_opts,
+                         bool from_json, Error **errp);
+};
+
 static inline int pci_intx(PCIDevice *pci_dev)
 {
     return pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 53c59a5b9f..3d07246f8e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,6 +46,7 @@
 #include "hw/pci/msix.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
@@ -2050,6 +2051,40 @@ PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn)
     return bus->devices[devfn];
 }
 
+static bool pci_qdev_hide(DeviceClass *dc, const QDict *device_opts,
+                          bool from_json, Error **errp)
+{
+    const char *standby_id;
+    DeviceState *dev;
+    ObjectClass *class;
+    ObjectClass *interface;
+
+    if (!device_opts) {
+        return false;
+    }
+
+    if (!qdict_haskey(device_opts, "failover_pair_id")) {
+        return false;
+    }
+
+    standby_id = qdict_get_str(device_opts, "failover_pair_id");
+    dev = qdev_find_recursive(sysbus_get_default(), standby_id);
+    if (!dev) {
+        error_setg(errp, "failover pair not found");
+        return false;
+    }
+
+    class = object_get_class(OBJECT(dev));
+    interface = object_class_dynamic_cast(class, TYPE_PCI_FAILOVER);
+    if (!interface) {
+        error_setg(errp, "failover pair does not support failover");
+        return false;
+    }
+
+    return ((PCIFailoverClass *)interface)->set_primary(dev, device_opts,
+                                                        from_json, errp);
+}
+
 #define ONBOARD_INDEX_MAX (16 * 1024 - 1)
 
 static void pci_qdev_realize(DeviceState *qdev, Error **errp)
@@ -2653,6 +2688,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
+    k->hide = pci_qdev_hide;
     k->realize = pci_qdev_realize;
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
@@ -2861,6 +2897,12 @@ static const TypeInfo pci_device_type_info = {
     .class_base_init = pci_device_class_base_init,
 };
 
+static const TypeInfo pci_failover_type_info = {
+    .name = TYPE_PCI_FAILOVER,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(PCIFailoverClass),
+};
+
 static void pci_register_types(void)
 {
     type_register_static(&pci_bus_info);
@@ -2870,6 +2912,7 @@ static void pci_register_types(void)
     type_register_static(&cxl_interface_info);
     type_register_static(&pcie_interface_info);
     type_register_static(&pci_device_type_info);
+    type_register_static(&pci_failover_type_info);
 }
 
 type_init(pci_register_types)

-- 
2.43.0


