Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37921924D8E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 04:13:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpUW-0005dA-3q; Tue, 02 Jul 2024 22:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOpUT-0005cP-1T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOpUN-0001lv-8E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxK_Cfs4Rm2FwAAA--.1104S3;
 Wed, 03 Jul 2024 10:12:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMWds4RmPSQ5AA--.57057S4; 
 Wed, 03 Jul 2024 10:12:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/intc/loongarch_ipi: Add loongarch ipi support
Date: Wed,  3 Jul 2024 10:12:44 +0800
Message-Id: <20240703021245.3752786-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703021245.3752786-1-maobibo@loongson.cn>
References: <20240703021245.3752786-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMWds4RmPSQ5AA--.57057S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Loongarch ipi is added here and ipi is emulated in userspace when
running in kvm mode. It inherits from TYPE_LOONGSON_IPI_COMMON class,
and two interfaces get_iocsr_as() and cpu_by_arch_id() is added
for Loongarch 3A5000 machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 80 +++++++++++++++++++++++++++++++++
 include/hw/intc/loongarch_ipi.h | 33 ++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 include/hw/intc/loongarch_ipi.h

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
new file mode 100644
index 0000000000..91689c35c0
--- /dev/null
+++ b/hw/intc/loongarch_ipi.c
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongarch_ipi.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "target/loongarch/cpu.h"
+#include "trace.h"
+
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
+    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
+
+static int archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
+        archid_cmp);
+
+    return found_cpu;
+}
+
+static CPUState *get_cpu_by_archid(int64_t arch_id)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    CPUArchId *archid;
+
+    archid = find_cpu_by_archid(machine, arch_id);
+    if (archid) {
+        return CPU(archid->cpu);
+    }
+
+    return NULL;
+}
+
+static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+
+    licc->get_iocsr_as = get_iocsr_as;
+    licc->cpu_by_arch_id = get_cpu_by_archid;
+}
+
+static const TypeInfo loongarch_ipi_info = {
+    .name          = TYPE_LOONGARCH_IPI,
+    .parent        = TYPE_LOONGSON_IPI_COMMON,
+    .instance_size = sizeof(LoongarchIPIState),
+    .class_size    = sizeof(LoongarchIPIClass),
+    .class_init    = loongarch_ipi_class_init,
+};
+
+static void loongarch_ipi_register_types(void)
+{
+    type_register_static(&loongarch_ipi_info);
+}
+
+type_init(loongarch_ipi_register_types)
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
new file mode 100644
index 0000000000..451bbcff5c
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongarch ipi interrupt header files
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_IPI_H
+#define HW_LOONGARCH_IPI_H
+
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
+#include "hw/sysbus.h"
+
+#define TYPE_LOONGARCH_IPI  "loongarch_ipi"
+typedef struct LoongarchIPIClass LoongarchIPIClass;
+typedef struct LoongarchIPIState LoongarchIPIState;
+DECLARE_OBJ_CHECKERS(LoongarchIPIState, LoongarchIPIClass,
+                     LOONGARCH_IPI, TYPE_LOONGARCH_IPI)
+
+struct LoongarchIPIState {
+    LoongsonIPICommonState parent_obj;
+};
+
+struct LoongarchIPIClass {
+    /*< private >*/
+    LoongsonIPICommonClass parent_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+};
+
+#endif
-- 
2.39.3


