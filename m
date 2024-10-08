Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DC993D9D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 05:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy166-0001hF-Py; Mon, 07 Oct 2024 23:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sy162-0001gx-IQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:41:14 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sy15z-00050x-Sk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:41:14 -0400
DKIM-Signature: a=rsa-sha256; bh=5hr4qYzSgUeSplDxlbNCiz+BvACI9c7lUoqDfAsswyg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1728358867; v=1;
 b=WLGSwh8/MGyEhgZPE3efqJdtZKLXoWRddaO1M0PInkH0pP88Drr40YmmpeozrbWs2EpDf7sY
 YCD4+jLzNfDwH/j0qDBwzzUljsvNB62a+XeC6PivEWxiTzOx+EjDqioOx+ai1KZuY4J3cMb7Z0Y
 XOF/kNs5Y3PnozDoxnQHw9IKPxmAgZyeeh/+xrAgrhvsugEFlveEpF6scyGzxh0U+Ayxiiqn4Q3
 yncn4800rr77lFTKlfMiQO/Qzusa/EqcZlh160K2mhu7Mej7LjOsgtriXmLM5VuAVQMogaXl1bo
 qVLSossSuvPD1bwOVLhyOdoQWwN9ZmHl/PaXGhKCAZi+Q==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id AE77E20063;
 Tue, 08 Oct 2024 03:41:07 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Tue, 08 Oct 2024 11:17:43 +0800
Subject: [PATCH qemu v6] target/riscv: Add Zilsd and Zclsd extension support
Message-ID: <172835886767.17327.15494840848441210001-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v0.10

Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
Co-developed-by: LIU Xu <liuxu@nucleisys.com>
Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
---
 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg.h                    |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  20 ++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36e3e5fdaf..be9746d361 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -132,6 +133,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
+    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
     ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
     ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
@@ -1492,6 +1494,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
=20
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
=20
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
@@ -1531,6 +1534,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
     MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
+    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
=20
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..76ae1e95d7 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -51,6 +51,7 @@ struct RISCVCPUConfig {
     bool ext_zcf;
     bool ext_zcmp;
     bool ext_zcmt;
+    bool ext_zclsd;
     bool ext_zk;
     bool ext_zkn;
     bool ext_zknd;
@@ -71,6 +72,7 @@ struct RISCVCPUConfig {
     bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_zihpm;
+    bool ext_zilsd;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..bcd94e41e1 100644
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
@@ -207,10 +211,14 @@ sw                110 .  .....  ..... 10 @c_swsp
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
index f22df04cfd..f6f4b7950b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -169,8 +169,16 @@ csrrci   ............     ..... 111 ..... 1110011 @csr
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
index 0000000000..1e3ab362de
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -0,0 +1,112 @@
+/*
+ * RISC-V translation routines for the Zilsd & Zclsd Extension.
+ *
+ * Copyright (c) 2024 Nucleisys, Inc.
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
index b5b95e052d..bb15e5737c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -721,6 +721,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Er=
ror **errp)
         cpu->pmu_avail_ctrs =3D 0;
     }
=20
+    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
+    }
+
+    if (cpu->cfg.ext_zclsd) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
+
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
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ff09ebdb6..be148ef3c6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1113,6 +1113,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, tar=
get_ulong pc)
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_zilsd.c.inc"
=20
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
--=20
2.45.2

