Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44578452B8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 09:29:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVSRx-00009P-OF; Thu, 01 Feb 2024 03:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVSRu-0008RD-NS
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVSRr-0005kt-No
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706776166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FlepMDmt6WiEO6jw75z1Q+ST9CX/bsmyShHy7vV8hKM=;
 b=SB9ANI0IBhaQ+1FRvH+Doyo7xgxYtffPqM0o7KUnbPDK3FDYXN2I3DbWSFbLmLMRPn4VyZ
 orAHJOp8FinbTrPymU5SR9l929s4Q1LvaEgkTdYjhneztW3oi2+gsu3DZCyUuBfFSBXqrS
 /akgbslRPSP6Abv6Zr278EAh/rz6AIs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-lsCoCZvVPnipLNmxWmNISA-1; Thu,
 01 Feb 2024 03:29:23 -0500
X-MC-Unique: lsCoCZvVPnipLNmxWmNISA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71AAF28EC101;
 Thu,  1 Feb 2024 08:29:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 122C3492BE2;
 Thu,  1 Feb 2024 08:29:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org,
	Miroslav Rezanina <mrezanin@redhat.com>
Subject: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
Date: Thu,  1 Feb 2024 09:29:16 +0100
Message-ID: <20240201082916.20857-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

For distros like downstream RHEL, it would be helpful to allow to disable
the CompactFlash device. For making this possible, we need a separate
Kconfig switch for this device, and the code should reside in a separate
file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/qdev-ide.h  | 41 ++++++++++++++++++++++++++++++++
 hw/ide/cf.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ide/qdev.c      | 51 ++--------------------------------------
 hw/ide/Kconfig     |  4 ++++
 hw/ide/meson.build |  1 +
 5 files changed, 106 insertions(+), 49 deletions(-)
 create mode 100644 hw/ide/qdev-ide.h
 create mode 100644 hw/ide/cf.c

diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
new file mode 100644
index 0000000000..3dd977466c
--- /dev/null
+++ b/hw/ide/qdev-ide.h
@@ -0,0 +1,41 @@
+/*
+ * ide bus support for qdev.
+ *
+ * Copyright (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QDEV_IDE_H
+#define QDEV_IDE_H
+
+#include "hw/qdev-properties.h"
+#include "hw/block/block.h"
+#include "hw/ide/internal.h"
+
+typedef struct IDEDrive {
+    IDEDevice dev;
+} IDEDrive;
+
+#define DEFINE_IDE_DEV_PROPERTIES()                     \
+    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
+    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
+    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
+    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
+    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
+
+void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
+
+#endif
diff --git a/hw/ide/cf.c b/hw/ide/cf.c
new file mode 100644
index 0000000000..0b4bb57591
--- /dev/null
+++ b/hw/ide/cf.c
@@ -0,0 +1,58 @@
+/*
+ * ide CompactFlash support
+ *
+ * This code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ide/qdev-ide.h"
+#include "qapi/qapi-types-block.h"
+
+static void ide_cf_realize(IDEDevice *dev, Error **errp)
+{
+    ide_dev_initfn(dev, IDE_CFATA, errp);
+}
+
+static Property ide_cf_properties[] = {
+    DEFINE_IDE_DEV_PROPERTIES(),
+    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
+    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
+                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ide_cf_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
+
+    k->realize  = ide_cf_realize;
+    dc->fw_name = "drive";
+    dc->desc    = "virtual CompactFlash card";
+    device_class_set_props(dc, ide_cf_properties);
+}
+
+static const TypeInfo ide_cf_info = {
+    .name          = "ide-cf",
+    .parent        = TYPE_IDE_DEVICE,
+    .instance_size = sizeof(IDEDrive),
+    .class_init    = ide_cf_class_init,
+};
+
+static void ide_cf_register_type(void)
+{
+    type_register_static(&ide_cf_info);
+}
+
+type_init(ide_cf_register_type)
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 1b3b4da01d..a2f2d0ea08 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -24,12 +24,9 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/ide/qdev-ide.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "hw/block/block.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "qapi/visitor.h"
@@ -158,11 +155,7 @@ int ide_get_bios_chs_trans(BusState *bus, int unit)
 
 /* --------------------------------- */
 
-typedef struct IDEDrive {
-    IDEDevice dev;
-} IDEDrive;
-
-static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
+void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
@@ -283,19 +276,6 @@ static void ide_cd_realize(IDEDevice *dev, Error **errp)
     ide_dev_initfn(dev, IDE_CD, errp);
 }
 
-static void ide_cf_realize(IDEDevice *dev, Error **errp)
-{
-    ide_dev_initfn(dev, IDE_CFATA, errp);
-}
-
-#define DEFINE_IDE_DEV_PROPERTIES()                     \
-    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
-    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
-    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
-    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
-    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
-
 static Property ide_hd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
@@ -346,32 +326,6 @@ static const TypeInfo ide_cd_info = {
     .class_init    = ide_cd_class_init,
 };
 
-static Property ide_cf_properties[] = {
-    DEFINE_IDE_DEV_PROPERTIES(),
-    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
-    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
-                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ide_cf_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
-
-    k->realize  = ide_cf_realize;
-    dc->fw_name = "drive";
-    dc->desc    = "virtual CompactFlash card";
-    device_class_set_props(dc, ide_cf_properties);
-}
-
-static const TypeInfo ide_cf_info = {
-    .name          = "ide-cf",
-    .parent        = TYPE_IDE_DEVICE,
-    .instance_size = sizeof(IDEDrive),
-    .class_init    = ide_cf_class_init,
-};
-
 static void ide_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -396,7 +350,6 @@ static void ide_register_types(void)
     type_register_static(&ide_bus_info);
     type_register_static(&ide_hd_info);
     type_register_static(&ide_cd_info);
-    type_register_static(&ide_cf_info);
     type_register_static(&ide_device_type_info);
 }
 
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index dd85fa3619..b93d6743d5 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -57,3 +57,7 @@ config IDE_SII3112
     bool
     select IDE_PCI
     select IDE_QDEV
+
+config IDE_CF
+    bool
+    default y if IDE_QDEV
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index e050eef942..d2e5b45c9e 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
 system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
+system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
 system_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
 system_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
 system_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
-- 
2.43.0


