Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E9900ED4
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jun 2024 02:19:22 +0200 (CEST)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaum-0000bG-Hd; Fri, 07 Jun 2024 10:50:00 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sFauj-0000Qn-N7; Fri, 07 Jun 2024 10:49:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sFauh-0005Nt-DO; Fri, 07 Jun 2024 10:49:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 457EbZhc030765; Fri, 7 Jun 2024 14:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=baQz5cJFxt25WRbvCD0jwvliNbe8ySVc/q+YiHcKWK4=;
 b=c0ORFyHalHs5oeXzOvQzQLVvY8sMvTyL6OFcGTfxsS6TXZJoEjdrkwUZSno0+CMRTCqp
 XM13DBTujaau78lYvXidW+0JN5sSclvxXIURAMD6ehv0+6Me8G9sS/HWhjUhSZxQGmjg
 t3acAx1d7Q6wZus85sjZnV2B6CfDhafcvFONOqmOzEoXVjCjFpPY3fNx0cyPDY/uL/z0
 RZyCg9OlGjKdC5qhH38XXteun5mz5e8TR7xjerswSYIymrazpQTDni1+cF8+fpKl1sf9
 HvTlJvdf3x7KN7zlINm/Xg12rNARvAoMLH1n7v61TRfqKkEfUKHvYYSyls0XBlEnZ6B1 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym44k021f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457EnpQr024083;
 Fri, 7 Jun 2024 14:49:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym44k021c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 457CrqKV026600; Fri, 7 Jun 2024 14:49:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffnh201-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 457Enkkk50135524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jun 2024 14:49:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F3A72004B;
 Fri,  7 Jun 2024 14:49:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39F4420049;
 Fri,  7 Jun 2024 14:49:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.62.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jun 2024 14:49:43 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 3/4] target/ppc: Move VSX vector storage access insns to
 decodetree.
Date: Fri,  7 Jun 2024 20:19:20 +0530
Message-Id: <20240607144921.726730-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240607144921.726730-1-rathc@linux.ibm.com>
References: <20240607144921.726730-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T5h0AOJ4b-_Vxor86WQsggqHPEdsk3wY
X-Proofpoint-ORIG-GUID: 6_zNYY8JcFzRX9OXUZUR8g_g3EXYBAWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=872 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Moving the following instructions to decodetree specification:

  lxv{b16, d2, h8, w4, ds, ws}x   : X-form
  stxv{b16, d2, h8, w4}x          : X-form

The changes were verified by validating that the tcg-ops generated for those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            |  10 ++
 target/ppc/translate/vsx-impl.c.inc | 199 ++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  |  12 --
 3 files changed, 97 insertions(+), 124 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 445fdb341f..3d31ef52f8 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -805,9 +805,19 @@ STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
 STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
 STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
 
+LXVB16X         011111 ..... ..... ..... 1101101100 .   @X_TSX
+LXVD2X          011111 ..... ..... ..... 1101001100 .   @X_TSX
+LXVH8X          011111 ..... ..... ..... 1100101100 .   @X_TSX
+LXVW4X          011111 ..... ..... ..... 1100001100 .   @X_TSX
+LXVDSX          011111 ..... ..... ..... 0101001100 .   @X_TSX
+LXVWSX          011111 ..... ..... ..... 0101101100 .   @X_TSX
 LXVL            011111 ..... ..... ..... 0100001101 .   @X_TSX
 LXVLL           011111 ..... ..... ..... 0100101101 .   @X_TSX
 
+STXVB16X        011111 ..... ..... ..... 1111101100 .   @X_TSX
+STXVD2X         011111 ..... ..... ..... 1111001100 .   @X_TSX
+STXVH8X         011111 ..... ..... ..... 1110101100 .   @X_TSX
+STXVW4X         011111 ..... ..... ..... 1110001100 .   @X_TSX
 STXVL           011111 ..... ..... ..... 0110001101 .   @X_TSX
 STXVLL          011111 ..... ..... ..... 0110101101 .   @X_TSX
 
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 695b75ded9..739b5ad915 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -46,41 +46,37 @@ TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
 TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
 TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
 
-static void gen_lxvd2x(DisasContext *ctx)
+static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
 {
     TCGv EA;
     TCGv_i64 t0;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     gen_qemu_ld64_i64(ctx, t0, EA);
-    set_cpu_vsr(xT(ctx->opcode), t0, true);
+    set_cpu_vsr(a->rt, t0, true);
     tcg_gen_addi_tl(EA, EA, 8);
     gen_qemu_ld64_i64(ctx, t0, EA);
-    set_cpu_vsr(xT(ctx->opcode), t0, false);
+    set_cpu_vsr(a->rt, t0, false);
+    return true;
 }
 
-static void gen_lxvw4x(DisasContext *ctx)
+static bool trans_LXVW4X(DisasContext *ctx, arg_LXVW4X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
-
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
@@ -97,55 +93,45 @@ static void gen_lxvw4x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
     }
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
-static void gen_lxvwsx(DisasContext *ctx)
+static bool trans_LXVWSX(DisasContext *ctx, arg_LXVWSX *a)
 {
     TCGv EA;
     TCGv_i32 data;
 
-    if (xT(ctx->opcode) < 32) {
-        if (unlikely(!ctx->vsx_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VSXU);
-            return;
-        }
+    if (a->rt < 32) {
+        REQUIRE_VSX(ctx);
     } else {
-        if (unlikely(!ctx->altivec_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VPU);
-            return;
-        }
+        REQUIRE_VECTOR(ctx);
     }
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
-
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     data = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UL));
-    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(a->rt), 16, 16, data);
+    return true;
 }
 
-static void gen_lxvdsx(DisasContext *ctx)
+static bool trans_LXVDSX(DisasContext *ctx, arg_LXVDSX *a)
 {
     TCGv EA;
     TCGv_i64 data;
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
 
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-
-    gen_addr_reg_index(ctx, EA);
-
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     data = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(data, EA, ctx->mem_idx, DEF_MEMOP(MO_UQ));
-    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+    tcg_gen_gvec_dup_i64(MO_UQ, vsr_full_offset(a->rt), 16, 16, data);
+    return true;
 }
 
 static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
@@ -184,52 +170,47 @@ static void gen_bswap32x4(TCGv_i64 outh, TCGv_i64 outl,
     tcg_gen_deposit_i64(outl, outl, lo, 32, 32);
 }
 
-static void gen_lxvh8x(DisasContext *ctx)
+static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
     if (ctx->le_mode) {
         gen_bswap16x8(xth, xtl, xth, xtl);
     }
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
-static void gen_lxvb16x(DisasContext *ctx)
+static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xth;
-    TCGv_i64 xtl;
+    TCGv_i64 xth, xtl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
-    set_cpu_vsr(xT(ctx->opcode), xth, true);
-    set_cpu_vsr(xT(ctx->opcode), xtl, false);
+    set_cpu_vsr(a->rt, xth, true);
+    set_cpu_vsr(a->rt, xtl, false);
+    return true;
 }
 
 #if defined(TARGET_PPC64)
@@ -329,42 +310,39 @@ TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
 TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
 TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
 
-static void gen_stxvd2x(DisasContext *ctx)
+static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
 {
     TCGv EA;
     TCGv_i64 t0;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
+
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-    get_cpu_vsr(t0, xS(ctx->opcode), true);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    get_cpu_vsr(t0, a->rt, true);
     gen_qemu_st64_i64(ctx, t0, EA);
     tcg_gen_addi_tl(EA, EA, 8);
-    get_cpu_vsr(t0, xS(ctx->opcode), false);
+    get_cpu_vsr(t0, a->rt, false);
     gen_qemu_st64_i64(ctx, t0, EA);
+    return true;
 }
 
-static void gen_stxvw4x(DisasContext *ctx)
+static bool trans_STXVW4X(DisasContext *ctx, arg_STXVW4X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, VSX);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
@@ -381,25 +359,23 @@ static void gen_stxvw4x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
     }
+    return true;
 }
 
-static void gen_stxvh8x(DisasContext *ctx)
+static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     if (ctx->le_mode) {
         TCGv_i64 outh = tcg_temp_new_i64();
         TCGv_i64 outl = tcg_temp_new_i64();
@@ -413,28 +389,27 @@ static void gen_stxvh8x(DisasContext *ctx)
         tcg_gen_addi_tl(EA, EA, 8);
         tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
     }
+    return true;
 }
 
-static void gen_stxvb16x(DisasContext *ctx)
+static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh;
-    TCGv_i64 xsl;
+    TCGv_i64 xsh, xsl;
+
+    REQUIRE_VSX(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, xS(ctx->opcode), true);
-    get_cpu_vsr(xsl, xS(ctx->opcode), false);
+    get_cpu_vsr(xsh, a->rt, true);
+    get_cpu_vsr(xsl, a->rt, false);
     gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_qemu_st_i64(xsh, EA, ctx->mem_idx, MO_BEUQ);
     tcg_gen_addi_tl(EA, EA, 8);
     tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
+    return true;
 }
 
 static void gen_mfvsrwz(DisasContext *ctx)
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 7f4326c974..91cde088bc 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -1,15 +1,3 @@
-GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
-GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
-
-GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
-GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
-
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwz, 0x1F, 0x13, 0x07, 0x0000F800, PPC_NONE, PPC2_VSX207),
-- 
2.39.3


