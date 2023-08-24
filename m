Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59406786469
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykO-0000FQ-Ds; Wed, 23 Aug 2023 21:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykH-00005d-W9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykD-0000QD-To
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68bed28cb22so299134b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838960; x=1693443760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wPP+gA6R3N32OGWovg7WhoS2VIkJuzBfzz5kdSKolx0=;
 b=fYTUWMZKN/pxaOvZVs2qKY+UGP1BsvENVeG48WlWS8/jQ7AhEugD2bq2poaIPcwpGD
 uQ6C3StayON9NTvks3M83N8zUynzqa17IzTrBB3kf669TVjTFv4A3xCtm5yuhUrBj/75
 u6I3E45tMbpLdfvmV84/fNm7Su466CO68gAnT4bsW+V88cl5xpatRBcZ+Qmdw2J1o0oI
 gZwZQhxXQvIAcxjaxAXJUp/VML85WI36+Jwi3nyVxDmEedkaGrWanaTIVbDkDTKmR/9F
 omLTj0d2EWXINQMExa2dH8wHRqkbDOZYJE5Zra99jmmbkETXK5639RVtqrPhsgD425Al
 OfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838960; x=1693443760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPP+gA6R3N32OGWovg7WhoS2VIkJuzBfzz5kdSKolx0=;
 b=YaGwXSCpDRt8VOjSAJF5J/8xhmeyWK62Oe0/TVPaBEVttawOIbrvfjsj53uVvFoEtl
 I8uE07yS38eXpRKkp9orLSFjgtK+AT5nDI7pUVYD8yH6SZDulhIBE6Xw9n1JSSBr94PQ
 XTCcEDZrDSBVdTu36EqWYx4gpjcELrOMczMnZYkWkEvkqveQeG8ZRw6RokNMN8G0/ULL
 34rALHRYUh4ZAsRkUeQiWwOw4oLw8rf/r9HHddt+x822U1gBroUrGhek0CKz8jtMt9bs
 lbFVAcHTN2xmef7TKSdI725D6GOAlBSPF8zx6kBscp26bjzyTF6+eyyOO1c5oJSSQ2lv
 RM1w==
X-Gm-Message-State: AOJu0YwLcf1tGPs5JORB5iBiwOe5VAVxI431EvK8JVrLJeoOwvvEAfQT
 ONr7ygmAyyZ4htkmXIfCf1cWlVAqsPcrobBh53s=
X-Google-Smtp-Source: AGHT+IGrcCPIIXBzzfHz417irmj9RbiM5/2ljplj1zeoBobc5aVxbONQlO8rbLVodAiiMfEjNw4xMg==
X-Received: by 2002:a05:6a20:1390:b0:149:26d1:f24c with SMTP id
 hn16-20020a056a20139000b0014926d1f24cmr8014014pzc.29.1692838960033; 
 Wed, 23 Aug 2023 18:02:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] linux-user: Split out cpu/target_proc.h
Date: Wed, 23 Aug 2023 18:02:25 -0700
Message-Id: <20230824010237.1379735-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Move the various open_cpuinfo functions into new files.
Move the m68k open_hardware function as well.
All other guest architectures get a boilerplate empty file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_proc.h     |   1 +
 linux-user/alpha/target_proc.h       |   1 +
 linux-user/arm/target_proc.h         |   1 +
 linux-user/cris/target_proc.h        |   1 +
 linux-user/hexagon/target_proc.h     |   1 +
 linux-user/hppa/target_proc.h        |  26 ++++
 linux-user/i386/target_proc.h        |   1 +
 linux-user/loongarch64/target_proc.h |   1 +
 linux-user/m68k/target_proc.h        |  16 +++
 linux-user/microblaze/target_proc.h  |   1 +
 linux-user/mips/target_proc.h        |   1 +
 linux-user/mips64/target_proc.h      |   1 +
 linux-user/nios2/target_proc.h       |   1 +
 linux-user/openrisc/target_proc.h    |   1 +
 linux-user/ppc/target_proc.h         |   1 +
 linux-user/riscv/target_proc.h       |  37 ++++++
 linux-user/s390x/target_proc.h       | 109 +++++++++++++++++
 linux-user/sh4/target_proc.h         |   1 +
 linux-user/sparc/target_proc.h       |  16 +++
 linux-user/x86_64/target_proc.h      |   1 +
 linux-user/xtensa/target_proc.h      |   1 +
 linux-user/syscall.c                 | 176 +--------------------------
 22 files changed, 226 insertions(+), 170 deletions(-)
 create mode 100644 linux-user/aarch64/target_proc.h
 create mode 100644 linux-user/alpha/target_proc.h
 create mode 100644 linux-user/arm/target_proc.h
 create mode 100644 linux-user/cris/target_proc.h
 create mode 100644 linux-user/hexagon/target_proc.h
 create mode 100644 linux-user/hppa/target_proc.h
 create mode 100644 linux-user/i386/target_proc.h
 create mode 100644 linux-user/loongarch64/target_proc.h
 create mode 100644 linux-user/m68k/target_proc.h
 create mode 100644 linux-user/microblaze/target_proc.h
 create mode 100644 linux-user/mips/target_proc.h
 create mode 100644 linux-user/mips64/target_proc.h
 create mode 100644 linux-user/nios2/target_proc.h
 create mode 100644 linux-user/openrisc/target_proc.h
 create mode 100644 linux-user/ppc/target_proc.h
 create mode 100644 linux-user/riscv/target_proc.h
 create mode 100644 linux-user/s390x/target_proc.h
 create mode 100644 linux-user/sh4/target_proc.h
 create mode 100644 linux-user/sparc/target_proc.h
 create mode 100644 linux-user/x86_64/target_proc.h
 create mode 100644 linux-user/xtensa/target_proc.h

diff --git a/linux-user/aarch64/target_proc.h b/linux-user/aarch64/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/aarch64/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/alpha/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/arm/target_proc.h b/linux-user/arm/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/arm/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/cris/target_proc.h b/linux-user/cris/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/cris/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/hexagon/target_proc.h b/linux-user/hexagon/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/hexagon/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/hppa/target_proc.h b/linux-user/hppa/target_proc.h
new file mode 100644
index 0000000000..9340c3b6af
--- /dev/null
+++ b/linux-user/hppa/target_proc.h
@@ -0,0 +1,26 @@
+/*
+ * HPPA specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HPPA_TARGET_PROC_H
+#define HPPA_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int i, num_cpus;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        dprintf(fd, "cpu family\t: PA-RISC 1.1e\n");
+        dprintf(fd, "cpu\t\t: PA7300LC (PCX-L2)\n");
+        dprintf(fd, "capabilities\t: os32\n");
+        dprintf(fd, "model\t\t: 9000/778/B160L - "
+                    "Merlin L2 160 QEMU (9000/778/B160L)\n\n");
+    }
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* HPPA_TARGET_PROC_H */
diff --git a/linux-user/i386/target_proc.h b/linux-user/i386/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/i386/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/loongarch64/target_proc.h b/linux-user/loongarch64/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/loongarch64/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/m68k/target_proc.h b/linux-user/m68k/target_proc.h
new file mode 100644
index 0000000000..3df8f28e22
--- /dev/null
+++ b/linux-user/m68k/target_proc.h
@@ -0,0 +1,16 @@
+/*
+ * M68K specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef M68K_TARGET_PROC_H
+#define M68K_TARGET_PROC_H
+
+static int open_hardware(CPUArchState *cpu_env, int fd)
+{
+    dprintf(fd, "Model:\t\tqemu-m68k\n");
+    return 0;
+}
+#define HAVE_ARCH_PROC_HARDWARE
+
+#endif /* M68K_TARGET_PROC_H */
diff --git a/linux-user/microblaze/target_proc.h b/linux-user/microblaze/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/microblaze/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/mips/target_proc.h b/linux-user/mips/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/mips/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/mips64/target_proc.h b/linux-user/mips64/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/mips64/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/nios2/target_proc.h b/linux-user/nios2/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/nios2/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/openrisc/target_proc.h b/linux-user/openrisc/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/openrisc/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/ppc/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/riscv/target_proc.h b/linux-user/riscv/target_proc.h
new file mode 100644
index 0000000000..c77c003d65
--- /dev/null
+++ b/linux-user/riscv/target_proc.h
@@ -0,0 +1,37 @@
+/*
+ * RISC-V specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef RISCV_TARGET_PROC_H
+#define RISCV_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int i;
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    RISCVCPU *cpu = env_archcpu(cpu_env);
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg((CPURISCVState *) cpu_env);
+    char *isa_string = riscv_isa_string(cpu);
+    const char *mmu;
+
+    if (cfg->mmu) {
+        mmu = (cpu_env->xl == MXL_RV32) ? "sv32"  : "sv48";
+    } else {
+        mmu = "none";
+    }
+
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        dprintf(fd, "hart\t\t: %d\n", i);
+        dprintf(fd, "isa\t\t: %s\n", isa_string);
+        dprintf(fd, "mmu\t\t: %s\n", mmu);
+        dprintf(fd, "uarch\t\t: qemu\n\n");
+    }
+
+    g_free(isa_string);
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* RISCV_TARGET_PROC_H */
diff --git a/linux-user/s390x/target_proc.h b/linux-user/s390x/target_proc.h
new file mode 100644
index 0000000000..a4a4821ea5
--- /dev/null
+++ b/linux-user/s390x/target_proc.h
@@ -0,0 +1,109 @@
+/*
+ * S390X specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef S390X_TARGET_PROC_H
+#define S390X_TARGET_PROC_H
+
+/*
+ * Emulate what a Linux kernel running in qemu-system-s390x -M accel=tcg would
+ * show in /proc/cpuinfo.
+ *
+ * Skip the following in order to match the missing support in op_ecag():
+ * - show_cacheinfo().
+ * - show_cpu_topology().
+ * - show_cpu_mhz().
+ *
+ * Use fixed values for certain fields:
+ * - bogomips per cpu - from a qemu-system-s390x run.
+ * - max thread id = 0, since SMT / SIGP_SET_MULTI_THREADING is not supported.
+ *
+ * Keep the code structure close to arch/s390/kernel/processor.c.
+ */
+
+static void show_facilities(int fd)
+{
+    size_t sizeof_stfl_bytes = 2048;
+    g_autofree uint8_t *stfl_bytes = g_new0(uint8_t, sizeof_stfl_bytes);
+    unsigned int bit;
+
+    dprintf(fd, "facilities      :");
+    s390_get_feat_block(S390_FEAT_TYPE_STFL, stfl_bytes);
+    for (bit = 0; bit < sizeof_stfl_bytes * 8; bit++) {
+        if (test_be_bit(bit, stfl_bytes)) {
+            dprintf(fd, " %d", bit);
+        }
+    }
+    dprintf(fd, "\n");
+}
+
+static int cpu_ident(unsigned long n)
+{
+    return deposit32(0, CPU_ID_BITS - CPU_PHYS_ADDR_BITS, CPU_PHYS_ADDR_BITS,
+                     n);
+}
+
+static void show_cpu_summary(CPUArchState *cpu_env, int fd)
+{
+    S390CPUModel *model = env_archcpu(cpu_env)->model;
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    uint32_t elf_hwcap = get_elf_hwcap();
+    const char *hwcap_str;
+    int i;
+
+    dprintf(fd, "vendor_id       : IBM/S390\n"
+                "# processors    : %i\n"
+                "bogomips per cpu: 13370.00\n",
+            num_cpus);
+    dprintf(fd, "max thread id   : 0\n");
+    dprintf(fd, "features\t: ");
+    for (i = 0; i < sizeof(elf_hwcap) * 8; i++) {
+        if (!(elf_hwcap & (1 << i))) {
+            continue;
+        }
+        hwcap_str = elf_hwcap_str(i);
+        if (hwcap_str) {
+            dprintf(fd, "%s ", hwcap_str);
+        }
+    }
+    dprintf(fd, "\n");
+    show_facilities(fd);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor %d: "
+               "version = %02X,  "
+               "identification = %06X,  "
+               "machine = %04X\n",
+               i, model->cpu_ver, cpu_ident(i), model->def->type);
+    }
+}
+
+static void show_cpu_ids(CPUArchState *cpu_env, int fd, unsigned long n)
+{
+    S390CPUModel *model = env_archcpu(cpu_env)->model;
+
+    dprintf(fd, "version         : %02X\n", model->cpu_ver);
+    dprintf(fd, "identification  : %06X\n", cpu_ident(n));
+    dprintf(fd, "machine         : %04X\n", model->def->type);
+}
+
+static void show_cpuinfo(CPUArchState *cpu_env, int fd, unsigned long n)
+{
+    dprintf(fd, "\ncpu number      : %ld\n", n);
+    show_cpu_ids(cpu_env, fd, n);
+}
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    int i;
+
+    show_cpu_summary(cpu_env, fd);
+    for (i = 0; i < num_cpus; i++) {
+        show_cpuinfo(cpu_env, fd, i);
+    }
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* S390X_TARGET_PROC_H */
diff --git a/linux-user/sh4/target_proc.h b/linux-user/sh4/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/sh4/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
new file mode 100644
index 0000000000..3bb3134a47
--- /dev/null
+++ b/linux-user/sparc/target_proc.h
@@ -0,0 +1,16 @@
+/*
+ * Sparc specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef SPARC_TARGET_PROC_H
+#define SPARC_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    dprintf(fd, "type\t\t: sun4u\n");
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* SPARC_TARGET_PROC_H */
diff --git a/linux-user/x86_64/target_proc.h b/linux-user/x86_64/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/x86_64/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/xtensa/target_proc.h b/linux-user/xtensa/target_proc.h
new file mode 100644
index 0000000000..43fe29ca72
--- /dev/null
+++ b/linux-user/xtensa/target_proc.h
@@ -0,0 +1 @@
+/* No target-specific /proc support */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..faad3a56df 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8339,9 +8339,11 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code)
     }
 }
 
+#include "target_proc.h"
+
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
-    defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA) || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+    defined(HAVE_ARCH_PROC_CPUINFO) || \
+    defined(HAVE_ARCH_PROC_HARDWARE)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -8393,171 +8395,6 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-#if defined(TARGET_SPARC)
-static int open_cpuinfo(CPUArchState *cpu_env, int fd)
-{
-    dprintf(fd, "type\t\t: sun4u\n");
-    return 0;
-}
-#endif
-
-#if defined(TARGET_HPPA)
-static int open_cpuinfo(CPUArchState *cpu_env, int fd)
-{
-    int i, num_cpus;
-
-    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-    for (i = 0; i < num_cpus; i++) {
-        dprintf(fd, "processor\t: %d\n", i);
-        dprintf(fd, "cpu family\t: PA-RISC 1.1e\n");
-        dprintf(fd, "cpu\t\t: PA7300LC (PCX-L2)\n");
-        dprintf(fd, "capabilities\t: os32\n");
-        dprintf(fd, "model\t\t: 9000/778/B160L - "
-                    "Merlin L2 160 QEMU (9000/778/B160L)\n\n");
-    }
-    return 0;
-}
-#endif
-
-#if defined(TARGET_RISCV)
-static int open_cpuinfo(CPUArchState *cpu_env, int fd)
-{
-    int i;
-    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-    RISCVCPU *cpu = env_archcpu(cpu_env);
-    const RISCVCPUConfig *cfg = riscv_cpu_cfg((CPURISCVState *) cpu_env);
-    char *isa_string = riscv_isa_string(cpu);
-    const char *mmu;
-
-    if (cfg->mmu) {
-        mmu = (cpu_env->xl == MXL_RV32) ? "sv32"  : "sv48";
-    } else {
-        mmu = "none";
-    }
-
-    for (i = 0; i < num_cpus; i++) {
-        dprintf(fd, "processor\t: %d\n", i);
-        dprintf(fd, "hart\t\t: %d\n", i);
-        dprintf(fd, "isa\t\t: %s\n", isa_string);
-        dprintf(fd, "mmu\t\t: %s\n", mmu);
-        dprintf(fd, "uarch\t\t: qemu\n\n");
-    }
-
-    g_free(isa_string);
-    return 0;
-}
-#endif
-
-#if defined(TARGET_S390X)
-/*
- * Emulate what a Linux kernel running in qemu-system-s390x -M accel=tcg would
- * show in /proc/cpuinfo.
- *
- * Skip the following in order to match the missing support in op_ecag():
- * - show_cacheinfo().
- * - show_cpu_topology().
- * - show_cpu_mhz().
- *
- * Use fixed values for certain fields:
- * - bogomips per cpu - from a qemu-system-s390x run.
- * - max thread id = 0, since SMT / SIGP_SET_MULTI_THREADING is not supported.
- *
- * Keep the code structure close to arch/s390/kernel/processor.c.
- */
-
-static void show_facilities(int fd)
-{
-    size_t sizeof_stfl_bytes = 2048;
-    g_autofree uint8_t *stfl_bytes = g_new0(uint8_t, sizeof_stfl_bytes);
-    unsigned int bit;
-
-    dprintf(fd, "facilities      :");
-    s390_get_feat_block(S390_FEAT_TYPE_STFL, stfl_bytes);
-    for (bit = 0; bit < sizeof_stfl_bytes * 8; bit++) {
-        if (test_be_bit(bit, stfl_bytes)) {
-            dprintf(fd, " %d", bit);
-        }
-    }
-    dprintf(fd, "\n");
-}
-
-static int cpu_ident(unsigned long n)
-{
-    return deposit32(0, CPU_ID_BITS - CPU_PHYS_ADDR_BITS, CPU_PHYS_ADDR_BITS,
-                     n);
-}
-
-static void show_cpu_summary(CPUArchState *cpu_env, int fd)
-{
-    S390CPUModel *model = env_archcpu(cpu_env)->model;
-    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-    uint32_t elf_hwcap = get_elf_hwcap();
-    const char *hwcap_str;
-    int i;
-
-    dprintf(fd, "vendor_id       : IBM/S390\n"
-                "# processors    : %i\n"
-                "bogomips per cpu: 13370.00\n",
-            num_cpus);
-    dprintf(fd, "max thread id   : 0\n");
-    dprintf(fd, "features\t: ");
-    for (i = 0; i < sizeof(elf_hwcap) * 8; i++) {
-        if (!(elf_hwcap & (1 << i))) {
-            continue;
-        }
-        hwcap_str = elf_hwcap_str(i);
-        if (hwcap_str) {
-            dprintf(fd, "%s ", hwcap_str);
-        }
-    }
-    dprintf(fd, "\n");
-    show_facilities(fd);
-    for (i = 0; i < num_cpus; i++) {
-        dprintf(fd, "processor %d: "
-               "version = %02X,  "
-               "identification = %06X,  "
-               "machine = %04X\n",
-               i, model->cpu_ver, cpu_ident(i), model->def->type);
-    }
-}
-
-static void show_cpu_ids(CPUArchState *cpu_env, int fd, unsigned long n)
-{
-    S390CPUModel *model = env_archcpu(cpu_env)->model;
-
-    dprintf(fd, "version         : %02X\n", model->cpu_ver);
-    dprintf(fd, "identification  : %06X\n", cpu_ident(n));
-    dprintf(fd, "machine         : %04X\n", model->def->type);
-}
-
-static void show_cpuinfo(CPUArchState *cpu_env, int fd, unsigned long n)
-{
-    dprintf(fd, "\ncpu number      : %ld\n", n);
-    show_cpu_ids(cpu_env, fd, n);
-}
-
-static int open_cpuinfo(CPUArchState *cpu_env, int fd)
-{
-    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-    int i;
-
-    show_cpu_summary(cpu_env, fd);
-    for (i = 0; i < num_cpus; i++) {
-        show_cpuinfo(cpu_env, fd, i);
-    }
-    return 0;
-}
-#endif
-
-#if defined(TARGET_M68K)
-static int open_hardware(CPUArchState *cpu_env, int fd)
-{
-    dprintf(fd, "Model:\t\tqemu-m68k\n");
-    return 0;
-}
-#endif
-
-
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
@@ -8578,11 +8415,10 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
-    defined(TARGET_RISCV) || defined(TARGET_S390X)
+#if defined(HAVE_ARCH_PROC_CPUINFO)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
-#if defined(TARGET_M68K)
+#if defined(HAVE_ARCH_PROC_HARDWARE)
         { "/proc/hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
-- 
2.34.1


