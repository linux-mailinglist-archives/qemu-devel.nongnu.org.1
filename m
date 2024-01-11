Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0788482AD6E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:31:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtFt-0008Dm-TT; Thu, 11 Jan 2024 06:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtFS-0007na-Fa
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtFO-0006rn-M1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:22 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxrOgB0Z9loD8EAA--.4334S3;
 Thu, 11 Jan 2024 19:29:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S13; 
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 11/14] hw/intc/loongarch_ipi: Use MemTxAttrs interface for ipi
 ops
Date: Thu, 11 Jan 2024 19:16:06 +0800
Message-Id: <20240111111609.899183-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

There are two interface pairs for MemoryRegionOps, read/write and
read_with_attrs/write_with_attrs. The later is better for ipi device
emulation since initial cpu can be parsed from attrs.requester_id.

And requester_id can be overrided for IOCSR_IPI_SEND and mail_send
function when it is to forward message to another vcpu.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231215100333.3933632-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 136 +++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 59 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index a155c16509..4e104df71b 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -17,14 +17,16 @@
 #include "target/loongarch/internals.h"
 #include "trace.h"
 
-static void loongarch_ipi_writel(void *, hwaddr, uint64_t, unsigned);
-
-static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
+                                       uint64_t *data,
+                                       unsigned size, MemTxAttrs attrs)
 {
-    IPICore *s = opaque;
+    IPICore *s;
+    LoongArchIPI *ipi = opaque;
     uint64_t ret = 0;
     int index = 0;
 
+    s = &ipi->ipi_core;
     addr &= 0xff;
     switch (addr) {
     case CORE_STATUS_OFF:
@@ -49,10 +51,12 @@ static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
     }
 
     trace_loongarch_ipi_read(size, (uint64_t)addr, ret);
-    return ret;
+    *data = ret;
+    return MEMTX_OK;
 }
 
-static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
+static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
+                          MemTxAttrs attrs)
 {
     int i, mask = 0, data = 0;
 
@@ -62,7 +66,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
      */
     if ((val >> 27) & 0xf) {
         data = address_space_ldl(&env->address_space_iocsr, addr,
-                                 MEMTXATTRS_UNSPECIFIED, NULL);
+                                 attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -74,7 +78,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
     data &= mask;
     data |= (val >> 32) & ~mask;
     address_space_stl(&env->address_space_iocsr, addr,
-                      data, MEMTXATTRS_UNSPECIFIED, NULL);
+                      data, attrs, NULL);
 }
 
 static int archid_cmp(const void *a, const void *b)
@@ -103,80 +107,72 @@ static CPUState *ipi_getcpu(int arch_id)
     CPUArchId *archid;
 
     archid = find_cpu_by_archid(machine, arch_id);
-    return CPU(archid->cpu);
-}
-
-static void ipi_send(uint64_t val)
-{
-    uint32_t cpuid;
-    uint8_t vector;
-    CPUState *cs;
-    LoongArchCPU *cpu;
-    LoongArchIPI *s;
-
-    cpuid = extract32(val, 16, 10);
-    if (cpuid >= LOONGARCH_MAX_CPUS) {
-        trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
-        return;
+    if (archid) {
+        return CPU(archid->cpu);
     }
 
-    /* IPI status vector */
-    vector = extract8(val, 0, 5);
-
-    cs = ipi_getcpu(cpuid);
-    cpu = LOONGARCH_CPU(cs);
-    s = LOONGARCH_IPI(cpu->env.ipistate);
-    loongarch_ipi_writel(&s->ipi_core, CORE_SET_OFF, BIT(vector), 4);
+    return NULL;
 }
 
-static void mail_send(uint64_t val)
+static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
-    CPULoongArchState *env;
     CPUState *cs;
-    LoongArchCPU *cpu;
 
     cpuid = extract32(val, 16, 10);
     if (cpuid >= LOONGARCH_MAX_CPUS) {
         trace_loongarch_ipi_unsupported_cpuid("IOCSR_MAIL_SEND", cpuid);
-        return;
+        return MEMTX_DECODE_ERROR;
     }
 
-    addr = 0x1020 + (val & 0x1c);
     cs = ipi_getcpu(cpuid);
-    cpu = LOONGARCH_CPU(cs);
-    env = &cpu->env;
-    send_ipi_data(env, val, addr);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
 }
 
-static void any_send(uint64_t val)
+static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
-    CPULoongArchState *env;
     CPUState *cs;
-    LoongArchCPU *cpu;
 
     cpuid = extract32(val, 16, 10);
     if (cpuid >= LOONGARCH_MAX_CPUS) {
         trace_loongarch_ipi_unsupported_cpuid("IOCSR_ANY_SEND", cpuid);
-        return;
+        return MEMTX_DECODE_ERROR;
     }
 
-    addr = val & 0xffff;
     cs = ipi_getcpu(cpuid);
-    cpu = LOONGARCH_CPU(cs);
-    env = &cpu->env;
-    send_ipi_data(env, val, addr);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = val & 0xffff;
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
 }
 
-static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned size)
+static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
 {
-    IPICore *s = opaque;
+    LoongArchIPI *ipi = opaque;
+    IPICore *s;
     int index = 0;
+    uint32_t cpuid;
+    uint8_t vector;
+    CPUState *cs;
 
+    s = &ipi->ipi_core;
     addr &= 0xff;
     trace_loongarch_ipi_write(size, (uint64_t)addr, val);
     switch (addr) {
@@ -203,17 +199,35 @@ static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
         s->buf[index] = val;
         break;
     case IOCSR_IPI_SEND:
-        ipi_send(val);
+        cpuid = extract32(val, 16, 10);
+        if (cpuid >= LOONGARCH_MAX_CPUS) {
+            trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
+            return MEMTX_DECODE_ERROR;
+        }
+
+        /* IPI status vector */
+        vector = extract8(val, 0, 5);
+        cs = ipi_getcpu(cpuid);
+        if (cs == NULL) {
+            return MEMTX_DECODE_ERROR;
+        }
+
+        /* override requester_id */
+        attrs.requester_id = cs->cpu_index;
+        ipi = LOONGARCH_IPI(LOONGARCH_CPU(cs)->env.ipistate);
+        loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
         break;
     }
+
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps loongarch_ipi_ops = {
-    .read = loongarch_ipi_readl,
-    .write = loongarch_ipi_writel,
+    .read_with_attrs = loongarch_ipi_readl,
+    .write_with_attrs = loongarch_ipi_writel,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .valid.min_access_size = 4,
@@ -222,24 +236,28 @@ static const MemoryRegionOps loongarch_ipi_ops = {
 };
 
 /* mail send and any send only support writeq */
-static void loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned size)
+static MemTxResult loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
 {
+    MemTxResult ret = MEMTX_OK;
+
     addr &= 0xfff;
     switch (addr) {
     case MAIL_SEND_OFFSET:
-        mail_send(val);
+        ret = mail_send(val, attrs);
         break;
     case ANY_SEND_OFFSET:
-        any_send(val);
+        ret = any_send(val, attrs);
         break;
     default:
        break;
     }
+
+    return ret;
 }
 
 static const MemoryRegionOps loongarch_ipi64_ops = {
-    .write = loongarch_ipi_writeq,
+    .write_with_attrs = loongarch_ipi_writeq,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
     .valid.min_access_size = 8,
@@ -253,7 +271,7 @@ static void loongarch_ipi_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     memory_region_init_io(&s->ipi_iocsr_mem, obj, &loongarch_ipi_ops,
-                          &s->ipi_core, "loongarch_ipi_iocsr", 0x48);
+                          s, "loongarch_ipi_iocsr", 0x48);
 
     /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
     s->ipi_iocsr_mem.disable_reentrancy_guard = true;
@@ -261,7 +279,7 @@ static void loongarch_ipi_init(Object *obj)
     sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
 
     memory_region_init_io(&s->ipi64_iocsr_mem, obj, &loongarch_ipi64_ops,
-                          &s->ipi_core, "loongarch_ipi64_iocsr", 0x118);
+                          s, "loongarch_ipi64_iocsr", 0x118);
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
     qdev_init_gpio_out(DEVICE(obj), &s->ipi_core.irq, 1);
 }
-- 
2.25.1


