Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F147937DD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoey-0002xp-TU; Wed, 06 Sep 2023 05:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdoen-0002jH-Ba
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:06 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdoeh-0005bq-2U
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:03 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so2574839a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991817; x=1694596617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFl+a2Kq0b0p8yaPzRI+x2lm+P3JwkJ8h7I1Xdl+LTo=;
 b=J7fB+XfOUvArqxJLCvWgdG6ruB1fr75AG2yfiJ8RtOYCOhG9AnKsPvrV/07GZFUa+d
 1N83cKHTxnkkXaNKxvPMmq+9oZdYX9XxM5Bn57eOmbEvyHhiq42pWz85xYKo/95IQfyS
 XglBXHHa+pdO6jry8U+cKUeAYCR1PEY2U4peUF2g/MchFcEMFeEKyWN6feIFHF0kNyqw
 zcOHJdVI8wl8f1HcVOQWP7xkgLj3FYg0FiKGa/KqkBay/BksVpiJx2ItEDNMWDpFI2nU
 ksvSCwfW3P08DrxjzlSOU+LVfhFce+gugJzB1/3moxf0Su04x9p1yq424dXNlA1lQDlz
 LQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991817; x=1694596617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFl+a2Kq0b0p8yaPzRI+x2lm+P3JwkJ8h7I1Xdl+LTo=;
 b=PtXNqDnztIqFAgK9xiGYf4ch9cPIjlI2/WYG6tXIG4zTNq3tR07LpEUwGAeFqzAuA+
 Mkygfyd9qKgi9KO3JE31hN/sw7iO6B7WhnPW1B1hyfTL4LyNgsVZUA0MxGu48vJ90l4r
 1pbBdv+hdfyb5tpiRD0sdvMR3O6ReUqbEkKqAijPHoPrDRE70ToCcfk0HkgFTWEB6tX4
 ghT28IHAc0Mnpjnxrw5qdK+85LXRyy+pZwiSsxQ2aWwIDGl75CHgzBL+iUP6BpYWO04e
 Lm/iaut8sYqNctdWddX4kkORGm9wDXvpq75dFYOEaXXyphT/MUVY2K8vfKXKll01D8Hj
 hgWg==
X-Gm-Message-State: AOJu0YyM/lo1Wp8wocg48tX+ogxzxg8AZ9dlzt7igFBPFexhBXQIonTn
 oFyfkK+ab+KXPl5g8YNajChxhsSl+a/390FksMI=
X-Google-Smtp-Source: AGHT+IHhQxV2Lv5ABkIeJa+9VxQYE+0tk6eZltI2ZEs2jyq67O0cJhd87e68kgI9MxVntTxzeg3ilA==
X-Received: by 2002:a9d:7486:0:b0:6bf:1444:966d with SMTP id
 t6-20020a9d7486000000b006bf1444966dmr13991975otk.1.1693991817579; 
 Wed, 06 Sep 2023 02:16:57 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:16:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 01/19] target/riscv: introduce TCG AccelCPUClass
Date: Wed,  6 Sep 2023 06:16:28 -0300
Message-ID: <20230906091647.1667171-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c           |  5 +---
 target/riscv/cpu.h           |  4 +++
 target/riscv/meson.build     |  2 ++
 target/riscv/tcg/meson.build |  2 ++
 target/riscv/tcg/tcg-cpu.c   | 58 ++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100644 target/riscv/tcg/meson.build
 create mode 100644 target/riscv/tcg/tcg-cpu.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be1c028095..2c6972fa0d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2290,9 +2290,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
-
-static const struct TCGCPUOps riscv_tcg_ops = {
+const struct TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
@@ -2451,7 +2449,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
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
index 0000000000..0326cead0d
--- /dev/null
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -0,0 +1,58 @@
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
+
+static void tcg_cpu_accel_register_types(void)
+{
+    type_register_static(&tcg_cpu_accel_type_info);
+}
+type_init(tcg_cpu_accel_register_types);
-- 
2.41.0


