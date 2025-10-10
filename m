Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4DBBCC21C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 10:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78TX-0007D9-J6; Fri, 10 Oct 2025 04:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v78TU-0007Bi-HM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:27:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v78TN-0004V3-Em
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:27:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axz79sw+hoEZsUAA--.42224S3;
 Fri, 10 Oct 2025 16:27:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxzsFpw+hos0LYAA--.56940S10;
 Fri, 10 Oct 2025 16:27:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] hw/loongarch/virt: Add property highmem-mmio-size with
 virt machine
Date: Fri, 10 Oct 2025 16:27:20 +0800
Message-Id: <20251010082720.3943996-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251010082720.3943996-1-maobibo@loongson.cn>
References: <20251010082720.3943996-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxzsFpw+hos0LYAA--.56940S10
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The default high mmio size of GPEX PCIE host controller is 64G bytes on
virt machine. If it does not meet requirements with some pass-throught HW
devices in future, it can be adjust dynamically, here adds property
highmem-mmio-size to set high mmio size.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a7299dd658..324f14c898 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/datadir.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "exec/target_page.h"
 #include "hw/boards.h"
@@ -107,6 +108,43 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     lvms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    uint64_t size = lvms->gpex.mmio64.size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem-mmio-size is not a power of 2");
+        return;
+    }
+
+    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
+        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
+        error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
+                         "than the default (%s)", sz);
+        g_free(sz);
+        return;
+    }
+
+    lvms->gpex.mmio64.size = size;
+}
+
 static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
@@ -1461,6 +1499,13 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "highmem-mmio",
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set the high memory region size "
+                                          "for PCI MMIO");
 }
 
 static const TypeInfo virt_machine_types[] = {
-- 
2.39.3


