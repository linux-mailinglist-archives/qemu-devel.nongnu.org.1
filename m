Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC09AC4A86
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 10:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpvj-0003Fk-QN; Tue, 27 May 2025 04:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJpvZ-0003Cl-R3
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJpvR-0000ZC-AG
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:53 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxDeN5ezVoLxj+AA--.46790S3;
 Tue, 27 May 2025 16:44:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3xtyezVolPn0AA--.53554S4;
 Tue, 27 May 2025 16:44:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 02/12] hw/intc/loongarch_extioi: Add kernel irqchip save
 and restore function
Date: Tue, 27 May 2025 16:44:20 +0800
Message-Id: <20250527084430.3468174-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250527084430.3468174-1-maobibo@loongson.cn>
References: <20250527084430.3468174-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3xtyezVolPn0AA--.53554S4
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add save and store funtction if kvm_irqchip_in_kernel() return true,
it is to get and set ExtIOI irqchip state from KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c         |  14 ++++
 hw/intc/loongarch_extioi_kvm.c     | 100 +++++++++++++++++++++++++++++
 include/hw/intc/loongarch_extioi.h |   2 +
 3 files changed, 116 insertions(+)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 06fe30dd3a..c63c176f9c 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -393,11 +393,24 @@ static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
     }
 }
 
+static int vmstate_extioi_pre_save(void *opaque)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_loongarch_extioi_pre_save(opaque);
+    }
+
+    return 0;
+}
+
 static int vmstate_extioi_post_load(void *opaque, int version_id)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(opaque);
     int i, start_irq;
 
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_loongarch_extioi_post_load(opaque, version_id);
+    }
+
     for (i = 0; i < (EXTIOI_IRQS / 4); i++) {
         start_irq = i * 4;
         extioi_update_sw_coremap(s, start_irq, s->coremap[i], false);
@@ -423,6 +436,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
                                       &lec->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
                                        NULL, &lec->parent_phases);
+    lecc->pre_save  = vmstate_extioi_pre_save;
     lecc->post_load = vmstate_extioi_post_load;
 }
 
diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index 833ec856ee..9c5649dd1a 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -12,6 +12,106 @@
 #include "qapi/error.h"
 #include "system/kvm.h"
 
+static void kvm_extioi_access_regs(int fd, uint64_t addr,
+                                       void *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_REGS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_extioi_access_sw_status(int fd, uint64_t addr,
+                                       void *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_SW_STATUS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_extioi_save_load_sw_status(void *opaque, bool write)
+{
+    LoongArchExtIOICommonState *lecs = LOONGARCH_EXTIOI_COMMON(opaque);
+    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(opaque);
+    int fd = les->dev_fd;
+    int addr;
+
+    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_NUM_CPU;
+    kvm_extioi_access_sw_status(fd, addr, &lecs->num_cpu, write);
+
+    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_FEATURE;
+    kvm_extioi_access_sw_status(fd, addr, &lecs->features, write);
+
+    addr = KVM_DEV_LOONGARCH_EXTIOI_SW_STATUS_STATE;
+    kvm_extioi_access_sw_status(fd, addr, &lecs->status, write);
+}
+
+static void kvm_extioi_save_load_regs(void *opaque, bool write)
+{
+    LoongArchExtIOICommonState *lecs = LOONGARCH_EXTIOI_COMMON(opaque);
+    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(opaque);
+    int fd = les->dev_fd;
+    int addr, offset, cpuid;
+
+    for (addr = EXTIOI_NODETYPE_START; addr < EXTIOI_NODETYPE_END; addr += 4) {
+        offset = (addr - EXTIOI_NODETYPE_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->nodetype[offset], write);
+    }
+
+    for (addr = EXTIOI_IPMAP_START; addr < EXTIOI_IPMAP_END; addr += 4) {
+        offset = (addr - EXTIOI_IPMAP_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->ipmap[offset], write);
+    }
+
+    for (addr = EXTIOI_ENABLE_START; addr < EXTIOI_ENABLE_END; addr += 4) {
+        offset = (addr - EXTIOI_ENABLE_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->enable[offset], write);
+    }
+
+    for (addr = EXTIOI_BOUNCE_START; addr < EXTIOI_BOUNCE_END; addr += 4) {
+        offset = (addr - EXTIOI_BOUNCE_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->bounce[offset], write);
+    }
+
+    for (addr = EXTIOI_ISR_START; addr < EXTIOI_ISR_END; addr += 4) {
+        offset = (addr - EXTIOI_ISR_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->isr[offset], write);
+    }
+
+    for (addr = EXTIOI_COREMAP_START; addr < EXTIOI_COREMAP_END; addr += 4) {
+        offset = (addr - EXTIOI_COREMAP_START) / 4;
+        kvm_extioi_access_regs(fd, addr, &lecs->coremap[offset], write);
+    }
+
+    for (cpuid = 0; cpuid < lecs->num_cpu; cpuid++) {
+        for (addr = EXTIOI_COREISR_START;
+             addr < EXTIOI_COREISR_END; addr += 4) {
+            offset = (addr - EXTIOI_COREISR_START) / 4;
+            addr = (cpuid << 16) | addr;
+            kvm_extioi_access_regs(fd, addr,
+                                   &lecs->cpu[cpuid].coreisr[offset], write);
+        }
+    }
+}
+
+int kvm_loongarch_extioi_pre_save(void *opaque)
+{
+    kvm_extioi_save_load_regs(opaque, false);
+    kvm_extioi_save_load_sw_status(opaque, false);
+    return 0;
+}
+
+int kvm_loongarch_extioi_post_load(void *opaque, int version_id)
+{
+    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(opaque);
+    int fd = les->dev_fd;
+
+    kvm_extioi_save_load_regs(opaque, true);
+    kvm_extioi_save_load_sw_status(opaque, true);
+
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
+                      KVM_DEV_LOONGARCH_EXTIOI_CTRL_LOAD_FINISHED,
+                      NULL, true, &error_abort);
+    return 0;
+}
+
 void kvm_loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchExtIOICommonState *lecs = LOONGARCH_EXTIOI_COMMON(dev);
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index ed328433f6..5e9aa365e3 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -27,5 +27,7 @@ struct LoongArchExtIOIClass {
 };
 
 void kvm_loongarch_extioi_realize(DeviceState *dev, Error **errp);
+int kvm_loongarch_extioi_pre_save(void *opaque);
+int kvm_loongarch_extioi_post_load(void *opaque, int version_id);
 
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.39.3


