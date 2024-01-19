Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8316C832AE9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:04:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpTD-0002z4-Vw; Fri, 19 Jan 2024 09:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owl129@126.com>) id 1rQgx3-0000cS-HQ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 23:57:57 -0500
Received: from m16.mail.126.com ([220.197.31.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <owl129@126.com>) id 1rQgwz-0007PS-0J
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 23:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TjhDT
 4UHFmeijIXUxU99iOjtLtwZOPs1edx/bLXnLUg=; b=Bavp8C6ZjroVCkldXpgrb
 ZMpmRmF8f808OoIQYLGUsSSSdS+vsWsoY9QFvXYho1AR8omQ/iisEWGrnoQyxs8+
 RbnR+9h7d+/O5qKVUoQcCR+ttxZZbRVpORTQJOmvhJ8X8M1qH3mTlppR2N0gDXGe
 7Io+524uDoKQbAkrxL9EVI=
Received: from owl-server.corp.qihoo.net (unknown [218.30.116.113])
 by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3f4IIAapl_faxAQ--.14017S2;
 Fri, 19 Jan 2024 12:56:41 +0800 (CST)
From: owl129@126.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	owl <owl129@126.com>
Subject: [PATCH] This patch implements several Octeon +/II instructions.
Date: Fri, 19 Jan 2024 04:56:27 +0000
Message-Id: <20240119045626.9698-1-owl129@126.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f4IIAapl_faxAQ--.14017S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Kw1UCF48Gr1DZFWUJF18Zrb_yoWDKFW8pr
 10yF18uF48XF17Xr92y3WY9Fs8JF1xAayUK3sIya1rKF48JFs8XwnFqrWYyrW7WF9agr1a
 yFs8AFWDuFy5t3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi2-e7UUUUU=
X-Originating-IP: [218.30.116.113]
X-CM-SenderInfo: przoijaz6rjloofrz/1tbiEAFqV2VLZhGbpgABsJ
Received-SPF: pass client-ip=220.197.31.6; envelope-from=owl129@126.com;
 helo=m16.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jan 2024 09:03:38 -0500
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

From: owl <owl129@126.com>


Octeon+ 
- SAA 
- SAAD

Octeon2
- LAI
- LAID
- LAD
- LADD
- LAS
- LASD
- LAC
- LACD
- LAA
- LAAD
- LAW
- LAWD

- LWX
- LHX
- LDX
- LBUX
- LWUX
- LHUX
- LBX

Signed-off-by: owl <owl129@126.com>
---
 target/mips/tcg/octeon.decode      |  35 ++++
 target/mips/tcg/octeon_translate.c | 281 +++++++++++++++++++++++++++++
 2 files changed, 316 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 0c787cb498..980ed619d0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -39,3 +39,38 @@ CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+
+
+# SAA rt, (base)
+# SAAD rt, (base)
+SAA         011100 base:5 rt:5 00000 00000 011000
+SAAD        011100 base:5 rt:5 00000 00000 011001
+
+LAI         011100 ..... ..... ..... 00010 011111 @r3
+LAID        011100 ..... ..... ..... 00011 011111 @r3
+LAD         011100 ..... ..... ..... 00110 011111 @r3
+LADD        011100 ..... ..... ..... 00111 011111 @r3
+LAS         011100 ..... ..... ..... 01010 011111 @r3
+LASD        011100 ..... ..... ..... 01011 011111 @r3
+LAC         011100 ..... ..... ..... 01110 011111 @r3
+LACD        011100 ..... ..... ..... 01111 011111 @r3
+LAA         011100 ..... ..... ..... 10010 011111 @r3
+LAAD        011100 ..... ..... ..... 10011 011111 @r3
+LAW         011100 ..... ..... ..... 10110 011111 @r3
+LAWD        011100 ..... ..... ..... 10111 011111 @r3
+
+
+# LWX
+# LHX
+# LDX
+# LBUX
+# LWUX
+# LHUX
+# LBX
+LWX         011111 ..... ..... ..... 00000 001010 @r3
+LHX         011111 ..... ..... ..... 00100 001010 @r3
+LDX         011111 ..... ..... ..... 01000 001010 @r3
+LBUX        011111 ..... ..... ..... 00110 001010 @r3
+LWUX        011111 ..... ..... ..... 10000 001010 @r3
+LHUX        011111 ..... ..... ..... 10100 001010 @r3
+LBX         011111 ..... ..... ..... 10110 001010 @r3
\ No newline at end of file
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa0..e9ec372ad3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -174,3 +174,284 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
     }
     return true;
 }
+
+/*
+ * Octeon+
+ *  https://sourceware.org/legacy-ml/binutils/2011-11/msg00085.html
+ */
+static bool trans_SAA(DisasContext *ctx, arg_SAA *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->base], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    tcg_gen_add_tl(t0, t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->base], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+static bool trans_SAAD(DisasContext *ctx, arg_SAAD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->base], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    tcg_gen_add_tl(t0, t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->base], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+/*
+ *  Octeon2
+ *   https://chromium.googlesource.com/chromiumos/third_party/gdb/+/refs/heads/master/opcodes/mips-opc.c
+ *   https://github.com/MarvellEmbeddedProcessors/Octeon-Toolchain
+ *   https://bugs.kde.org/show_bug.cgi?id=326444
+ *   https://gcc.gnu.org/legacy-ml/gcc-patches/2011-12/msg01134.html
+ */
+static bool trans_LAI(DisasContext *ctx, arg_LAI *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_addi_tl(t0, t0, 1);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+static bool trans_LAID(DisasContext *ctx, arg_LAID *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_addi_tl(t0, t0, 1);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+static bool trans_LAD(DisasContext *ctx, arg_LAD *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_subi_tl(t0, t0, 1);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+static bool trans_LADD(DisasContext *ctx, arg_LADD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_subi_tl(t0, t0, 1);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+/* Load Atomic Set Word - LAS; Cavium OCTEON2 */
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_movi_tl(t0, 0xffffffff);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+
+    return true;
+}
+/* Load Atomic Set Doubleword - LASD; Cavium OCTEON2 */
+static bool trans_LASD(DisasContext *ctx, arg_LASD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_movi_tl(t0, 0xffffffffffffffffULL);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+/* Load Atomic Clear Word - LAC; Cavium OCTEON2 */
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_movi_tl(t0, 0);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+/* Load Atomic Clear Doubleword - LACD; Cavium OCTEON2 */
+static bool trans_LACD(DisasContext *ctx, arg_LACD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_movi_tl(t0, 0xffffffffffffffffULL);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+/* Load Atomic Add Word - LAA; Cavium OCTEON2 */
+static bool trans_LAA(DisasContext *ctx, arg_LAA *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_add_tl(t0, t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+/* Load Atomic Add Doubleword - LAAD; Cavium OCTEON2 */
+static bool trans_LAAD(DisasContext *ctx, arg_LAAD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_add_tl(t0, t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+/* Load Atomic Swap Word - LAW; Cavium OCTEON2 */
+static bool trans_LAW(DisasContext *ctx, arg_LAW *a)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_mov_tl(t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+static bool trans_LAWD(DisasContext *ctx, arg_LAWD *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    gen_store_gpr(t0, a->rd);
+    tcg_gen_mov_tl(t0, cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_st_tl(t0, cpu_gpr[a->rs], ctx->mem_idx, MO_TEUQ |
+                           ctx->default_tcg_memop_mask);
+    return true;
+}
+
+
+static bool trans_LWX(DisasContext *ctx, arg_LWX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
+                           ctx->default_tcg_memop_mask);
+
+    /* on mips64, 32 extend to 64 */
+    tcg_gen_ext32s_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
+
+static bool trans_LHX(DisasContext *ctx, arg_LHX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+                           ctx->default_tcg_memop_mask);
+
+    /* 16 extend to 32/64 */
+    tcg_gen_ext16s_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
+
+static bool trans_LDX(DisasContext *ctx, arg_LDX *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESQ |
+                           ctx->default_tcg_memop_mask);
+    /* not extend */
+    gen_store_gpr(t0, a->rd);
+    return true;
+}
+
+static bool trans_LBUX(DisasContext *ctx, arg_LBUX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB |
+                           ctx->default_tcg_memop_mask);
+
+    tcg_gen_ext8u_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
+
+static bool trans_LWUX(DisasContext *ctx, arg_LWUX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL |
+                           ctx->default_tcg_memop_mask);
+
+    tcg_gen_ext32u_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
+
+static bool trans_LHUX(DisasContext *ctx, arg_LHUX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUW |
+                           ctx->default_tcg_memop_mask);
+
+    tcg_gen_ext16u_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
+
+static bool trans_LBX(DisasContext *ctx, arg_LBX *a)
+{
+    TCGv t0 = tcg_temp_new();
+    gen_op_addr_add(ctx, t0, cpu_gpr[a->rs], cpu_gpr[a->rt]);
+
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB |
+                           ctx->default_tcg_memop_mask);
+
+    tcg_gen_ext8s_tl(cpu_gpr[a->rd], t0);
+    return true;
+}
-- 
2.34.1


