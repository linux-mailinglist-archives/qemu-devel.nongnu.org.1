Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EA788820
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWYp-0001Ze-A1; Fri, 25 Aug 2023 09:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWYn-0001Z8-Sr
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:09 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWYi-0006tR-IP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:09 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bd0c953fd9so642316a34.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968943; x=1693573743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxG+3uZr4lIffQUAHe0FsNGnmKkbATOR7wE+qpGh0vY=;
 b=Rpi8CxkpPjAhkjcsWsicWzXSksv2cYrkx15xKycm5KkvoIP3CxNfQzHGDOzgefEdIb
 R2haAXgreE4DensLt92Nk1E55FJSSVY/JHpBWgJOoQpHPPuo2SAkCFZ1XchWMrWulJIN
 jnxMUUTau3Qy44I2FTHfGXzJp2eRhEGj4++pVht4vLAgZkjPuNecLM7MeYqpWdOQsLcA
 4RH2i3UVdwk1fnQoL0dQ5om8bdB6m4dAVqy74FpFJO1w1oHOuRJOSPwOTHE5iinch/fz
 iNN+hAnmJmr+baVDvZFRPae/2oUkNzXew7vq83LMcphZMP8zXo/LEYNouIr2Mqg+In0L
 9fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968943; x=1693573743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxG+3uZr4lIffQUAHe0FsNGnmKkbATOR7wE+qpGh0vY=;
 b=lQVU5tjCTexnOg4pGyRoSKAstx6ebdNZGPE1acJB0EguxsYNM1bh/WdkY4AkVuBste
 7cMLbduvQbhITtjYo6+3OBuARXhKpEGwI3UOXGOHSj1foiH4+laMWUx8g1XlZolPzx2r
 4/c+CgLXcA1BY/Kmun7fFbvJrt+xSEcqXcgY4S+wzfXIJ+7eCoUBYXsSmvglrxVoWrwy
 EuJu7F/heKLfTgd9KOiQNAzi95YEdmnAplSQAKd8s7k7tin4OGsuytkBJTFJKn8jom1l
 CGdpPMYT3ZtpkRsDSBghoHYPV2qBA5kaNW1vLAN6Ku+pxxleGS5fS9vGWqIt1XZS8K/j
 Xwdg==
X-Gm-Message-State: AOJu0YyyJF4whw4nuFWP5oUWRCqtbftTwqSa9GKezR0SHT3HPdJZyZ/N
 wrLmk+iOhCVTYCmpp0nNJn2gOZjYzStrptiPnmo=
X-Google-Smtp-Source: AGHT+IFpWqkofSGr+xuIPh+iw9jbX6pJFCWxWxfzpIbC8ezC75RMDiuKtkuCnopJrd9mxM2B1ZrnGQ==
X-Received: by 2002:a05:6870:8a1e:b0:1c8:c19d:61d2 with SMTP id
 p30-20020a0568708a1e00b001c8c19d61d2mr3102516oaq.37.1692968943015; 
 Fri, 25 Aug 2023 06:09:03 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 01/20] target/riscv: introduce TCG AccelCPUClass
Date: Fri, 25 Aug 2023 10:08:34 -0300
Message-ID: <20230825130853.511782-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

target/riscv/cpu.c needs to handle all possible accelerators (TCG and
KVM at this moment) during both init() and realize() time. This forces
us to resort to a lot of "if tcg" and "if kvm" throughout the code,
which isn't wrong, but can get cluttered over time. Splitting
acceleration specific code from cpu.c to its own file will help to
declutter the existing code and it will also make it easier to support
KVM/TCG only builds in the future.

We'll start by adding a new subdir called 'tcg' and a new file called
'tcg-cpu.c'. This file will be used to introduce a new accelerator class
for TCG acceleration in RISC-V, allowing us to center all TCG exclusive
code in its file instead of using 'cpu.c' for everything. This design is
inpired by the work Claudio Fontana did in x86 a few years ago in commit
f5cc5a5c1 ("i386: split cpu accelerators from cpu.c, using
AccelCPUClass").

To avoid moving too much code at once we'll start by adding the new file
and TCG AccelCPUClass declaration. The 'class_init' from the accel class
will init 'tcg_ops', relieving the common riscv_cpu_class_init() from
doing it.

'riscv_tcg_ops' is being exported from 'cpu.c' for now to avoid having
to deal with moving code and files around right now. We'll focus on
decoupling the realize() logic first.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c           |  5 +---
 target/riscv/cpu.h           |  4 +++
 target/riscv/meson.build     |  2 ++
 target/riscv/tcg/meson.build |  2 ++
 target/riscv/tcg/tcg-cpu.c   | 57 ++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100644 target/riscv/tcg/meson.build
 create mode 100644 target/riscv/tcg/tcg-cpu.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 21ebdbf084..38dcbc4dd2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2275,9 +2275,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
-
-static const struct TCGCPUOps riscv_tcg_ops = {
+const struct TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
@@ -2436,7 +2434,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
-    cc->tcg_ops = &riscv_tcg_ops;
 
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 577abcd724..b84b62f84e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -707,6 +707,10 @@ enum riscv_pmu_event_idx {
     RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
 };
 
+/* Export tcg_ops until we move everything to tcg/tcg-cpu.c */
+#include "hw/core/tcg-cpu-ops.h"
+extern const struct TCGCPUOps riscv_tcg_ops;
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 660078bda1..f0486183fa 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -38,5 +38,7 @@ riscv_system_ss.add(files(
   'riscv-qmp-cmds.c',
 ))
 
+subdir('tcg')
+
 target_arch += {'riscv': riscv_ss}
 target_softmmu_arch += {'riscv': riscv_system_ss}
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
new file mode 100644
index 0000000000..061df3d74a
--- /dev/null
+++ b/target/riscv/tcg/meson.build
@@ -0,0 +1,2 @@
+riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'tcg-cpu.c'))
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
new file mode 100644
index 0000000000..1ad27a26aa
--- /dev/null
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -0,0 +1,57 @@
+/*
+ * riscv TCG cpu class initialization
+ *
+ * Copyright (c) 2023 Ventana Micro Systems Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "qemu/accel.h"
+#include "hw/core/accel-cpu.h"
+
+static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
+{
+    /*
+     * All cpus use the same set of operations.
+     * riscv_tcg_ops is being imported from cpu.c for now.
+     */
+    cc->tcg_ops = &riscv_tcg_ops;
+}
+
+static void tcg_cpu_class_init(CPUClass *cc)
+{
+    cc->init_accel_cpu = tcg_cpu_init_ops;
+}
+
+static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_class_init = tcg_cpu_class_init;
+}
+
+static const TypeInfo tcg_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("tcg"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = tcg_cpu_accel_class_init,
+    .abstract = true,
+};
+static void tcg_cpu_accel_register_types(void)
+{
+    type_register_static(&tcg_cpu_accel_type_info);
+}
+type_init(tcg_cpu_accel_register_types);
-- 
2.41.0


