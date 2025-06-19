Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B400CAE0807
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 15:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFkX-0004go-EC; Thu, 19 Jun 2025 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uSFkN-0004fc-Ay; Thu, 19 Jun 2025 09:56:07 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uSFkI-0004Ty-2R; Thu, 19 Jun 2025 09:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jutczu6K8Py3B8oNLBGk8xVbzF/SrvYto3P/Uulchhk=; b=uoZ41bkVgxREJAuFjDShFnfdoo
 AGKeD0h1RRDINz2iAa6dePpd12TnCsUygZBLUdduQgpcWDJ8zM570m9Jez6LmzTz7wIqeCfavkK6J
 6sDgGh0zuyg0p5YYzUTGIfNkzIN/eQSACQUk/Kw4Y5er9h7mXoiDFzzTy+lL4EUeNO+xhlsctcdy7
 Coj842piwkNrBEVu/EJ4zn8/ooQuzB2tvjhlf5ufQsLP3dut/o5mOgXpyj2bpdqMhs5xPkHRjGfjg
 g1QRKGOIIRTdwe0ZAQL2cvSbQLIu4H7T3vcjzdSm5ndNI1FpOWtBeVlOsaox68Aly8PQs6V2Rmfn7
 Gl1PxsgQ==;
Received: from [167.98.27.226] (helo=codethink.office.codethink.co.uk)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uSFk9-000TSv-Oo; Thu, 19 Jun 2025 14:55:55 +0100
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, alistair23@gmail.com,
 Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH v3] Add RISCV ZALASR extension
Date: Thu, 19 Jun 2025 14:55:31 +0100
Message-ID: <20250619135545.61956-1-roan.richmond@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is based on version v0.8.3 of the ZALASR specification [1].
The specification is listed as in Frozen state [2].

[1]: https://github.com/riscv/riscv-zalasr/tree/v0.8.3
[2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+RISC-V+Specifications+Under+Active+Development

Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
---

Ping! resending this as no movement on previous send.

V3:
  - rebased patch onto master branch
  - added check for aq on Load Acquire, as pointed out by Alistair Francis
  - added check for rl on Store Release, as mentioned by Alistair Francis

 target/riscv/cpu.c                           |   1 +
 target/riscv/insn32.decode                   |  10 ++
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 120 +++++++++++++++++++
 target/riscv/translate.c                     |   1 +
 4 files changed, 132 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..b52bbf0936 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
+    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..c848c0c1c5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
 amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
 amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
+
+# *** Zalasr Standard Extension ***
+lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
+lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
+lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
+ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
+sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
+sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
+sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
+sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
new file mode 100644
index 0000000000..8761508de3
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -0,0 +1,120 @@
+/*
+ * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Release)
+ * Extension.
+ *
+ * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
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
+#define REQUIRE_ZALASR(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zalasr) { \
+        return false;                \
+    }                                \
+} while (0)
+
+static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
+{
+    decode_save_opc(ctx, 0);
+
+    TCGv addr = get_address(ctx, a->rs1, 0);
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGBar bar = (a->rl) ? TCG_BAR_STRL : 0;
+
+    /* Check that AQ is set, as this is mandatory */
+    if (!a->aq) {
+        return false;    
+    }
+
+    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+
+    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
+    gen_set_gpr(ctx, a->rd, dest);
+
+    /* Add a memory barrier implied by AQ (mandatory) and RL (optional) */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
+
+    return true;
+}
+
+static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZALASR(ctx);
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
+}
+
+static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
+{
+    decode_save_opc(ctx, 0);
+
+    TCGv addr = get_address(ctx, a->rs1, 0);
+    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGBar bar = (a->aq) ? TCG_BAR_LDAQ : 0;
+
+    /* Check that RL is set, as this is mandatory */
+    if (!a->rl) {
+        return false;    
+    }
+
+    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
+
+    /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
+
+    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+    return true;
+}
+
+static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
+}
+
+static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
+{
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_ZALASR(ctx);
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..4cd2d68e46 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1183,6 +1183,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzabha.c.inc"
+#include "insn_trans/trans_rvzalasr.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
-- 
2.43.0


