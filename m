Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170CE751C06
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 10:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJrwF-0006Qy-Qw; Thu, 13 Jul 2023 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrwC-0006Q9-Gm
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrwA-00070J-Ei
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso284093b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689237873; x=1691829873;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R5Lwp6JGXFIhvrTHMOVoigMo/sy9lxlSF/Jzo4dn8GE=;
 b=Q81w/fVFX0+9SHZnwqTWIHRPqkUYbMJ+3ib46P29sYubjO8Yet89MQNUw2OpxqYdvn
 YgLDgGiQrPETtGRXI7Ft2SLlRG2LXCAFJAhP2ok3W3b92qFUKUUtBXAhqQvr2HYunnuc
 aOjwbJScPEIncprZ3sVF5ulcMdMSNtHKuUhv03qhhDFSkT9Zi7vhtzv5K+NShko4HiBy
 dw1KXu4wg3fZ7EKG8HI3RZkGQrTXB8r9pLyVHuzEW5zF+qrJJn5zrN6NI9hhuwcGrq0T
 R32TG1ef3e4BpXfBslUU/y75an5+/Q8YVw86FSSQRt+2O/hPKCHF/g33Jmby+rLZcvAp
 cp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689237873; x=1691829873;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5Lwp6JGXFIhvrTHMOVoigMo/sy9lxlSF/Jzo4dn8GE=;
 b=dx/B9jRDUUOSHrXhxHsjiafD4nvlQ3PjFSvNgA2V9Wn178EVYHJ+c0udyMggH0YzZZ
 JjQjb3t08fC4vwJQXr7Fjc++HI2uddn9xag0rxYAgt0Ht/CdOqOby8vL1z0VprQJAbTc
 wcz2V1dbDu4Ff0Jg31FADRhiNkkACYuJrd1CpXNkaf4XP9sDfQwBAWVNizoe9VX+oyQP
 Ya8UOWxP/zrTqo1m18zSl8dchFcki/vS1cAwucSn8drGdOJFsJJ+t60se0X1iW9FlAQU
 8y96Cf0kMo606BJVxPZVYbagZgZcVRJ4rv46mxT2J/MBh+XF0EsBKT4Rjg0urLND5kt0
 2nZw==
X-Gm-Message-State: ABy/qLYLkocPbIUtXXreO4fZizbqJHbPodjbrsIvV26wzM9ZCV1SDDLU
 4cSaPmmpgyHqFo38zym6wXM+Usg6uRSssN7smGk69iBLVK14ua1jCAVFZuMjvqw2SBI2UMfaxGT
 8xjDY/2YUAGIlUEKXw4AuCIechiekFr4UWCccrjw6rF2jeD6askuwq9LZGwuC2jD/RPorp1PkIR
 aXssz3
X-Google-Smtp-Source: APBJJlEvxDZxnLUdCWLrGW+4Y2JnBhDhaldI8wRc/bSpP/HOyMKN3LObz/+lXQ46YibT0158AdmX5g==
X-Received: by 2002:a05:6a20:12cc:b0:12f:86f1:b16f with SMTP id
 v12-20020a056a2012cc00b0012f86f1b16fmr5783216pzg.1.1689237872806; 
 Thu, 13 Jul 2023 01:44:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a63724a000000b0055386b1415dsm4989198pgn.51.2023.07.13.01.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 01:44:32 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, atishp@atishpatra.org, vincent.chen@sifive.com,
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v5 4/5] target/riscv: update APLIC and IMSIC to support KVM AIA
Date: Thu, 13 Jul 2023 08:43:56 +0000
Message-Id: <20230713084405.24545-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713084405.24545-1-yongxuan.wang@sifive.com>
References: <20230713084405.24545-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 hw/intc/riscv_aplic.c | 56 ++++++++++++++++++++++++++++++-------------
 hw/intc/riscv_imsic.c | 25 +++++++++++++++----
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4bdc6a5d1a..eab5db053b 100644
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
+                             aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
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
2.17.1


