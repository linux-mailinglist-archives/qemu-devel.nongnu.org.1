Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B48AD6A3E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 10:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPd7P-0005ek-RY; Thu, 12 Jun 2025 04:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uPd7K-0005eF-TT
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:16:59 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uPd7H-0002s6-MX
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:16:58 -0400
DKIM-Signature: a=rsa-sha256; bh=rC2vSdq/4mMq1xcaJlmF2VzzMJZWww6yL5HMDpiCA4M=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1749716209; v=1;
 b=W8W3YyNiJFpXv/WsojlWhaWHWl5P1I1nC3oLifErBDron3B4Lq9AUHNgXPn9LxHRoqUkG58A
 X8oFSzhOHFVQSIiVuhdjrxInpJdw9KN7cixzYzXu8h2lnEM+DaiRFyE1hkXEkABwM2QaplSZIW0
 CKMQySL9eGrF9ZvcBFzJSE5AkcDHUy6jRvLs+5RNPpHUtS7pKamovHWNmYKdHARAMiXQ8IRFyRP
 AffBNYFEmcaLZHiNYGTdStVp5NKBn+3yfOkRLZ1gsnztXlJ6j6JaK40+LRNmtEszlswON9uZt5K
 3Czo2YKtOUErVnQOAnGRTawjnFZBlJV19EQ/PQdyLpAMQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 6BDDB220AE;
 Thu, 12 Jun 2025 08:16:49 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Tue, 08 Oct 2024 11:17:43 +0800
Subject: [PATCH qemu v8 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
Message-ID: <174971620915.19456.15836954551382475540-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <174971620915.19456.15836954551382475540-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: lxx <1733205434@qq.com>

This patch adds support for the Zilsd and Zclsd extension,
which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v1.0

Signed-off-by: LIU Xu <liuxu@nucleisys.com>
Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg_fields.h.inc         |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  30 ++++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 758f254c15..778816901a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -144,6 +145,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
+    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
     ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
     ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
@@ -1289,6 +1291,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
=20
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
=20
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
@@ -1328,6 +1331,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
     MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
+    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
=20
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.=
h.inc
index 33c4f9bac8..9833d592bd 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -19,6 +19,7 @@ BOOL_FIELD(ext_zce)
 BOOL_FIELD(ext_zcf)
 BOOL_FIELD(ext_zcmp)
 BOOL_FIELD(ext_zcmt)
+BOOL_FIELD(ext_zclsd)
 BOOL_FIELD(ext_zk)
 BOOL_FIELD(ext_zkn)
 BOOL_FIELD(ext_zknd)
@@ -41,6 +42,7 @@ BOOL_FIELD(ext_zicond)
 BOOL_FIELD(ext_zihintntl)
 BOOL_FIELD(ext_zihintpause)
 BOOL_FIELD(ext_zihpm)
+BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index bf893d1c2e..c34020e4dc 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
 {
   ld              011  ... ... .. ... 00 @cl_d
   c_flw           011  ... ... .. ... 00 @cl_w
+  # *** Zclsd Extension ***
+  zclsd_ld        011  ... ... .. ... 00 @cl_d
 }
 {
   sd              111  ... ... .. ... 00 @cs_d
   c_fsw           111  ... ... .. ... 00 @cs_w
+  # *** Zclsd Extension ***
+  zclsd_sd        111  ... ... .. ... 00 @cs_d
 }
=20
 # *** RV32/64C Standard Extension (Quadrant 1) ***
@@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp
   c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
   ld              011 .  .....  ..... 10 @c_ldsp
   c_flw           011 .  .....  ..... 10 @c_lwsp
+  # *** Zclsd Extension ***
+  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
 }
 {
   sd              111 .  .....  ..... 10 @c_sdsp
   c_fsw           111 .  .....  ..... 10 @c_swsp
+  # *** Zclsd Extension ***
+  zclsd_sd        111 .  .....  ..... 10 @c_sdsp
 }
=20
 # *** RV64 and RV32 Zcb Extension ***
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..b341832e41 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 @csr
=20
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
-ld       ............   ..... 011 ..... 0000011 @i
-sd       ....... .....  ..... 011 ..... 0100011 @s
+{
+  ld       ............   ..... 011 ..... 0000011 @i
+  # *** Zilsd instructions ***
+  zilsd_ld ............   ..... 011 ..... 0000011 @i
+}
+{
+  sd       ....... .....  ..... 011 ..... 0100011 @s
+  # *** Zilsd instructions ***
+  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
+}
 addiw    ............   ..... 000 ..... 0011011 @i
 slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
 srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_tr=
ans/trans_zilsd.c.inc
new file mode 100644
index 0000000000..7bdc303298
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -0,0 +1,112 @@
+/*
+ * RISC-V translation routines for the Zilsd & Zclsd Extension.
+ *
+ * Copyright (c) 2025 Nucleisys, Inc.
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
+ * You should have received a copy of the GNU General Public License along w=
ith
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZILSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zilsd)  \
+        return false;              \
+} while (0)
+
+#define REQUIRE_ZCLSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zclsd)  \
+        return false;              \
+} while (0)
+
+static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
+{
+    if ((a->rd) % 2) {
+        return false;
+    }
+
+    TCGv dest_low =3D dest_gpr(ctx, a->rd);
+    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+
+    if (a->rd =3D=3D 0) {
+        return true;
+    }
+
+    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
+
+    gen_set_gpr(ctx, a->rd, dest_low);
+    gen_set_gpr(ctx, a->rd + 1, dest_high);
+
+    return true;
+}
+
+static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZILSD(ctx);
+    return gen_load_i64(ctx, a);
+}
+
+static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+    return gen_load_i64(ctx, a);
+}
+
+static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+
+    if (a->rd =3D=3D 0) {
+        return false;
+    }
+    return gen_load_i64(ctx, a);
+}
+
+static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
+{
+    if ((a->rs2) % 2) {
+        return false;
+    }
+
+    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+
+    if (a->rs2 =3D=3D 0) {
+        tmp =3D tcg_constant_i64(0);
+    } else {
+        tcg_gen_concat_tl_i64(tmp, data_low, data_high);
+    }
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+
+    return true;
+}
+
+static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZILSD(ctx);
+    return gen_store_i64(ctx, a);
+}
+
+static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_ZCLSD(ctx);
+    return gen_store_i64(ctx, a);
+}
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 163e7ce364..0944426b38 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -818,6 +818,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Er=
ror **errp)
         cpu->pmu_avail_ctrs =3D 0;
     }
=20
+    if (cpu->cfg.ext_zclsd) {
+        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
+            error_setg(errp,
+                    "Zclsd cannot be supported together with C and F extensi=
on");
+            return;
+        }
+        if (cpu->cfg.ext_zcf) {
+            error_setg(errp,
+                    "Zclsd cannot be supported together with Zcf extension");
+            return;
+        }
+    }
+
     if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
         error_setg(errp, "zicfilp extension requires zicsr extension");
         return;
@@ -1075,6 +1088,20 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     }
 }
=20
+static void cpu_enable_zilsd_implied_rules(RISCVCPU *cpu)
+{
+    CPURISCVState *env =3D &cpu->env;
+
+    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
+    }
+
+    if (cpu->cfg.ext_zclsd) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
+    }
+}
+
 static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
 {
     RISCVCPUImpliedExtsRule *rule;
@@ -1083,6 +1110,9 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cp=
u)
     /* Enable the implied extensions for Zc. */
     cpu_enable_zc_implied_rules(cpu);
=20
+    /* Enable the implied extensions for Zilsd. */
+    cpu_enable_zilsd_implied_rules(cpu);
+
     /* Enable the implied MISAs. */
     for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
         if (riscv_has_ext(&cpu->env, rule->ext)) {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..62f714034f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1200,6 +1200,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, tar=
get_ulong pc)
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_zilsd.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
 #include "insn_trans/trans_rvzicfiss.c.inc"
=20
--=20
2.45.3

