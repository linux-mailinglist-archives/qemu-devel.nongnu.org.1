Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F9AC4A89
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 10:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpvo-0003Nf-ND; Tue, 27 May 2025 04:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJpvk-0003Kc-UD
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:45:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJpvd-0000fZ-UH
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:45:04 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLGuHezVoXhj+AA--.16428S3;
 Tue, 27 May 2025 16:44:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3xtyezVolPn0AA--.53554S10;
 Tue, 27 May 2025 16:44:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 08/12] ihw/intc/loongarch_pch: Add kernel irqchip save and
 restore function
Date: Tue, 27 May 2025 16:44:26 +0800
Message-Id: <20250527084430.3468174-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250527084430.3468174-1-maobibo@loongson.cn>
References: <20250527084430.3468174-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3xtyezVolPn0AA--.53554S10
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
it is to get and set PCH PCI irqchip state from KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 22 ++++++++++
 hw/intc/loongarch_pic_kvm.c            | 58 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pch_pic.h    |  2 +
 include/hw/intc/loongarch_pic_common.h |  1 +
 4 files changed, 83 insertions(+)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index f454df576a..5ac035d8b8 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -287,16 +287,38 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static int loongarch_pic_pre_save(LoongArchPICCommonState *opaque)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_loongarch_pic_pre_save(opaque);
+    }
+
+    return 0;
+}
+
+static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
+                                   int version_id)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_loongarch_pic_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
                                        NULL, &lpc->parent_phases);
     device_class_set_parent_realize(dc, loongarch_pic_realize,
                                     &lpc->parent_realize);
+    lpcc->pre_save = loongarch_pic_pre_save;
+    lpcc->post_load = loongarch_pic_post_load;
 }
 
 static const TypeInfo loongarch_pic_types[] = {
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index 23db857b0e..bc9e8d408e 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -13,6 +13,64 @@
 #include "hw/pci-host/ls7a.h"
 #include "system/kvm.h"
 
+static void kvm_pch_pic_access_regs(int fd, uint64_t addr,
+                                       void *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_loongarch_pch_pic_save_load(void *opaque, bool write)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
+    LoongarchPICState *lps = LOONGARCH_PIC(opaque);
+    int fd = lps->dev_fd;
+    int addr, offset;
+
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_MASK,
+                            &s->int_mask, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_HTMSI_EN,
+                            &s->htmsi_en, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_EDGE,
+                            &s->intedge, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_AUTO_CTRL0,
+                            &s->auto_crtl0, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_AUTO_CTRL1,
+                            &s->auto_crtl1, write);
+
+    for (addr = PCH_PIC_ROUTE_ENTRY;
+        addr < PCH_PIC_ROUTE_ENTRY_END; addr++) {
+        offset = addr - PCH_PIC_ROUTE_ENTRY;
+        kvm_pch_pic_access_regs(fd, addr + VIRT_PCH_REG_BASE,
+                                &s->route_entry[offset], write);
+    }
+
+    for (addr = PCH_PIC_HTMSI_VEC; addr < PCH_PIC_HTMSI_VEC_END; addr++) {
+        offset = addr - PCH_PIC_HTMSI_VEC;
+        kvm_pch_pic_access_regs(fd, addr + VIRT_PCH_REG_BASE,
+                                &s->htmsi_vector[offset], write);
+    }
+
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_REQUEST,
+                            &s->intirr, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_STATUS,
+                            &s->intisr, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_POL,
+                            &s->int_polarity, write);
+}
+
+int kvm_loongarch_pic_pre_save(void *opaque)
+{
+    kvm_loongarch_pch_pic_save_load(opaque, false);
+    return 0;
+}
+
+int kvm_loongarch_pic_post_load(void *opaque, int version_id)
+{
+    kvm_loongarch_pch_pic_save_load(opaque, true);
+    return 0;
+}
+
 void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongarchPICState *lps = LOONGARCH_PIC(dev);
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index ef8334935d..99030d0be1 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -27,5 +27,7 @@ struct LoongarchPICClass {
 };
 
 void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp);
+int kvm_loongarch_pic_pre_save(void *opaque);
+int kvm_loongarch_pic_post_load(void *opaque, int version_id);
 
 #endif /* HW_LOONGARCH_PCH_PIC_H */
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 9349a055d0..f774c975d4 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -23,6 +23,7 @@
 #define PCH_PIC_ROUTE_ENTRY_END         0x13f
 #define PCH_PIC_HTMSI_VEC               0x200
 #define PCH_PIC_HTMSI_VEC_END           0x23f
+#define PCH_PIC_INT_REQUEST             0x380
 #define PCH_PIC_INT_STATUS              0x3a0
 #define PCH_PIC_INT_POL                 0x3e0
 
-- 
2.39.3


