Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3098C03A7
	for <lists+qemu-devel@lfdr.de>; Wed,  8 May 2024 19:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lOW-00058U-3R; Wed, 08 May 2024 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lO3-0003xM-TA
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:28 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lO0-0000s5-JF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:27 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a599a298990so1255911066b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190443; x=1715795243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4UugJACtf4bn4sNSyhPXBpk03JSPeFk1TCWs7pdHzk=;
 b=WazMzpnx0UwL9+Gx+LPIw6UpBZIjOMeJpbWEUySMG0Hu6ggGxYhdPzAWj+YovkjO2X
 MmVUqFGwvrCSTWWHR5s7l3VC4eE4Z9SQmwpG7Wb2CZIpSpUrNcRSIPkFoak2TxF+etol
 ol7p8S9+QWbeN5vzpfQgPPWZczVzgmmnMIGpzDKokfWLCnY/kgH9kKmr2ZRjQ2GHiHnd
 q5+cEjhVPX4Ca/2k7rqQY/1+VofDF+pZK1CNNgx++/jUrx0w6ne+ULZ1GZxnBHjkyBjl
 bLm8sO+a+V+1bDPLDj6Ac2WuOHVytLm0wG4DkC+ZFXlcV+EmxEkCMWIkdB7x0o+rVaWt
 puJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190443; x=1715795243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4UugJACtf4bn4sNSyhPXBpk03JSPeFk1TCWs7pdHzk=;
 b=jJowO2TJnGSAv8RHya8bBJjvqddICpUrtPR+3S/laXsF7PAB3m96XLkiZip++ixJfI
 xY1vAvx/vr5o3vMqndk8jpTrNNwzu7z6/+07igYCRiyBTr0tteQnmnOyjFCAwR9mK/Q0
 NV7R3XThKGCk+UyAUVIu6rzcGuyWHoDZrEKqXmpJ/BJ1Y5N/9WZKYXfmlVrucjdO+5hU
 HR9jAfm7AHKFR0QnyF9sYiDIkZj4ASu0rQ8FCUOcZhom24qd4s2jPCxhCHy2zLGVVlrv
 gcFanOT+VAwnfe4lF+H3cTo/jLJSb6+zAEHpUEV6xWCthIkHgZKK5j5+/Mh4TXl7eZ8C
 l9Yg==
X-Gm-Message-State: AOJu0YyMvFX0FCc0UQk5k271WVUViZWVTEdYr1XvSESL2ErMW4bHchoG
 5/OOh0KU9viCWyKag97k1VDP20S3f8TF0TmLE55PHw9UJAV6F0YkoPkMeL8hlw1jM3/Z+TFRpvr
 w
X-Google-Smtp-Source: AGHT+IGTTE4em1oshE8wkOBHOcZsRajaFv0FEmvvLjrsWC5kN/7Sk2sucO7wZk3e3qFmvBRPstJwfA==
X-Received: by 2002:a17:906:b350:b0:a59:b098:7646 with SMTP id
 a640c23a62f3a-a59fb9c6b3emr207458266b.54.1715190442786; 
 Wed, 08 May 2024 10:47:22 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ov10-20020a170906fc0a00b00a599ec95792sm6237941ejb.162.2024.05.08.10.47.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/26] hw/intc/loongarch_ipi: Rename as loongson_ipi
Date: Wed,  8 May 2024 19:45:08 +0200
Message-ID: <20240508174510.60470-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

This device will be shared among LoongArch and MIPS
based Loongson machine, rename it as loongson_ipi
to reflect this nature.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240508-loongson3-ipi-v1-2-1a7b67704664@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |   4 +
 .../intc/{loongarch_ipi.h => loongson_ipi.h}  |  12 +-
 include/hw/loongarch/virt.h                   |   2 +-
 hw/intc/loongson_ipi.c                        | 347 ++++++++++++++++++
 hw/loongarch/virt.c                           |   4 +-
 hw/intc/Kconfig                               |   2 +-
 hw/intc/meson.build                           |   2 +-
 hw/intc/trace-events                          |   6 +-
 hw/loongarch/Kconfig                          |   2 +-
 9 files changed, 366 insertions(+), 15 deletions(-)
 rename include/hw/intc/{loongarch_ipi.h => loongson_ipi.h} (84%)
 create mode 100644 hw/intc/loongson_ipi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84391777db..7097f31245 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1242,7 +1242,9 @@ F: configs/devices/loongarch64-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
+F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
+F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
@@ -1376,10 +1378,12 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
+F: hw/intc/loongson_ipi.c
 F: hw/intc/loongson_liointc.c
 F: hw/mips/loongson3_bootp.c
 F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
+F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
 F: tests/avocado/machine_mips_loongson3v.py
 
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongson_ipi.h
similarity index 84%
rename from include/hw/intc/loongarch_ipi.h
rename to include/hw/intc/loongson_ipi.h
index 1c1e834849..2c0e8820f5 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * LoongArch ipi interrupt header files
+ * Loongson ipi interrupt header files
  *
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
 
-#ifndef HW_LOONGARCH_IPI_H
-#define HW_LOONGARCH_IPI_H
+#ifndef HW_LOONGSON_IPI_H
+#define HW_LOONGSON_IPI_H
 
 #include "hw/sysbus.h"
 
@@ -30,8 +30,8 @@
 
 #define IPI_MBX_NUM           4
 
-#define TYPE_LOONGARCH_IPI "loongarch_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
+#define TYPE_LOONGSON_IPI "loongson_ipi"
+OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
 
 typedef struct IPICore {
     uint32_t status;
@@ -43,7 +43,7 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
-struct LoongArchIPI {
+struct LoongsonIPI {
     SysBusDevice parent_obj;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d8a4ddb936..2c4f5cf9c8 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,7 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongarch_ipi.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
new file mode 100644
index 0000000000..8c888da3b2
--- /dev/null
+++ b/hw/intc/loongson_ipi.c
@@ -0,0 +1,347 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt support
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongson_ipi.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "target/loongarch/cpu.h"
+#include "trace.h"
+
+static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
+                                       uint64_t *data,
+                                       unsigned size, MemTxAttrs attrs)
+{
+    IPICore *s;
+    LoongsonIPI *ipi = opaque;
+    uint64_t ret = 0;
+    int index = 0;
+
+    s = &ipi->cpu[attrs.requester_id];
+    addr &= 0xff;
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        ret = s->status;
+        break;
+    case CORE_EN_OFF:
+        ret = s->en;
+        break;
+    case CORE_SET_OFF:
+        ret = 0;
+        break;
+    case CORE_CLEAR_OFF:
+        ret = 0;
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        ret = s->buf[index];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
+        break;
+    }
+
+    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
+    *data = ret;
+    return MEMTX_OK;
+}
+
+static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
+                          MemTxAttrs attrs)
+{
+    int i, mask = 0, data = 0;
+
+    /*
+     * bit 27-30 is mask for byte writing,
+     * if the mask is 0, we need not to do anything.
+     */
+    if ((val >> 27) & 0xf) {
+        data = address_space_ldl(env->address_space_iocsr, addr,
+                                 attrs, NULL);
+        for (i = 0; i < 4; i++) {
+            /* get mask for byte writing */
+            if (val & (0x1 << (27 + i))) {
+                mask |= 0xff << (i * 8);
+            }
+        }
+    }
+
+    data &= mask;
+    data |= (val >> 32) & ~mask;
+    address_space_stl(env->address_space_iocsr, addr,
+                      data, attrs, NULL);
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
+static CPUState *ipi_getcpu(int arch_id)
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
+static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = ipi_getcpu(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
+}
+
+static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = ipi_getcpu(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = val & 0xffff;
+    attrs.requester_id = cs->cpu_index;
+    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
+{
+    LoongsonIPI *ipi = opaque;
+    IPICore *s;
+    int index = 0;
+    uint32_t cpuid;
+    uint8_t vector;
+    CPUState *cs;
+
+    s = &ipi->cpu[attrs.requester_id];
+    addr &= 0xff;
+    trace_loongson_ipi_write(size, (uint64_t)addr, val);
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
+        break;
+    case CORE_EN_OFF:
+        s->en = val;
+        break;
+    case CORE_SET_OFF:
+        s->status |= val;
+        if (s->status != 0 && (s->status & s->en) != 0) {
+            qemu_irq_raise(s->irq);
+        }
+        break;
+    case CORE_CLEAR_OFF:
+        s->status &= ~val;
+        if (s->status == 0 && s->en != 0) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        s->buf[index] = val;
+        break;
+    case IOCSR_IPI_SEND:
+        cpuid = extract32(val, 16, 10);
+        /* IPI status vector */
+        vector = extract8(val, 0, 5);
+        cs = ipi_getcpu(cpuid);
+        if (cs == NULL) {
+            return MEMTX_DECODE_ERROR;
+        }
+
+        /* override requester_id */
+        attrs.requester_id = cs->cpu_index;
+        loongson_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps loongson_ipi_ops = {
+    .read_with_attrs = loongson_ipi_readl,
+    .write_with_attrs = loongson_ipi_writel,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* mail send and any send only support writeq */
+static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
+{
+    MemTxResult ret = MEMTX_OK;
+
+    addr &= 0xfff;
+    switch (addr) {
+    case MAIL_SEND_OFFSET:
+        ret = mail_send(val, attrs);
+        break;
+    case ANY_SEND_OFFSET:
+        ret = any_send(val, attrs);
+        break;
+    default:
+       break;
+    }
+
+    return ret;
+}
+
+static const MemoryRegionOps loongson_ipi64_ops = {
+    .write_with_attrs = loongson_ipi_writeq,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPI *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongson_ipi_ops,
+                          s, "loongson_ipi_iocsr", 0x48);
+
+    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
+    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
+
+    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
+
+    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi64_ops,
+                          s, "loongson_ipi64_iocsr", 0x118);
+    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
+
+    s->cpu = g_new0(IPICore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
+
+static const VMStateDescription vmstate_ipi_core = {
+    .name = "ipi-single",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(status, IPICore),
+        VMSTATE_UINT32(en, IPICore),
+        VMSTATE_UINT32(set, IPICore),
+        VMSTATE_UINT32(clear, IPICore),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongson_ipi = {
+    .name = TYPE_LOONGSON_IPI,
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
+                         vmstate_ipi_core, IPICore),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void loongson_ipi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = loongson_ipi_realize;
+    device_class_set_props(dc, ipi_properties);
+    dc->vmsd = &vmstate_loongson_ipi;
+}
+
+static void loongson_ipi_finalize(Object *obj)
+{
+    LoongsonIPI *s = LOONGSON_IPI(obj);
+
+    g_free(s->cpu);
+}
+
+static const TypeInfo loongson_ipi_info = {
+    .name          = TYPE_LOONGSON_IPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LoongsonIPI),
+    .class_init    = loongson_ipi_class_init,
+    .instance_finalize = loongson_ipi_finalize,
+};
+
+static void loongson_ipi_register_types(void)
+{
+    type_register_static(&loongson_ipi_info);
+}
+
+type_init(loongson_ipi_register_types)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 51e0aca39b..852036467a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -21,7 +21,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongarch_ipi.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -695,7 +695,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    ipi = qdev_new(TYPE_LOONGSON_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index ad59abebaa..58b6d3a710 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,7 +87,7 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
-config LOONGARCH_IPI
+config LOONGSON_IPI
     bool
 
 config LOONGARCH_PCH_PIC
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 58140da5f2..f4b540e6a8 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -68,7 +68,7 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
-specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index a979784f9b..b815cea129 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -291,9 +291,9 @@ sh_intc_read(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PR
 sh_intc_write(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " <- 0x%lx"
 sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
 
-# loongarch_ipi.c
-loongarch_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
-loongarch_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+# loongson_ipi.c
+loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+loongson_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
 loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 7864050563..ad77502445 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -10,7 +10,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGARCH_IPI
+    select LOONGSON_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
-- 
2.41.0


