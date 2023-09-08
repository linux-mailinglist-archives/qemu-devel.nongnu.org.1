Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3C7981CB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUe2-0004Ui-9y; Fri, 08 Sep 2023 02:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdz-0004Iw-53
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdw-0006Xh-7a
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso14848215ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153218; x=1694758018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC1iRCb/qoM78YnEP3ofg9nP8nM+h7xg35CBjBCHbHg=;
 b=hS3htWtoJHn4JI6pA8MRcpm0YC/SnO9R8wHKqzQRlCCPSDYptUObHtT6cT2yTZfuLm
 /rCDhWHV0pJcEseRuv1fffHfINzmSYtwO80f9M0G1iPml3fYE8LDM2ZwJUYKynVpgzit
 eczTCr6crKNsyQ6tGQoQak/VbSHaNAiR2gUGTHmU8izpCROUAVLp/K8w/f9bRr8kVTOh
 5okfND9bh/gEU/awEHy7NxjTRX57DFbFwGyHmOawL+BF1Nig274Sap5iRCwF3Hio3KEj
 gsjuOOw9blhrw2jS00C8Tt0z8dOxf++20jFSTBsUvVpxtzgpC9tE6yPpnWOxyQz66lTI
 MOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153218; x=1694758018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC1iRCb/qoM78YnEP3ofg9nP8nM+h7xg35CBjBCHbHg=;
 b=m5bSlFQaDSVwzTdakLreczF+YFnT3YTxM17l2MMe/Ni9Tl9svWYwvNwmZvoeSGfklg
 sBJKaYAqK7e0uIVM42xuSa0s9KV9GtA+CiGRlBPS90mnYgGIcelyj6bJphWe34tEKKUU
 pTYNa1/evUSyk9Zg/mYFlxd6mJBZ5hcguWJFS/PoZGVCo73NPgajuU7tKySSxE/ml/mV
 gnF5qbX2fB54WKKHvPpGVUdKQbdCJKa7pJd5s7Ch9T/r9jnOHdjOgutvH2zVpIavm7Fa
 DHZABgvnXi49cRLgA0xEB9VBpjC1Fs6EuhASkxdQOSv0JEy5vTvkXzzxZCl12vdGJTXe
 Rlaw==
X-Gm-Message-State: AOJu0Yzwuuk0a8rj4KT957zMsYRTff5fsPN/4r3+mCAE1/aiRr3R31YO
 6Pc2AQyuYmC7tXdmtC3Uytck1zCenEIOg4na
X-Google-Smtp-Source: AGHT+IFfWv1GmyIdO3JIejM485TOadT74WYATLo4SY7TxZ4zuaMj/llhDuRRvK/ZI7w+RBBZOk/0xw==
X-Received: by 2002:a17:903:1c5:b0:1b8:865d:6e1d with SMTP id
 e5-20020a17090301c500b001b8865d6e1dmr1649351plh.51.1694153218392; 
 Thu, 07 Sep 2023 23:06:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/65] target/riscv: update APLIC and IMSIC to support KVM AIA
Date: Fri,  8 Sep 2023 16:03:58 +1000
Message-ID: <20230908060431.1903919-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM AIA can't emulate APLIC only. When "aia=aplic" parameter is passed,
APLIC devices is emulated by QEMU. For "aia=aplic-imsic", remove the
mmio operations of APLIC when using KVM AIA and send wired interrupt
signal via KVM_IRQ_LINE API.
After KVM AIA enabled, MSI messages are delivered by KVM_SIGNAL_MSI API
when the IMSICs receive mmio write requests.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230727102439.22554-5-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 56 ++++++++++++++++++++++++++++++-------------
 hw/intc/riscv_imsic.c | 25 +++++++++++++++----
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4bdc6a5d1a..592c3ce768 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -31,6 +31,7 @@
 #include "hw/irq.h"
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
 #include "migration/vmstate.h"
 
 #define APLIC_MAX_IDC                  (1UL << 14)
@@ -148,6 +149,15 @@
 
 #define APLIC_IDC_CLAIMI               0x1c
 
+/*
+ * KVM AIA only supports APLIC MSI, fallback to QEMU emulation if we want to use
+ * APLIC Wired.
+ */
+static bool is_kvm_aia(bool msimode)
+{
+    return kvm_irqchip_in_kernel() && msimode;
+}
+
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
@@ -471,6 +481,11 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
     return topi;
 }
 
+static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
+{
+    kvm_set_irq(kvm_state, irq, !!level);
+}
+
 static void riscv_aplic_request(void *opaque, int irq, int level)
 {
     bool update = false;
@@ -801,29 +816,35 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
-    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
-    aplic->state = g_new0(uint32_t, aplic->num_irqs);
-    aplic->target = g_new0(uint32_t, aplic->num_irqs);
-    if (!aplic->msimode) {
-        for (i = 0; i < aplic->num_irqs; i++) {
-            aplic->target[i] = 1;
+    if (!is_kvm_aia(aplic->msimode)) {
+        aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
+        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
+        aplic->state = g_new0(uint32_t, aplic->num_irqs);
+        aplic->target = g_new0(uint32_t, aplic->num_irqs);
+        if (!aplic->msimode) {
+            for (i = 0; i < aplic->num_irqs; i++) {
+                aplic->target[i] = 1;
+            }
         }
-    }
-    aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
-    aplic->iforce = g_new0(uint32_t, aplic->num_harts);
-    aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
+        aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
+        aplic->iforce = g_new0(uint32_t, aplic->num_harts);
+        aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
 
-    memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops, aplic,
-                          TYPE_RISCV_APLIC, aplic->aperture_size);
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
+        memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops,
+                              aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
+        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
+    }
 
     /*
      * Only root APLICs have hardware IRQ lines. All non-root APLICs
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
+        if (is_kvm_aia(aplic->msimode)) {
+            qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
+        } else {
+            qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
+        }
     }
 
     /* Create output IRQ lines for non-MSI mode */
@@ -958,7 +979,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     qdev_prop_set_bit(dev, "mmode", mmode);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+
+    if (!is_kvm_aia(msimode)) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    }
 
     if (parent) {
         riscv_aplic_add_child(parent, dev);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index fea3385b51..760dbddcf7 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -32,6 +32,7 @@
 #include "target/riscv/cpu.h"
 #include "target/riscv/cpu_bits.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
 #include "migration/vmstate.h"
 
 #define IMSIC_MMIO_PAGE_LE             0x00
@@ -283,6 +284,20 @@ static void riscv_imsic_write(void *opaque, hwaddr addr, uint64_t value,
         goto err;
     }
 
+#if defined(CONFIG_KVM)
+    if (kvm_irqchip_in_kernel()) {
+        struct kvm_msi msi;
+
+        msi.address_lo = extract64(imsic->mmio.addr + addr, 0, 32);
+        msi.address_hi = extract64(imsic->mmio.addr + addr, 32, 32);
+        msi.data = le32_to_cpu(value);
+
+        kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
+
+        return;
+    }
+#endif
+
     /* Writes only supported for MSI little-endian registers */
     page = addr >> IMSIC_MMIO_PAGE_SHIFT;
     if ((addr & (IMSIC_MMIO_PAGE_SZ - 1)) == IMSIC_MMIO_PAGE_LE) {
@@ -320,10 +335,12 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
     CPUState *cpu = cpu_by_arch_id(imsic->hartid);
     CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
 
-    imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
-    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
-    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
-    imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
+    if (!kvm_irqchip_in_kernel()) {
+        imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
+        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
+        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
+        imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
+    }
 
     memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
                           imsic, TYPE_RISCV_IMSIC,
-- 
2.41.0


