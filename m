Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B977C63F0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3n-0002Fm-Je; Thu, 12 Oct 2023 00:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3l-0002Du-3k
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3i-0002Rk-VZ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so465459b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083945; x=1697688745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlzYJROhiLIyuO19QiG5RWGq2L3zlLdSaonQrSH677s=;
 b=LoRkq9nyrDtVtunJbJCHDFkLzdfped4PM29S1KifTbw1VVxJKYwZzTXtrRakwkoC/f
 f4wb0kQfqaBA6d/X6ifuGlZVq4CH5RdUfuwgyuCNEVHIK7IWsK8IFN+f10zrYqHuD2LR
 gjPKLhCvVjDX5mq8YUgEpLaPxOeovbHT8XFwNH4Tyon0LnsYRVgWldNV8A5ecpFhWYaG
 /4FtilEX7eF0aMXzBjjA2MUxrahTFKbXWIvXaI7fF6X63r8Hfdg/23r3ANEsfz1cFe/+
 T1rNhkUJbzBX8nnfOl4wYX2+Dnm80VauZeOnx7FvoMekZyMPIrEWueaSujRO0CZw1r0S
 qNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083945; x=1697688745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlzYJROhiLIyuO19QiG5RWGq2L3zlLdSaonQrSH677s=;
 b=vEYc5sIfQnoqPbNUap9epbXfKIj4MfpC3zzNe2JI4Z+kBx1B3oaxKcxiq28aXaHJBj
 ogbKRMCBcT3LNWhKyjVsTcPzfdcvfE4tyktWKIS65QWBfpg4zqbnOw4X6uPymVbfWUUu
 uIRjEQ6WdFrmSBXJxlWXZxevryNkXbs8fzvXxSeW2n2yi9KQU5HEniY1BOKrypNpmlt7
 5dzN2vQ93WWiFqz2v/WokUcaHDEqUmI+OlpWgpVWfv//SHovTDydaVZJxm6niwubkTnS
 ves7BfoHYhR7u/R+LJD9GIQf6vs3muyMy2sRFM6NZbdX6uVZwurqI247C4ZFb4+1262U
 r/nA==
X-Gm-Message-State: AOJu0YxgF/vxLTwMyT1QM08GChC4KUdklyOEFHTjPYPxUUpnWn7ZCnui
 JcRmQ6qjApKkyLD5wIH2cYiVUGxaHRzULA==
X-Google-Smtp-Source: AGHT+IH5dzsiPRgS12DKX+30D03AITYL+TUouUxyzErWSbVAQOdkD2f5rnRsvih12SxERQGdull6IQ==
X-Received: by 2002:a05:6a20:3d8a:b0:174:327c:db1e with SMTP id
 s10-20020a056a203d8a00b00174327cdb1emr2872018pzi.26.1697083944699; 
 Wed, 11 Oct 2023 21:12:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/54] target/riscv: introduce TCG AccelCPUClass
Date: Thu, 12 Oct 2023 14:10:20 +1000
Message-ID: <20231012041051.2572507-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  4 +++
 target/riscv/cpu.c           |  5 +---
 target/riscv/tcg/tcg-cpu.c   | 58 ++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build     |  2 ++
 target/riscv/tcg/meson.build |  2 ++
 5 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100644 target/riscv/tcg/tcg-cpu.c
 create mode 100644 target/riscv/tcg/meson.build

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cce6dee729..1bd736a1a0 100644
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
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 383e5df2a7..89ce316294 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2284,9 +2284,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
-
-static const struct TCGCPUOps riscv_tcg_ops = {
+const struct TCGCPUOps riscv_tcg_ops = {
     .initialize = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
@@ -2445,7 +2443,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
-    cc->tcg_ops = &riscv_tcg_ops;
 
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
new file mode 100644
index 0000000000..795a8f06b2
--- /dev/null
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -0,0 +1,58 @@
+/*
+ * riscv TCG cpu class initialization
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
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
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index ff60b21d04..b4ded65e41 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -38,5 +38,7 @@ riscv_system_ss.add(files(
   'riscv-qmp-cmds.c',
 ))
 
+subdir('tcg')
+
 target_arch += {'riscv': riscv_ss}
 target_system_arch += {'riscv': riscv_system_ss}
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
new file mode 100644
index 0000000000..061df3d74a
--- /dev/null
+++ b/target/riscv/tcg/meson.build
@@ -0,0 +1,2 @@
+riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'tcg-cpu.c'))
-- 
2.41.0


