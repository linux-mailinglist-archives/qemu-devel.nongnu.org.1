Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59407765277
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:32:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyC9-0003iU-VE; Thu, 27 Jul 2023 06:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qOyBP-0003Wu-79
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:25:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qOyBD-00049T-BZ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:25:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso4981225ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1690453505; x=1691058305;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OULN+wwisoBSnT3VMk9Y7HLLhh5KeELP9Ck02I8dOSM=;
 b=SkFM1Jhyqd5M80e+Hjce9UMwsCrdxraYXDT6NJnpvnnz1pf5JFUVdSWdvzN8BvQYwB
 k91nGrBhz2QzgVqfKxewEDSlwB91NrRLdUMFmuSQPRKkQLKbGHLM2pU0uZjC5TVvrOaM
 9JuCg28UuEtQCvKkE/HmuIelNoN2qAdhfSQRKUxSv8KJlJtx7XGFyDaZxZHZSBpry0DE
 b26eCWl7u26IfOwzxKGOwYGGbS27TvsLeWZEP/GI3vWyp2/L5z4vCluGZxc+VhKhCst9
 UflMBkGy8/6F0mF1d7suHEPza816s922eVSi4tUNrsJbJCzw6VvLtJVitnV6dh5kwQ6g
 aQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690453505; x=1691058305;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OULN+wwisoBSnT3VMk9Y7HLLhh5KeELP9Ck02I8dOSM=;
 b=FPYnlmrqhlaxxaDrIn0cn4YKpFlsdjLhrQguzwj7ut8NcCGsGKVnCT+V10sd7Nfd9Y
 VtzRPa1PgL8tr3CFOoyBJ18GXa6uDQaFpZTP2QJaebntntp7SQDMWw6ZqwJNLOfQ8aqz
 N26C96gDr4epZnhBf50YWp6rSQNxeebP8NWrNaY61lyEBC+mmZSql+WcIv7jvVeBdJ+T
 SkqSgcuTmylMwkEzQScgqp1lGtM9Vq64BC9hYfH69xn92sE1PTNrvlnETQ2aP24AyzJV
 sUzdsHypJmM53cZoc6bziUWpw+1DfTcNVMuxIht9/pU8HL4U67h3EF3vijb3Sy7gvR73
 vs1Q==
X-Gm-Message-State: ABy/qLYrfBS4gCxoboWOg2qyS1D1FkYrB6re80+YW8aBUAG0+c3Ei6x9
 vxWHvB9HlowOvJcR9EdHDylRMphklDXkmtw3Pd5bs9do7Z65R8AHNHNBQA7UQBFuXdlat2GLRSx
 I5QOcDt4GI3GaI8fQ8N8UJJvnkRC1TFtlRUm4RkcROPaHBfHXrOHpZDPGaj6GpQF4bM0lcEz+Dr
 uD6O5I
X-Google-Smtp-Source: APBJJlG2ZP7qwtNxQoeQJnvSWf3xpKzie1j1g+qVGFlELlVRwE77NiAW2P/zjn+f7Rk/e4CDl0wRcw==
X-Received: by 2002:a17:902:64c8:b0:1b6:6b03:10e7 with SMTP id
 y8-20020a17090264c800b001b66b0310e7mr2648932pli.5.1690453505162; 
 Thu, 27 Jul 2023 03:25:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a17090341c800b001b882880550sm1230139ple.282.2023.07.27.03.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 03:25:04 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, atishp@atishpatra.org, vincent.chen@sifive.com,
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Ivan Klokov <ivan.klokov@syntacore.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 4/5] target/riscv: update APLIC and IMSIC to support KVM AIA
Date: Thu, 27 Jul 2023 10:24:36 +0000
Message-Id: <20230727102439.22554-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230727102439.22554-1-yongxuan.wang@sifive.com>
References: <20230727102439.22554-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
2.17.1


