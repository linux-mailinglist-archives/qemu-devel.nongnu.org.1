Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784DD934A1F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 10:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgy-0002b2-W8; Thu, 18 Jul 2024 04:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgo-0001oE-Ia
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgl-0005Kq-Ri
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so539875e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292033; x=1721896833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAAADLqB/ywse+fbm4/hNi0SZ7JLjPzn4jkX3T2CABk=;
 b=MWtphYh2pGMrz0NlMS8Rsq51ITwD5jjEAftER/0wxIUbs22XixTN7FloSNKaAMw7hT
 L/4OUWsBsPp93fW8MRueGLZDcmvu3GwSaoUiJtrj3LTQYTK/veymm+0KMZOavbDEnpuN
 CbmQ+aOjBJk3Jvw3/8ePVdOl+Xo2RnFp7fMdUlmupL9GCe7E94xE84z6BvVoAXCDurzS
 CJbD8dUhAEr06bCJ9XI86AKOEg2yr1psQrKcCnaqHEx8adeaaJQ+Ba6z1kLAGAzwXU0L
 yaKmzgqZSbYn7nZOhzKyivppwakpoNRMJZ49KXH7t+f9x8O+BqROOutam7xqDfkXloqF
 XMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292033; x=1721896833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAAADLqB/ywse+fbm4/hNi0SZ7JLjPzn4jkX3T2CABk=;
 b=U7Py5T06lriWLDd6lH6MdGNC6uxrcoeuN1D+0nTRru2c+aox4VenuAcdRd06YYk+J6
 PLnPU/mRfZ17g5GuiBJdEIeP9s1ePv+eCeXsPVb8mhPT3oj1wbfuTmGGJw3gxZcSStfk
 zHu0IxDiNdixvl6bQjpXEgxFbV9tAxXFbDIzX6H9eR3gDOQfxtcZRBo93VmFp+uSkFKM
 OvV4PvjlnEdhB3p77aprZTfScLg43YLdcLsd446Zw80NMKZRN35gf9XikX6LcSQ+ol47
 BRSws/YsSqC8JgOQG09vE/Ga10jONlnOjrtumwovVNoqs5MUZnvMVlcgim0vn59uxBE/
 kYdQ==
X-Gm-Message-State: AOJu0YzaAYVtXngnwKkrxywo6nUqgabawPKnAI9p1A5uPWInJliqKd8j
 0n2iRtF3QxY/KR/0rrlBm38wLnLr4vYA/ARvEUcdYetcPwjDo84FSO9Tmj37bd8H43TEuSb5Uxd
 lb3c=
X-Google-Smtp-Source: AGHT+IHnd30ODg3Xo4FGMO8hg5Y7zY6CXHAtyIkJCcWIiu3bmB5yz2lBHJshqB0F7dC7rid6P1AQdw==
X-Received: by 2002:a05:600c:474c:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-427c2cf2791mr34388825e9.29.1721292033015; 
 Thu, 18 Jul 2024 01:40:33 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b18420sm1394705e9.19.2024.07.18.01.40.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 14/18] hw/intc/loongson_ipi: Move common code to
 loongson_ipi_common.c
Date: Thu, 18 Jul 2024 10:38:38 +0200
Message-ID: <20240718083842.81199-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Move the common code from loongson_ipi.c to loongson_ipi_common.c,
call parent_realize() instead of loongson_ipi_common_realize() in
loongson_ipi_realize().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi.c        | 269 +--------------------------------
 hw/intc/loongson_ipi_common.c | 272 ++++++++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+), 267 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index a2db8bb2e2..86badb2972 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -24,56 +24,6 @@
 #endif
 #include "trace.h"
 
-MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
-                                    unsigned size, MemTxAttrs attrs)
-{
-    IPICore *s = opaque;
-    uint64_t ret = 0;
-    int index = 0;
-
-    addr &= 0xff;
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        ret = s->status;
-        break;
-    case CORE_EN_OFF:
-        ret = s->en;
-        break;
-    case CORE_SET_OFF:
-        ret = 0;
-        break;
-    case CORE_CLEAR_OFF:
-        ret = 0;
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        ret = s->buf[index];
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
-        break;
-    }
-
-    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
-    *data = ret;
-    return MEMTX_OK;
-}
-
-static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
-                                            uint64_t *data,
-                                            unsigned size, MemTxAttrs attrs)
-{
-    LoongsonIPICommonState *ipi = opaque;
-    IPICore *s;
-
-    if (attrs.requester_id >= ipi->num_cpu) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    s = &ipi->cpu[attrs.requester_id];
-    return loongson_ipi_core_readl(s, addr, data, size, attrs);
-}
-
 #ifdef TARGET_LOONGARCH64
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
@@ -92,148 +42,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 }
 #endif
 
-static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
-                                 uint64_t val, hwaddr addr, MemTxAttrs attrs)
-{
-    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
-    int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
-
-    if (!iocsr_as) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /*
-     * bit 27-30 is mask for byte writing,
-     * if the mask is 0, we need not to do anything.
-     */
-    if ((val >> 27) & 0xf) {
-        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
-        for (i = 0; i < 4; i++) {
-            /* get mask for byte writing */
-            if (val & (0x1 << (27 + i))) {
-                mask |= 0xff << (i * 8);
-            }
-        }
-    }
-
-    data &= mask;
-    data |= (val >> 32) & ~mask;
-    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
-
-    return MEMTX_OK;
-}
-
-static MemTxResult mail_send(LoongsonIPICommonState *ipi,
-                             uint64_t val, MemTxAttrs attrs)
-{
-    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = licc->cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
-    attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(ipi, cs, val, addr, attrs);
-}
-
-static MemTxResult any_send(LoongsonIPICommonState *ipi,
-                            uint64_t val, MemTxAttrs attrs)
-{
-    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = licc->cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = val & 0xffff;
-    attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(ipi, cs, val, addr, attrs);
-}
-
-MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
-                                     unsigned size, MemTxAttrs attrs)
-{
-    IPICore *s = opaque;
-    LoongsonIPICommonState *ipi = s->ipi;
-    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
-    int index = 0;
-    uint32_t cpuid;
-    uint8_t vector;
-    CPUState *cs;
-
-    addr &= 0xff;
-    trace_loongson_ipi_write(size, (uint64_t)addr, val);
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
-        break;
-    case CORE_EN_OFF:
-        s->en = val;
-        break;
-    case CORE_SET_OFF:
-        s->status |= val;
-        if (s->status != 0 && (s->status & s->en) != 0) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-    case CORE_CLEAR_OFF:
-        s->status &= ~val;
-        if (s->status == 0 && s->en != 0) {
-            qemu_irq_lower(s->irq);
-        }
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        s->buf[index] = val;
-        break;
-    case IOCSR_IPI_SEND:
-        cpuid = extract32(val, 16, 10);
-        /* IPI status vector */
-        vector = extract8(val, 0, 5);
-        cs = licc->cpu_by_arch_id(cpuid);
-        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
-            return MEMTX_DECODE_ERROR;
-        }
-        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
-                                 BIT(vector), 4, attrs);
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
-        break;
-    }
-
-    return MEMTX_OK;
-}
-
-static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
-                                            uint64_t val, unsigned size,
-                                            MemTxAttrs attrs)
-{
-    LoongsonIPICommonState *ipi = opaque;
-    IPICore *s;
-
-    if (attrs.requester_id >= ipi->num_cpu) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    s = &ipi->cpu[attrs.requester_id];
-    return loongson_ipi_core_writel(s, addr, val, size, attrs);
-}
-
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
     .write_with_attrs = loongson_ipi_core_writel,
@@ -244,88 +52,15 @@ static const MemoryRegionOps loongson_ipi_core_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps loongson_ipi_iocsr_ops = {
-    .read_with_attrs = loongson_ipi_iocsr_readl,
-    .write_with_attrs = loongson_ipi_iocsr_writel,
-    .impl.min_access_size = 4,
-    .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-/* mail send and any send only support writeq */
-static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    LoongsonIPICommonState *ipi = opaque;
-    MemTxResult ret = MEMTX_OK;
-
-    addr &= 0xfff;
-    switch (addr) {
-    case MAIL_SEND_OFFSET:
-        ret = mail_send(ipi, val, attrs);
-        break;
-    case ANY_SEND_OFFSET:
-        ret = any_send(ipi, val, attrs);
-        break;
-    default:
-       break;
-    }
-
-    return ret;
-}
-
-static const MemoryRegionOps loongson_ipi64_ops = {
-    .write_with_attrs = loongson_ipi_writeq,
-    .impl.min_access_size = 8,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 8,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
-{
-    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
-                          &loongson_ipi_iocsr_ops,
-                          s, "loongson_ipi_iocsr", 0x48);
-
-    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
-    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
-
-    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
-
-    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
-                          &loongson_ipi64_ops,
-                          s, "loongson_ipi64_iocsr", 0x118);
-    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
-    }
-}
-
 static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *sc = LOONGSON_IPI_COMMON(dev);
     LoongsonIPIState *s = LOONGSON_IPI(dev);
+    LoongsonIPIClass *lic = LOONGSON_IPI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
 
-    loongson_ipi_common_realize(dev, &local_err);
+    lic->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 3b9e5c943d..015f86c066 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -8,8 +8,279 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
+#include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
 #include "migration/vmstate.h"
+#include "trace.h"
+
+MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    IPICore *s = opaque;
+    uint64_t ret = 0;
+    int index = 0;
+
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
+
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
+                                            uint64_t *data, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    LoongsonIPICommonState *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_readl(s, addr, data, size, attrs);
+}
+
+static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
+                                 uint64_t val, hwaddr addr, MemTxAttrs attrs)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+    int i, mask = 0, data = 0;
+    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
+
+    if (!iocsr_as) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /*
+     * bit 27-30 is mask for byte writing,
+     * if the mask is 0, we need not to do anything.
+     */
+    if ((val >> 27) & 0xf) {
+        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
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
+    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
+
+    return MEMTX_OK;
+}
+
+static MemTxResult mail_send(LoongsonIPICommonState *ipi,
+                             uint64_t val, MemTxAttrs attrs)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = licc->cpu_by_arch_id(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
+    attrs.requester_id = cs->cpu_index;
+    return send_ipi_data(ipi, cs, val, addr, attrs);
+}
+
+static MemTxResult any_send(LoongsonIPICommonState *ipi,
+                            uint64_t val, MemTxAttrs attrs)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = licc->cpu_by_arch_id(cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = val & 0xffff;
+    attrs.requester_id = cs->cpu_index;
+    return send_ipi_data(ipi, cs, val, addr, attrs);
+}
+
+MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size, MemTxAttrs attrs)
+{
+    IPICore *s = opaque;
+    LoongsonIPICommonState *ipi = s->ipi;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+    int index = 0;
+    uint32_t cpuid;
+    uint8_t vector;
+    CPUState *cs;
+
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
+        cs = licc->cpu_by_arch_id(cpuid);
+        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
+            return MEMTX_DECODE_ERROR;
+        }
+        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
+                                 BIT(vector), 4, attrs);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
+                                            uint64_t val, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    LoongsonIPICommonState *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_writel(s, addr, val, size, attrs);
+}
+
+static const MemoryRegionOps loongson_ipi_iocsr_ops = {
+    .read_with_attrs = loongson_ipi_iocsr_readl,
+    .write_with_attrs = loongson_ipi_iocsr_writel,
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
+    LoongsonIPICommonState *ipi = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    addr &= 0xfff;
+    switch (addr) {
+    case MAIL_SEND_OFFSET:
+        ret = mail_send(ipi, val, attrs);
+        break;
+    case ANY_SEND_OFFSET:
+        ret = any_send(ipi, val, attrs);
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
+static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi_iocsr_ops,
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
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
 
 static void loongson_ipi_common_finalize(Object *obj)
 {
@@ -53,6 +324,7 @@ static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = loongson_ipi_common_realize;
     device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongson_ipi;
 }
-- 
2.41.0


