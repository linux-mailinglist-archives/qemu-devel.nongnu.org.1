Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A077158A
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSeWj-0006gg-1o; Sun, 06 Aug 2023 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSeWg-0006dS-DG
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:14:34 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSeWb-00063O-SN
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:14:34 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 27BE243C3D;
 Sun,  6 Aug 2023 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691331266; bh=kV5jKpOZVare6D5Zx1y7SsK2IT7dMT+yJtSO9xALZ40=;
 h=From:To:Cc:Subject:Date;
 b=dotuG/gWRHTLUc2mGYHqzlVZqxLrZo6qvvZaSabAru/KP88i/7PZ0M8iMyWQM1uy1
 jsQiDtcqXoWeSOwyVdEkJFY4sBR703Se3WzXKAe/s/X0vs4sbld/GkyUjDOKtiyVtU
 4UEaRjC3FOV0kHZCKJJbNgzTw58R0wvqAt7GOdmw=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] target/loongarch: Introduce loongarch32-softmmu target
Date: Sun,  6 Aug 2023 22:13:54 +0800
Message-Id: <20230806141357.1756714-1-c@jia.je>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This commit introduces new loongarch32-softmmu target. Compared to
loongarch64-softmmu, the new target is different at least in:

- GPRs and CSRs are 32-bits wide, but FPRs are still 64-bits wide
- LA32 lacks some 64-bit-only instructions
- CSR.DMW0-3 introduces PSEG

More differences are to be handled in the following commits.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 .../devices/loongarch32-softmmu/default.mak   |   3 +
 configs/targets/loongarch32-softmmu.mak       |   5 +
 gdb-xml/loongarch-base32.xml                  |  45 +++++++
 qapi/machine-target.json                      |   4 +-
 target/loongarch/Kconfig                      |   3 +
 target/loongarch/cpu-csr.h                    |   7 +-
 target/loongarch/cpu-param.h                  |   6 +
 target/loongarch/cpu.c                        |  30 ++---
 target/loongarch/cpu.h                        | 112 +++++++++---------
 target/loongarch/helper.h                     |  24 ++--
 target/loongarch/insn_trans/trans_arith.c.inc |  40 ++++---
 .../loongarch/insn_trans/trans_atomic.c.inc   |   6 +-
 target/loongarch/insn_trans/trans_bit.c.inc   |  40 ++++---
 target/loongarch/insn_trans/trans_extra.c.inc |   2 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |  52 ++++----
 target/loongarch/insn_trans/trans_fcmp.c.inc  |  16 +--
 .../loongarch/insn_trans/trans_fmemory.c.inc  |  34 +++---
 target/loongarch/insn_trans/trans_fmov.c.inc  |  88 +++++++++-----
 target/loongarch/insn_trans/trans_lsx.c.inc   |  63 +++++-----
 target/loongarch/iocsr_helper.c               |   8 +-
 target/loongarch/machine.c                    | 106 ++++++++---------
 target/loongarch/op_helper.c                  |   6 +-
 target/loongarch/tlb_helper.c                 |  25 +++-
 target/loongarch/translate.c                  |   6 +-
 target/loongarch/translate.h                  |   9 ++
 25 files changed, 435 insertions(+), 305 deletions(-)
 create mode 100644 configs/devices/loongarch32-softmmu/default.mak
 create mode 100644 configs/targets/loongarch32-softmmu.mak
 create mode 100644 gdb-xml/loongarch-base32.xml

diff --git a/configs/devices/loongarch32-softmmu/default.mak b/configs/devices/loongarch32-softmmu/default.mak
new file mode 100644
index 0000000000..a8d3a9d554
--- /dev/null
+++ b/configs/devices/loongarch32-softmmu/default.mak
@@ -0,0 +1,3 @@
+# Default configuration for loongarch32-softmmu
+
+CONFIG_LOONGARCH_VIRT=y
diff --git a/configs/targets/loongarch32-softmmu.mak b/configs/targets/loongarch32-softmmu.mak
new file mode 100644
index 0000000000..c13b7eb1ae
--- /dev/null
+++ b/configs/targets/loongarch32-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_ARCH=loongarch32
+TARGET_BASE_ARCH=loongarch
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-fpu.xml
+TARGET_NEED_FDT=y
diff --git a/gdb-xml/loongarch-base32.xml b/gdb-xml/loongarch-base32.xml
new file mode 100644
index 0000000000..af47bbd3da
--- /dev/null
+++ b/gdb-xml/loongarch-base32.xml
@@ -0,0 +1,45 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2022 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.loongarch.base">
+  <reg name="r0" bitsize="32" type="uint32" group="general"/>
+  <reg name="r1" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="r2" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r3" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r4" bitsize="32" type="uint32" group="general"/>
+  <reg name="r5" bitsize="32" type="uint32" group="general"/>
+  <reg name="r6" bitsize="32" type="uint32" group="general"/>
+  <reg name="r7" bitsize="32" type="uint32" group="general"/>
+  <reg name="r8" bitsize="32" type="uint32" group="general"/>
+  <reg name="r9" bitsize="32" type="uint32" group="general"/>
+  <reg name="r10" bitsize="32" type="uint32" group="general"/>
+  <reg name="r11" bitsize="32" type="uint32" group="general"/>
+  <reg name="r12" bitsize="32" type="uint32" group="general"/>
+  <reg name="r13" bitsize="32" type="uint32" group="general"/>
+  <reg name="r14" bitsize="32" type="uint32" group="general"/>
+  <reg name="r15" bitsize="32" type="uint32" group="general"/>
+  <reg name="r16" bitsize="32" type="uint32" group="general"/>
+  <reg name="r17" bitsize="32" type="uint32" group="general"/>
+  <reg name="r18" bitsize="32" type="uint32" group="general"/>
+  <reg name="r19" bitsize="32" type="uint32" group="general"/>
+  <reg name="r20" bitsize="32" type="uint32" group="general"/>
+  <reg name="r21" bitsize="32" type="uint32" group="general"/>
+  <reg name="r22" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r23" bitsize="32" type="uint32" group="general"/>
+  <reg name="r24" bitsize="32" type="uint32" group="general"/>
+  <reg name="r25" bitsize="32" type="uint32" group="general"/>
+  <reg name="r26" bitsize="32" type="uint32" group="general"/>
+  <reg name="r27" bitsize="32" type="uint32" group="general"/>
+  <reg name="r28" bitsize="32" type="uint32" group="general"/>
+  <reg name="r29" bitsize="32" type="uint32" group="general"/>
+  <reg name="r30" bitsize="32" type="uint32" group="general"/>
+  <reg name="r31" bitsize="32" type="uint32" group="general"/>
+  <reg name="orig_a0" bitsize="32" type="uint32" group="general"/>
+  <reg name="pc" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="badv" bitsize="32" type="code_ptr" group="general"/>
+</feature>
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f0a6b72414..a728e14c86 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -341,7 +341,7 @@
                    'TARGET_I386',
                    'TARGET_S390X',
                    'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
 
 ##
@@ -359,5 +359,5 @@
                    'TARGET_I386',
                    'TARGET_S390X',
                    'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
diff --git a/target/loongarch/Kconfig b/target/loongarch/Kconfig
index 46b26b1a85..a834f20ed8 100644
--- a/target/loongarch/Kconfig
+++ b/target/loongarch/Kconfig
@@ -1,2 +1,5 @@
 config LOONGARCH64
     bool
+
+config LOONGARCH32
+    bool
diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index f8f24032cb..439eb1b578 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -187,10 +187,9 @@ FIELD(CSR_DMW, PLV1, 1, 1)
 FIELD(CSR_DMW, PLV2, 2, 1)
 FIELD(CSR_DMW, PLV3, 3, 1)
 FIELD(CSR_DMW, MAT, 4, 2)
-FIELD(CSR_DMW, VSEG, 60, 4)
-
-#define dmw_va2pa(va) \
-    (va & MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS))
+FIELD(CSR_DMW_32, PSEG, 25, 3)
+FIELD(CSR_DMW_32, VSEG, 29, 3)
+FIELD(CSR_DMW_64, VSEG, 60, 4)
 
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 1265dc7cb5..53030ea00e 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -8,9 +8,15 @@
 #ifndef LOONGARCH_CPU_PARAM_H
 #define LOONGARCH_CPU_PARAM_H
 
+#ifdef TARGET_LOONGARCH32
+#define TARGET_LONG_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS 36
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#else
 #define TARGET_LONG_BITS 64
 #define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
+#endif
 
 #define TARGET_PAGE_BITS 14
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..b513531ac8 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -626,7 +626,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     CPULoongArchState *env = &cpu->env;
     int i;
 
-    qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    qemu_fprintf(f, " PC=" TARGET_FMT_lx " ", env->pc);
     qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0,
                  get_float_exception_flags(&env->fp_status));
 
@@ -635,26 +635,26 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         if ((i & 3) == 0) {
             qemu_fprintf(f, " GPR%02d:", i);
         }
-        qemu_fprintf(f, " %s %016" PRIx64, regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx, regnames[i], env->gpr[i]);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
     }
 
-    qemu_fprintf(f, "CRMD=%016" PRIx64 "\n", env->CSR_CRMD);
-    qemu_fprintf(f, "PRMD=%016" PRIx64 "\n", env->CSR_PRMD);
-    qemu_fprintf(f, "EUEN=%016" PRIx64 "\n", env->CSR_EUEN);
-    qemu_fprintf(f, "ESTAT=%016" PRIx64 "\n", env->CSR_ESTAT);
-    qemu_fprintf(f, "ERA=%016" PRIx64 "\n", env->CSR_ERA);
-    qemu_fprintf(f, "BADV=%016" PRIx64 "\n", env->CSR_BADV);
-    qemu_fprintf(f, "BADI=%016" PRIx64 "\n", env->CSR_BADI);
-    qemu_fprintf(f, "EENTRY=%016" PRIx64 "\n", env->CSR_EENTRY);
-    qemu_fprintf(f, "PRCFG1=%016" PRIx64 ", PRCFG2=%016" PRIx64 ","
-                 " PRCFG3=%016" PRIx64 "\n",
+    qemu_fprintf(f, "CRMD=" TARGET_FMT_lx "\n", env->CSR_CRMD);
+    qemu_fprintf(f, "PRMD=" TARGET_FMT_lx "\n", env->CSR_PRMD);
+    qemu_fprintf(f, "EUEN=" TARGET_FMT_lx "\n", env->CSR_EUEN);
+    qemu_fprintf(f, "ESTAT=" TARGET_FMT_lx "\n", env->CSR_ESTAT);
+    qemu_fprintf(f, "ERA=" TARGET_FMT_lx "\n", env->CSR_ERA);
+    qemu_fprintf(f, "BADV=" TARGET_FMT_lx "\n", env->CSR_BADV);
+    qemu_fprintf(f, "BADI=" TARGET_FMT_lx "\n", env->CSR_BADI);
+    qemu_fprintf(f, "EENTRY=" TARGET_FMT_lx "\n", env->CSR_EENTRY);
+    qemu_fprintf(f, "PRCFG1=" TARGET_FMT_lx ", PRCFG2=" TARGET_FMT_lx ","
+                 " PRCFG3=" TARGET_FMT_lx "\n",
                  env->CSR_PRCFG1, env->CSR_PRCFG3, env->CSR_PRCFG3);
-    qemu_fprintf(f, "TLBRENTRY=%016" PRIx64 "\n", env->CSR_TLBRENTRY);
-    qemu_fprintf(f, "TLBRBADV=%016" PRIx64 "\n", env->CSR_TLBRBADV);
-    qemu_fprintf(f, "TLBRERA=%016" PRIx64 "\n", env->CSR_TLBRERA);
+    qemu_fprintf(f, "TLBRENTRY=" TARGET_FMT_lx "\n", env->CSR_TLBRENTRY);
+    qemu_fprintf(f, "TLBRBADV=" TARGET_FMT_lx "\n", env->CSR_TLBRBADV);
+    qemu_fprintf(f, "TLBRERA=" TARGET_FMT_lx "\n", env->CSR_TLBRERA);
 
     /* fpr */
     if (flags & CPU_DUMP_FPU) {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..37712cc590 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -273,8 +273,8 @@ struct LoongArchTLB {
 typedef struct LoongArchTLB LoongArchTLB;
 
 typedef struct CPUArchState {
-    uint64_t gpr[32];
-    uint64_t pc;
+    target_ulong gpr[32];
+    target_ulong pc;
 
     fpr_t fpr[32];
     float_status fp_status;
@@ -289,60 +289,60 @@ typedef struct CPUArchState {
     uint64_t llval;
 
     /* LoongArch CSRs */
-    uint64_t CSR_CRMD;
-    uint64_t CSR_PRMD;
-    uint64_t CSR_EUEN;
-    uint64_t CSR_MISC;
-    uint64_t CSR_ECFG;
-    uint64_t CSR_ESTAT;
-    uint64_t CSR_ERA;
-    uint64_t CSR_BADV;
-    uint64_t CSR_BADI;
-    uint64_t CSR_EENTRY;
-    uint64_t CSR_TLBIDX;
-    uint64_t CSR_TLBEHI;
-    uint64_t CSR_TLBELO0;
-    uint64_t CSR_TLBELO1;
-    uint64_t CSR_ASID;
-    uint64_t CSR_PGDL;
-    uint64_t CSR_PGDH;
-    uint64_t CSR_PGD;
-    uint64_t CSR_PWCL;
-    uint64_t CSR_PWCH;
-    uint64_t CSR_STLBPS;
-    uint64_t CSR_RVACFG;
-    uint64_t CSR_PRCFG1;
-    uint64_t CSR_PRCFG2;
-    uint64_t CSR_PRCFG3;
-    uint64_t CSR_SAVE[16];
-    uint64_t CSR_TID;
-    uint64_t CSR_TCFG;
-    uint64_t CSR_TVAL;
-    uint64_t CSR_CNTC;
-    uint64_t CSR_TICLR;
-    uint64_t CSR_LLBCTL;
-    uint64_t CSR_IMPCTL1;
-    uint64_t CSR_IMPCTL2;
-    uint64_t CSR_TLBRENTRY;
-    uint64_t CSR_TLBRBADV;
-    uint64_t CSR_TLBRERA;
-    uint64_t CSR_TLBRSAVE;
-    uint64_t CSR_TLBRELO0;
-    uint64_t CSR_TLBRELO1;
-    uint64_t CSR_TLBREHI;
-    uint64_t CSR_TLBRPRMD;
-    uint64_t CSR_MERRCTL;
-    uint64_t CSR_MERRINFO1;
-    uint64_t CSR_MERRINFO2;
-    uint64_t CSR_MERRENTRY;
-    uint64_t CSR_MERRERA;
-    uint64_t CSR_MERRSAVE;
-    uint64_t CSR_CTAG;
-    uint64_t CSR_DMW[4];
-    uint64_t CSR_DBG;
-    uint64_t CSR_DERA;
-    uint64_t CSR_DSAVE;
-    uint64_t CSR_CPUID;
+    target_ulong CSR_CRMD;
+    target_ulong CSR_PRMD;
+    target_ulong CSR_EUEN;
+    target_ulong CSR_MISC;
+    target_ulong CSR_ECFG;
+    target_ulong CSR_ESTAT;
+    target_ulong CSR_ERA;
+    target_ulong CSR_BADV;
+    target_ulong CSR_BADI;
+    target_ulong CSR_EENTRY;
+    target_ulong CSR_TLBIDX;
+    target_ulong CSR_TLBEHI;
+    target_ulong CSR_TLBELO0;
+    target_ulong CSR_TLBELO1;
+    target_ulong CSR_ASID;
+    target_ulong CSR_PGDL;
+    target_ulong CSR_PGDH;
+    target_ulong CSR_PGD;
+    target_ulong CSR_PWCL;
+    target_ulong CSR_PWCH;
+    target_ulong CSR_STLBPS;
+    target_ulong CSR_RVACFG;
+    target_ulong CSR_PRCFG1;
+    target_ulong CSR_PRCFG2;
+    target_ulong CSR_PRCFG3;
+    target_ulong CSR_SAVE[16];
+    target_ulong CSR_TID;
+    target_ulong CSR_TCFG;
+    target_ulong CSR_TVAL;
+    target_ulong CSR_CNTC;
+    target_ulong CSR_TICLR;
+    target_ulong CSR_LLBCTL;
+    target_ulong CSR_IMPCTL1;
+    target_ulong CSR_IMPCTL2;
+    target_ulong CSR_TLBRENTRY;
+    target_ulong CSR_TLBRBADV;
+    target_ulong CSR_TLBRERA;
+    target_ulong CSR_TLBRSAVE;
+    target_ulong CSR_TLBRELO0;
+    target_ulong CSR_TLBRELO1;
+    target_ulong CSR_TLBREHI;
+    target_ulong CSR_TLBRPRMD;
+    target_ulong CSR_MERRCTL;
+    target_ulong CSR_MERRINFO1;
+    target_ulong CSR_MERRINFO2;
+    target_ulong CSR_MERRENTRY;
+    target_ulong CSR_MERRERA;
+    target_ulong CSR_MERRSAVE;
+    target_ulong CSR_CTAG;
+    target_ulong CSR_DMW[4];
+    target_ulong CSR_DBG;
+    target_ulong CSR_DERA;
+    target_ulong CSR_DSAVE;
+    target_ulong CSR_CPUID;
 
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index ffb1e0b0bf..1c41816b9a 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -93,21 +93,21 @@ DEF_HELPER_2(frint_d, i64, env, i64)
 
 DEF_HELPER_FLAGS_1(set_rounding_mode, TCG_CALL_NO_RWG, void, env)
 
-DEF_HELPER_1(rdtime_d, i64, env)
+DEF_HELPER_1(rdtime_d, tl, env)
 
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
-DEF_HELPER_1(csrrd_pgd, i64, env)
-DEF_HELPER_1(csrrd_cpuid, i64, env)
-DEF_HELPER_1(csrrd_tval, i64, env)
-DEF_HELPER_2(csrwr_estat, i64, env, tl)
-DEF_HELPER_2(csrwr_asid, i64, env, tl)
-DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
-DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
-DEF_HELPER_2(iocsrrd_b, i64, env, tl)
-DEF_HELPER_2(iocsrrd_h, i64, env, tl)
-DEF_HELPER_2(iocsrrd_w, i64, env, tl)
-DEF_HELPER_2(iocsrrd_d, i64, env, tl)
+DEF_HELPER_1(csrrd_pgd, tl, env)
+DEF_HELPER_1(csrrd_cpuid, tl, env)
+DEF_HELPER_1(csrrd_tval, tl, env)
+DEF_HELPER_2(csrwr_estat, tl, env, tl)
+DEF_HELPER_2(csrwr_asid, tl, env, tl)
+DEF_HELPER_2(csrwr_tcfg, tl, env, tl)
+DEF_HELPER_2(csrwr_ticlr, tl, env, tl)
+DEF_HELPER_2(iocsrrd_b, tl, env, tl)
+DEF_HELPER_2(iocsrrd_h, tl, env, tl)
+DEF_HELPER_2(iocsrrd_w, tl, env, tl)
+DEF_HELPER_2(iocsrrd_d, tl, env, tl)
 DEF_HELPER_3(iocsrwr_b, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_h, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_w, void, env, tl, tl)
diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index 43d6cf261d..b6fb286446 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -92,10 +92,11 @@ static void gen_sltu(TCGv dest, TCGv src1, TCGv src2)
 
 static void gen_mulh_w(TCGv dest, TCGv src1, TCGv src2)
 {
-    tcg_gen_mul_i64(dest, src1, src2);
-    tcg_gen_sari_i64(dest, dest, 32);
+    tcg_gen_mul_tl(dest, src1, src2);
+    tcg_gen_sari_tl(dest, dest, 32);
 }
 
+#ifdef TARGET_LOONGARCH64
 static void gen_mulh_d(TCGv dest, TCGv src1, TCGv src2)
 {
     TCGv discard = tcg_temp_new();
@@ -128,6 +129,7 @@ static void prep_divisor_d(TCGv ret, TCGv src1, TCGv src2)
     tcg_gen_or_tl(ret, ret, t1);
     tcg_gen_movcond_tl(TCG_COND_NE, ret, ret, zero, ret, src2);
 }
+#endif
 
 static void prep_divisor_du(TCGv ret, TCGv src2)
 {
@@ -142,6 +144,7 @@ static void prep_divisor_du(TCGv ret, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_EQ, ret, src2, zero, one, src2);
 }
 
+#ifdef TARGET_LOONGARCH64
 static void gen_div_d(TCGv dest, TCGv src1, TCGv src2)
 {
     TCGv t0 = tcg_temp_new();
@@ -155,6 +158,7 @@ static void gen_rem_d(TCGv dest, TCGv src1, TCGv src2)
     prep_divisor_d(t0, src1, src2);
     tcg_gen_rem_tl(dest, src1, t0);
 }
+#endif
 
 static void gen_div_du(TCGv dest, TCGv src1, TCGv src2)
 {
@@ -232,10 +236,12 @@ static target_ulong gen_pcaddu12i(target_ulong pc, int imm)
     return pc + (imm << 12);
 }
 
+#ifdef TARGET_LOONGARCH64
 static target_ulong gen_pcaddu18i(target_ulong pc, int imm)
 {
     return pc + ((target_ulong)(imm) << 18);
 }
+#endif
 
 static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
 {
@@ -249,9 +255,9 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
 }
 
 TRANS(add_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
-TRANS(add_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
+TRANS_64(add_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
 TRANS(sub_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
-TRANS(sub_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
+TRANS_64(sub_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
 TRANS(and, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
 TRANS(or, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
 TRANS(xor, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
@@ -261,32 +267,32 @@ TRANS(orn, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
 TRANS(slt, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltu, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(mul_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
-TRANS(mul_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mul_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
 TRANS(mulh_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
 TRANS(mulh_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
-TRANS(mulh_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
-TRANS(mulh_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
-TRANS(mulw_d_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
-TRANS(mulw_d_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mulh_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
+TRANS_64(mulh_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
+TRANS_64(mulw_d_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mulw_d_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
 TRANS(div_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
 TRANS(mod_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
 TRANS(div_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
 TRANS(mod_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
-TRANS(div_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
-TRANS(mod_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
-TRANS(div_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
-TRANS(mod_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
+TRANS_64(div_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
+TRANS_64(mod_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
+TRANS_64(div_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
+TRANS_64(mod_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
 TRANS(slti, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltui, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(addi_w, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
-TRANS(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
+TRANS_64(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
 TRANS(alsl_w, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
-TRANS(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
-TRANS(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
+TRANS_64(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
+TRANS_64(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
 TRANS(pcaddi, gen_pc, gen_pcaddi)
 TRANS(pcalau12i, gen_pc, gen_pcalau12i)
 TRANS(pcaddu12i, gen_pc, gen_pcaddu12i)
-TRANS(pcaddu18i, gen_pc, gen_pcaddu18i)
+TRANS_64(pcaddu18i, gen_pc, gen_pcaddu18i)
 TRANS(andi, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
 TRANS(ori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
 TRANS(xori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 612709f2a7..d3d8babd5e 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -10,7 +10,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv t0 = tcg_temp_new();
 
     tcg_gen_addi_tl(t0, src1, a->imm);
-    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_tl(dest, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -70,8 +70,8 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
 TRANS(ll_w, gen_ll, MO_TESL)
 TRANS(sc_w, gen_sc, MO_TESL)
-TRANS(ll_d, gen_ll, MO_TEUQ)
-TRANS(sc_d, gen_sc, MO_TEUQ)
+TRANS_64(ll_d, gen_ll, MO_TEUQ)
+TRANS_64(sc_d, gen_sc, MO_TEUQ)
 TRANS(amswap_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
 TRANS(amswap_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
 TRANS(amadd_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 25b4d7858b..80877a1b15 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -18,14 +18,20 @@ static bool gen_rr(DisasContext *ctx, arg_rr *a,
 
 static void gen_bytepick_w(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
+#ifdef TARGET_LOONGARCH32
+    tcg_gen_extract2_tl(dest, src1, src2, (32 - sa * 8));
+#else
     tcg_gen_concat_tl_i64(dest, src1, src2);
     tcg_gen_sextract_i64(dest, dest, (32 - sa * 8), 32);
+#endif
 }
 
+#ifdef TARGET_LOONGARCH64
 static void gen_bytepick_d(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
     tcg_gen_extract2_i64(dest, src1, src2, (64 - sa * 8));
 }
+#endif
 
 static bool gen_bstrins(DisasContext *ctx, arg_rr_ms_ls *a,
                         DisasExtend dst_ext)
@@ -83,9 +89,10 @@ static void gen_cto_w(TCGv dest, TCGv src1)
     gen_ctz_w(dest, dest);
 }
 
+#ifdef TARGET_LOONGARCH64
 static void gen_clz_d(TCGv dest, TCGv src1)
 {
-    tcg_gen_clzi_i64(dest, src1, TARGET_LONG_BITS);
+    tcg_gen_clzi_tl(dest, src1, TARGET_LONG_BITS);
 }
 
 static void gen_clo_d(TCGv dest, TCGv src1)
@@ -110,6 +117,7 @@ static void gen_revb_2w(TCGv dest, TCGv src1)
     tcg_gen_bswap64_i64(dest, src1);
     tcg_gen_rotri_i64(dest, dest, 32);
 }
+#endif
 
 static void gen_revb_2h(TCGv dest, TCGv src1)
 {
@@ -124,6 +132,7 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
     tcg_gen_or_tl(dest, t0, t1);
 }
 
+#ifdef TARGET_LOONGARCH64
 static void gen_revb_4h(TCGv dest, TCGv src1)
 {
     TCGv mask = tcg_constant_tl(0x00FF00FF00FF00FFULL);
@@ -163,6 +172,7 @@ static void gen_revh_d(TCGv dest, TCGv src1)
     tcg_gen_or_tl(t0, t0, t1);
     tcg_gen_rotri_tl(dest, t0, 32);
 }
+#endif
 
 static void gen_maskeqz(TCGv dest, TCGv src1, TCGv src2)
 {
@@ -184,25 +194,25 @@ TRANS(clo_w, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
 TRANS(clz_w, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
 TRANS(cto_w, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
 TRANS(ctz_w, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
-TRANS(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
-TRANS(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
-TRANS(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
-TRANS(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
+TRANS_64(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
+TRANS_64(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
+TRANS_64(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
+TRANS_64(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
 TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
-TRANS(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
-TRANS(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS_64(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS_64(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
+TRANS_64(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS_64(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
+TRANS_64(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
 TRANS(bitrev_4b, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS_64(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
 TRANS(bitrev_w, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS_64(bitrev_d, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
 TRANS(maskeqz, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-TRANS(bytepick_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
+TRANS_64(bytepick_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
 TRANS(bstrins_w, gen_bstrins, EXT_SIGN)
-TRANS(bstrins_d, gen_bstrins, EXT_NONE)
+TRANS_64(bstrins_d, gen_bstrins, EXT_NONE)
 TRANS(bstrpick_w, gen_bstrpick, EXT_SIGN)
-TRANS(bstrpick_d, gen_bstrpick, EXT_NONE)
+TRANS_64(bstrpick_d, gen_bstrpick, EXT_NONE)
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index 06f4de4515..2beb858582 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -44,7 +44,7 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
     if (word) {
         tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
     }
-    tcg_gen_ld_i64(dst2, cpu_env, offsetof(CPULoongArchState, CSR_TID));
+    tcg_gen_ld_tl(dst2, cpu_env, offsetof(CPULoongArchState, CSR_TID));
 
     return true;
 }
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index 21ea47308b..fa146706bc 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -15,11 +15,11 @@
 #endif
 
 static bool gen_fff(DisasContext *ctx, arg_fff *a,
-                    void (*func)(TCGv, TCGv_env, TCGv, TCGv))
+                    void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
 
     CHECK_FPE;
 
@@ -30,10 +30,10 @@ static bool gen_fff(DisasContext *ctx, arg_fff *a,
 }
 
 static bool gen_ff(DisasContext *ctx, arg_ff *a,
-                   void (*func)(TCGv, TCGv_env, TCGv))
+                   void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -44,14 +44,14 @@ static bool gen_ff(DisasContext *ctx, arg_ff *a,
 }
 
 static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
-                       void (*func)(TCGv, TCGv_env, TCGv, TCGv, TCGv, TCGv_i32),
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i32),
                        int flag)
 {
     TCGv_i32 tflag = tcg_constant_i32(flag);
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
-    TCGv src3 = get_fpr(ctx, a->fa);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 src3 = get_fpr(ctx, a->fa);
 
     CHECK_FPE;
 
@@ -63,9 +63,9 @@ static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
 
 static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fk);
-    TCGv src2 = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fk);
+    TCGv_i64 src2 = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -77,9 +77,9 @@ static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
 
 static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fk);
-    TCGv src2 = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fk);
+    TCGv_i64 src2 = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -91,8 +91,8 @@ static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
 
 static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -105,8 +105,8 @@ static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
 
 static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -118,8 +118,8 @@ static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
 
 static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -132,8 +132,8 @@ static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
 
 static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
diff --git a/target/loongarch/insn_trans/trans_fcmp.c.inc b/target/loongarch/insn_trans/trans_fcmp.c.inc
index a78868dbc4..ebef54f495 100644
--- a/target/loongarch/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/insn_trans/trans_fcmp.c.inc
@@ -25,13 +25,13 @@ static uint32_t get_fcmp_flags(int cond)
 
 static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 {
-    TCGv var, src1, src2;
+    TCGv_i64 var, src1, src2;
     uint32_t flags;
-    void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
+    void (*fn)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64, TCGv_i32);
 
     CHECK_FPE;
 
-    var = tcg_temp_new();
+    var = tcg_temp_new_i64();
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
@@ -39,19 +39,19 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 
     fn(var, cpu_env, src1, src2, tcg_constant_i32(flags));
 
-    tcg_gen_st8_tl(var, cpu_env, offsetof(CPULoongArchState, cf[a->cd]));
+    tcg_gen_st8_i64(var, cpu_env, offsetof(CPULoongArchState, cf[a->cd]));
     return true;
 }
 
 static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 {
-    TCGv var, src1, src2;
+    TCGv_i64 var, src1, src2;
     uint32_t flags;
-    void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
+    void (*fn)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64, TCGv_i32);
 
     CHECK_FPE;
 
-    var = tcg_temp_new();
+    var = tcg_temp_new_i64();
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
@@ -59,6 +59,6 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 
     fn(var, cpu_env, src1, src2, tcg_constant_i32(flags));
 
-    tcg_gen_st8_tl(var, cpu_env, offsetof(CPULoongArchState, cf[a->cd]));
+    tcg_gen_st8_i64(var, cpu_env, offsetof(CPULoongArchState, cf[a->cd]));
     return true;
 }
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 91c09fb6d9..6e46782666 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-static void maybe_nanbox_load(TCGv freg, MemOp mop)
+static void maybe_nanbox_load(TCGv_i64 freg, MemOp mop)
 {
     if ((mop & MO_SIZE) == MO_32) {
         gen_nanbox_s(freg, freg);
@@ -13,7 +13,7 @@ static void maybe_nanbox_load(TCGv freg, MemOp mop)
 static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
@@ -23,7 +23,7 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
         addr = temp;
     }
 
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -33,7 +33,7 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv src = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
@@ -43,7 +43,7 @@ static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
         addr = temp;
     }
 
-    tcg_gen_qemu_st_tl(src, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -52,14 +52,14 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     addr = tcg_temp_new();
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -70,14 +70,14 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     addr = tcg_temp_new();
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -86,7 +86,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
@@ -94,7 +94,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -105,7 +105,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
@@ -113,7 +113,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -122,7 +122,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
@@ -130,7 +130,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -141,7 +141,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
@@ -149,7 +149,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
     tcg_gen_add_tl(addr, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index 5af0dd1b66..46b2af4b0c 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -9,27 +9,27 @@ static const uint32_t fcsr_mask[4] = {
 
 static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
 {
-    TCGv zero = tcg_constant_tl(0);
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
-    TCGv cond;
+    TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 cond;
 
     CHECK_FPE;
 
-    cond = tcg_temp_new();
-    tcg_gen_ld8u_tl(cond, cpu_env, offsetof(CPULoongArchState, cf[a->ca]));
-    tcg_gen_movcond_tl(TCG_COND_EQ, dest, cond, zero, src1, src2);
+    cond = tcg_temp_new_i64();
+    tcg_gen_ld8u_i64(cond, cpu_env, offsetof(CPULoongArchState, cf[a->ca]));
+    tcg_gen_movcond_i64(TCG_COND_EQ, dest, cond, zero, src1, src2);
     set_fpr(a->fd, dest);
 
     return true;
 }
 
 static bool gen_f2f(DisasContext *ctx, arg_ff *a,
-                    void (*func)(TCGv, TCGv), bool nanbox)
+                    void (*func)(TCGv_i64, TCGv_i64), bool nanbox)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -43,10 +43,10 @@ static bool gen_f2f(DisasContext *ctx, arg_ff *a,
 }
 
 static bool gen_r2f(DisasContext *ctx, arg_fr *a,
-                    void (*func)(TCGv, TCGv))
+                    void (*func)(TCGv_i64, TCGv))
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
@@ -57,10 +57,10 @@ static bool gen_r2f(DisasContext *ctx, arg_fr *a,
 }
 
 static bool gen_f2r(DisasContext *ctx, arg_rf *a,
-                    void (*func)(TCGv, TCGv))
+                    void (*func)(TCGv, TCGv_i64))
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -78,13 +78,17 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
     CHECK_FPE;
 
     if (mask == UINT32_MAX) {
-        tcg_gen_st32_i64(Rj, cpu_env, offsetof(CPULoongArchState, fcsr0));
+        tcg_gen_st32_tl(Rj, cpu_env, offsetof(CPULoongArchState, fcsr0));
     } else {
         TCGv_i32 fcsr0 = tcg_temp_new_i32();
         TCGv_i32 temp = tcg_temp_new_i32();
 
         tcg_gen_ld_i32(fcsr0, cpu_env, offsetof(CPULoongArchState, fcsr0));
+#ifdef TARGET_LOONGARCH32
+        tcg_gen_mov_i32(temp, Rj);
+#else
         tcg_gen_extrl_i64_i32(temp, Rj);
+#endif
         tcg_gen_andi_i32(temp, temp, mask);
         tcg_gen_andi_i32(fcsr0, fcsr0, ~mask);
         tcg_gen_or_i32(fcsr0, fcsr0, temp);
@@ -107,49 +111,65 @@ static bool trans_movfcsr2gr(DisasContext *ctx, arg_movfcsr2gr *a)
 
     CHECK_FPE;
 
-    tcg_gen_ld32u_i64(dest, cpu_env, offsetof(CPULoongArchState, fcsr0));
-    tcg_gen_andi_i64(dest, dest, fcsr_mask[a->fcsrs]);
+    tcg_gen_ld32u_tl(dest, cpu_env, offsetof(CPULoongArchState, fcsr0));
+    tcg_gen_andi_tl(dest, dest, fcsr_mask[a->fcsrs]);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
     return true;
 }
 
-static void gen_movgr2fr_w(TCGv dest, TCGv src)
+static void gen_movgr2fr_w(TCGv_i64 dest, TCGv src)
 {
+#ifdef TARGET_LOONGARCH32
+    TCGv_i64 src_i64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(src_i64, src);
+    tcg_gen_deposit_i64(dest, dest, src_i64, 0, 32);
+#else
     tcg_gen_deposit_i64(dest, dest, src, 0, 32);
+#endif
 }
 
-static void gen_movgr2frh_w(TCGv dest, TCGv src)
+static void gen_movgr2frh_w(TCGv_i64 dest, TCGv src)
 {
+#ifdef TARGET_LOONGARCH32
+    TCGv_i64 src_i64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(src_i64, src);
+    tcg_gen_deposit_i64(dest, dest, src_i64, 32, 32);
+#else
     tcg_gen_deposit_i64(dest, dest, src, 32, 32);
+#endif
 }
 
-static void gen_movfrh2gr_s(TCGv dest, TCGv src)
+static void gen_movfrh2gr_s(TCGv dest, TCGv_i64 src)
 {
+#ifdef TARGET_LOONGARCH32
+    tcg_gen_extrh_i64_i32(dest, src);
+#else
     tcg_gen_sextract_tl(dest, src, 32, 32);
+#endif
 }
 
 static bool trans_movfr2cf(DisasContext *ctx, arg_movfr2cf *a)
 {
-    TCGv t0;
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 t0;
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
-    t0 = tcg_temp_new();
-    tcg_gen_andi_tl(t0, src, 0x1);
-    tcg_gen_st8_tl(t0, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7]));
+    t0 = tcg_temp_new_i64();
+    tcg_gen_andi_i64(t0, src, 0x1);
+    tcg_gen_st8_i64(t0, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7]));
 
     return true;
 }
 
 static bool trans_movcf2fr(DisasContext *ctx, arg_movcf2fr *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
-    tcg_gen_ld8u_tl(dest, cpu_env,
+    tcg_gen_ld8u_i64(dest, cpu_env,
                     offsetof(CPULoongArchState, cf[a->cj & 0x7]));
     set_fpr(a->fd, dest);
 
@@ -178,11 +198,15 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
     return true;
 }
 
-TRANS(fmov_s, gen_f2f, tcg_gen_mov_tl, true)
-TRANS(fmov_d, gen_f2f, tcg_gen_mov_tl, false)
+TRANS(fmov_s, gen_f2f, tcg_gen_mov_i64, true)
+TRANS(fmov_d, gen_f2f, tcg_gen_mov_i64, false)
 TRANS(movgr2fr_w, gen_r2f, gen_movgr2fr_w)
-TRANS(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
+TRANS_64(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
 TRANS(movgr2frh_w, gen_r2f, gen_movgr2frh_w)
+#ifdef TARGET_LOONGARCH32
+TRANS(movfr2gr_s, gen_f2r, tcg_gen_extrl_i64_i32)
+#else
 TRANS(movfr2gr_s, gen_f2r, tcg_gen_ext32s_tl)
-TRANS(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
+#endif
+TRANS_64(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
 TRANS(movfrh2gr_s, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..25f72460c8 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3930,23 +3930,23 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
 }
 
 #define VSET(NAME, COND)                                                       \
-static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
-{                                                                              \
-    TCGv_i64 t1, al, ah;                                                       \
-                                                                               \
-    al = tcg_temp_new_i64();                                                   \
-    ah = tcg_temp_new_i64();                                                   \
-    t1 = tcg_temp_new_i64();                                                   \
-                                                                               \
-    get_vreg64(ah, a->vj, 1);                                                  \
-    get_vreg64(al, a->vj, 0);                                                  \
-                                                                               \
-    CHECK_SXE;                                                                 \
-    tcg_gen_or_i64(t1, al, ah);                                                \
-    tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
-    tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
-                                                                               \
-    return true;                                                               \
+static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                        \
+{                                                                               \
+    TCGv_i64 t1, al, ah;                                                        \
+                                                                                \
+    al = tcg_temp_new_i64();                                                    \
+    ah = tcg_temp_new_i64();                                                    \
+    t1 = tcg_temp_new_i64();                                                    \
+                                                                                \
+    get_vreg64(ah, a->vj, 1);                                                   \
+    get_vreg64(al, a->vj, 0);                                                   \
+                                                                                \
+    CHECK_SXE;                                                                  \
+    tcg_gen_or_i64(t1, al, ah);                                                 \
+    tcg_gen_setcondi_i64(COND, t1, t1, 0);                                      \
+    tcg_gen_st8_i64(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
+                                                                                \
+    return true;                                                                \
 }
 
 VSET(vseteqz_v, TCG_COND_EQ)
@@ -3965,7 +3965,7 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st8_i64(src, cpu_env,
+    tcg_gen_st8_tl(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
 }
@@ -3974,7 +3974,7 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st16_i64(src, cpu_env,
+    tcg_gen_st16_tl(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
 }
@@ -3983,7 +3983,7 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st32_i64(src, cpu_env,
+    tcg_gen_st32_tl(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
 }
@@ -3992,7 +3992,7 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st_i64(src, cpu_env,
+    tcg_gen_st_tl(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
 }
@@ -4001,7 +4001,7 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld8s_i64(dst, cpu_env,
+    tcg_gen_ld8s_tl(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
 }
@@ -4010,7 +4010,7 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld16s_i64(dst, cpu_env,
+    tcg_gen_ld16s_tl(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
 }
@@ -4019,7 +4019,7 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld32s_i64(dst, cpu_env,
+    tcg_gen_ld32s_tl(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
 }
@@ -4028,7 +4028,7 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld_i64(dst, cpu_env,
+    tcg_gen_ld_tl(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
 }
@@ -4037,7 +4037,7 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld8u_i64(dst, cpu_env,
+    tcg_gen_ld8u_tl(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
 }
@@ -4046,7 +4046,7 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld16u_i64(dst, cpu_env,
+    tcg_gen_ld16u_tl(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
 }
@@ -4055,7 +4055,7 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld32u_i64(dst, cpu_env,
+    tcg_gen_ld32u_tl(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
 }
@@ -4064,7 +4064,7 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld_i64(dst, cpu_env,
+    tcg_gen_ld_tl(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
 }
@@ -4074,7 +4074,7 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
 
-    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
+    tcg_gen_gvec_dup_tl(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
     return true;
 }
@@ -4131,7 +4131,8 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
 
     CHECK_SXE;
 
-    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
+    tcg_gen_extu_tl_i64(t0, gpr_src(ctx, a->rk, EXT_NONE));
+    tcg_gen_andi_i64(t0, t0, (LSX_LEN / bit) - 1);
     tcg_gen_shli_i64(t0, t0, vece);
     if (HOST_BIG_ENDIAN) {
         tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN/bit) -1));
diff --git a/target/loongarch/iocsr_helper.c b/target/loongarch/iocsr_helper.c
index dda9845d6c..32cf3204b2 100644
--- a/target/loongarch/iocsr_helper.c
+++ b/target/loongarch/iocsr_helper.c
@@ -16,25 +16,25 @@
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
 
-uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldub(&env->address_space_iocsr, r_addr,
                               GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_lduw(&env->address_space_iocsr, r_addr,
                               GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldl(&env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldq(&env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index d8ac99c9a4..31b9635bc4 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -99,61 +99,61 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
 
         /* Remaining CSRs */
-        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
-        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
+        VMSTATE_UINTTL(env.CSR_CRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_EUEN, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MISC, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ECFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ESTAT, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_BADV, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_BADI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_EENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBIDX, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBEHI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBELO0, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBELO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ASID, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGDL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGDH, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PWCL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PWCH, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_STLBPS, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_RVACFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG3, LoongArchCPU),
+        VMSTATE_UINTTL_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
+        VMSTATE_UINTTL(env.CSR_TID, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TCFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TVAL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_CNTC, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TICLR, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_LLBCTL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_IMPCTL1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_IMPCTL2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRBADV, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRELO0, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRELO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBREHI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRPRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRCTL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRINFO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRINFO2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_CTAG, LoongArchCPU),
+        VMSTATE_UINTTL_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
 
         /* Debug CSRs */
-        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DBG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DSAVE, LoongArchCPU),
         /* TLB */
         VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
                              0, vmstate_tlb, LoongArchTLB),
diff --git a/target/loongarch/op_helper.c b/target/loongarch/op_helper.c
index 60335a05e2..61dbddc501 100644
--- a/target/loongarch/op_helper.c
+++ b/target/loongarch/op_helper.c
@@ -62,7 +62,7 @@ void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
     }
 }
 
-target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong helper_crc32(target_ulong val, target_ulong m, target_ulong sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
@@ -72,7 +72,7 @@ target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
     return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
 }
 
-target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong helper_crc32c(target_ulong val, target_ulong m, target_ulong sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
@@ -86,7 +86,7 @@ target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
     return rj >= ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
 }
 
-uint64_t helper_rdtime_d(CPULoongArchState *env)
+target_ulong helper_rdtime_d(CPULoongArchState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return cpu_get_host_ticks();
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index 6e00190547..8c13e80fd3 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -166,6 +166,17 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
+static target_ulong dmw_va2pa(target_ulong va, target_ulong dmw)
+{
+#ifdef TARGET_LOONGARCH32
+    uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
+    return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
+        (pseg << R_CSR_DMW_32_VSEG_SHIFT);
+#else
+    return va & TARGET_PHYS_MASK;
+#endif
+}
+
 static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -185,12 +196,20 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
+#ifdef TARGET_LOONGARCH32
+    base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
+#else
+    base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+#endif
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
-        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
+#ifdef TARGET_LOONGARCH32
+        base_c = FIELD_EX32(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+#else
+        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+#endif
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(address);
+            *physical = dmw_va2pa(address, env->CSR_DMW[i]);
             *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             return TLBRET_MATCH;
         }
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..3557963df7 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -191,15 +191,15 @@ static void gen_set_gpr(int reg_num, TCGv t, DisasExtend dst_ext)
     }
 }
 
-static TCGv get_fpr(DisasContext *ctx, int reg_num)
+static TCGv_i64 get_fpr(DisasContext *ctx, int reg_num)
 {
-    TCGv t = tcg_temp_new();
+    TCGv_i64 t = tcg_temp_new_i64();
     tcg_gen_ld_i64(t, cpu_env,
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
     return  t;
 }
 
-static void set_fpr(int reg_num, TCGv val)
+static void set_fpr(int reg_num, TCGv_i64 val)
 {
     tcg_gen_st_i64(val, cpu_env,
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 7f60090580..4e45e3e434 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -14,6 +14,15 @@
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     { return FUNC(ctx, a, __VA_ARGS__); }
 
+/* for LoongArch64-only instructions */
+#ifdef TARGET_LOONGARCH64
+#define TRANS_64(NAME, FUNC, ...) TRANS(NAME, FUNC, __VA_ARGS__)
+#else
+#define TRANS_64(NAME, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+    { return false; }
+#endif
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
-- 
2.39.2


