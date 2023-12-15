Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB981451E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:04:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE530-0003TK-N1; Fri, 15 Dec 2023 05:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rE52t-0003Qc-2g
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rE52l-0004tb-U5
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:50 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxE_B4JHxlQlABAA--.7322S3;
 Fri, 15 Dec 2023 18:03:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrnN1JHxldl0FAA--.26862S6; 
 Fri, 15 Dec 2023 18:03:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/intc/loongarch_extioi: Add vmstate post_load support
Date: Fri, 15 Dec 2023 18:03:33 +0800
Message-Id: <20231215100333.3933632-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231215100333.3933632-1-maobibo@loongson.cn>
References: <20231215100333.3933632-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrnN1JHxldl0FAA--.26862S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF4rKr43WF1DJrWkWr1ktFc_yoW7Gw4Upr
 W3ur98Kry3Wa13WwsrKa4UWFs8Gr4fW3Wavryq9FySkF95CryF9a4vvFZ2qFWkC3sayF90
 9a4rZ3y7CF4qyrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

There are elements sw_ipmap and sw_coremap, which is usd to speed
up irq injection flow. They are saved and restored in vmstate during
migration, indeed they can calculated from hw registers. Here
post_load is added for get sw_ipmap and sw_coremap from extioi hw
state.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 120 +++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index d9d5066c3f..e0fd57f962 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -130,12 +130,66 @@ static inline void extioi_enable_irq(LoongArchExtIOI *s, int index,\
     }
 }
 
+static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
+                                            uint64_t val, bool notify)
+{
+    int i, cpu;
+
+    /*
+     * loongarch only support little endian,
+     * so we paresd the value with little endian.
+     */
+    val = cpu_to_le64(val);
+
+    for (i = 0; i < 4; i++) {
+        cpu = val & 0xff;
+        cpu = ctz32(cpu);
+        cpu = (cpu >= 4) ? 0 : cpu;
+        val = val >> 8;
+
+        if (s->sw_coremap[irq + i] == cpu) {
+            continue;
+        }
+
+        if (notify && test_bit(irq, (unsigned long *)s->isr)) {
+            /*
+             * lower irq at old cpu and raise irq at new cpu
+             */
+            extioi_update_irq(s, irq + i, 0);
+            s->sw_coremap[irq + i] = cpu;
+            extioi_update_irq(s, irq + i, 1);
+        } else {
+            s->sw_coremap[irq + i] = cpu;
+        }
+    }
+}
+
+static inline void extioi_update_sw_ipmap(LoongArchExtIOI *s, int index,
+                                          uint64_t val)
+{
+    int i;
+    uint8_t ipnum;
+
+    /*
+     * loongarch only support little endian,
+     * so we paresd the value with little endian.
+     */
+    val = cpu_to_le64(val);
+    for (i = 0; i < 4; i++) {
+        ipnum = val & 0xff;
+        ipnum = ctz32(ipnum);
+        ipnum = (ipnum >= 4) ? 0 : ipnum;
+        s->sw_ipmap[index * 4 + i] = ipnum;
+        val = val >> 8;
+    }
+}
+
 static MemTxResult extioi_writew(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size,
                           MemTxAttrs attrs)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
-    int i, cpu, index, old_data, irq;
+    int cpu, index, old_data, irq;
     uint32_t offset;
 
     trace_loongarch_extioi_writew(addr, val);
@@ -153,20 +207,7 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
          */
         index = (offset - EXTIOI_IPMAP_START) >> 2;
         s->ipmap[index] = val;
-        /*
-         * loongarch only support little endian,
-         * so we paresd the value with little endian.
-         */
-        val = cpu_to_le64(val);
-        for (i = 0; i < 4; i++) {
-            uint8_t ipnum;
-            ipnum = val & 0xff;
-            ipnum = ctz32(ipnum);
-            ipnum = (ipnum >= 4) ? 0 : ipnum;
-            s->sw_ipmap[index * 4 + i] = ipnum;
-            val = val >> 8;
-        }
-
+        extioi_update_sw_ipmap(s, index, val);
         break;
     case EXTIOI_ENABLE_START ... EXTIOI_ENABLE_END - 1:
         index = (offset - EXTIOI_ENABLE_START) >> 2;
@@ -205,33 +246,8 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
         irq = offset - EXTIOI_COREMAP_START;
         index = irq / 4;
         s->coremap[index] = val;
-        /*
-         * loongarch only support little endian,
-         * so we paresd the value with little endian.
-         */
-        val = cpu_to_le64(val);
-
-        for (i = 0; i < 4; i++) {
-            cpu = val & 0xff;
-            cpu = ctz32(cpu);
-            cpu = (cpu >= 4) ? 0 : cpu;
-            val = val >> 8;
-
-            if (s->sw_coremap[irq + i] == cpu) {
-                continue;
-            }
-
-            if (test_bit(irq, (unsigned long *)s->isr)) {
-                /*
-                 * lower irq at old cpu and raise irq at new cpu
-                 */
-                extioi_update_irq(s, irq + i, 0);
-                s->sw_coremap[irq + i] = cpu;
-                extioi_update_irq(s, irq + i, 1);
-            } else {
-                s->sw_coremap[irq + i] = cpu;
-            }
-        }
+
+        extioi_update_sw_coremap(s, irq, val, true);
         break;
     default:
         break;
@@ -288,6 +304,23 @@ static void loongarch_extioi_finalize(Object *obj)
     g_free(s->cpu);
 }
 
+static int vmstate_extioi_post_load(void *opaque, int version_id)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+    int i, start_irq;
+
+    for (i = 0; i < (EXTIOI_IRQS / 4); i++) {
+        start_irq = i * 4;
+        extioi_update_sw_coremap(s, start_irq, s->coremap[i], false);
+    }
+
+    for (i = 0; i < (EXTIOI_IRQS_IPMAP_SIZE / 4); i++) {
+        extioi_update_sw_ipmap(s, i, s->ipmap[i]);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_extioi_core = {
     .name = "extioi-core",
     .version_id = 1,
@@ -302,6 +335,7 @@ static const VMStateDescription vmstate_loongarch_extioi = {
     .name = TYPE_LOONGARCH_EXTIOI,
     .version_id = 2,
     .minimum_version_id = 2,
+    .post_load = vmstate_extioi_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
         VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOI,
@@ -310,8 +344,6 @@ static const VMStateDescription vmstate_loongarch_extioi = {
         VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOI, EXTIOI_IRQS / 32),
         VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOI, EXTIOI_IRQS_IPMAP_SIZE / 4),
         VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOI, EXTIOI_IRQS / 4),
-        VMSTATE_UINT8_ARRAY(sw_ipmap, LoongArchExtIOI, EXTIOI_IRQS_IPMAP_SIZE),
-        VMSTATE_UINT8_ARRAY(sw_coremap, LoongArchExtIOI, EXTIOI_IRQS),
 
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
                          vmstate_extioi_core, ExtIOICore),
-- 
2.39.3


