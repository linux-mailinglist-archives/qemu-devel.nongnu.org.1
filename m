Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AC7D3ADD
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwtn-000130-TQ; Mon, 23 Oct 2023 11:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwte-00010W-Tw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:17 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtc-0002LK-Dl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:14 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id BE23844522;
 Mon, 23 Oct 2023 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698075071; bh=7CWG1+U1RIQLA7zIpzmakebwddv6Te65FrvXrsXLy2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AzzaynHw3Ds9TgZrkQa7PvuWsx/TarveoJkAyqEA4se5Qb+Is2jfUae84UtrL1Ldb
 AQYvOIxBevIyE8AVOKg5fGxRXnmp2i2VrRfJDxnK+EwzeSt1wfmpLh2LU+N3Lyq4mU
 ajdcKAUWMtgeJe9wfLmIyGbOwuP82e0pIm9X0uZU=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH 4/5] target/loongarch: Add estimated reciprocal instructions
Date: Mon, 23 Oct 2023 23:29:21 +0800
Message-ID: <20231023153029.269211-6-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023153029.269211-2-c@jia.je>
References: <20231023153029.269211-2-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add the following new instructions in LoongArch v1.1:

- frecipe.s
- frecipe.d
- frsqrte.s
- frsqrte.d
- vfrecipe.s
- vfrecipe.d
- vfrsqrte.s
- vfrsqrte.d
- xvfrecipe.s
- xvfrecipe.d
- xvfrsqrte.s
- xvfrsqrte.d

They are guarded by CPUCFG2.FRECIPE. Altought the instructions allow
implementation to improve performance by reducing precision, we use the
existing softfloat implementation.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h                         |  1 +
 target/loongarch/disas.c                       | 12 ++++++++++++
 target/loongarch/insn_trans/trans_farith.c.inc |  4 ++++
 target/loongarch/insn_trans/trans_vec.c.inc    |  8 ++++++++
 target/loongarch/insns.decode                  | 12 ++++++++++++
 target/loongarch/translate.h                   |  6 ++++++
 6 files changed, 43 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 80a476c3f8..8f938effa8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -155,6 +155,7 @@ FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
+FIELD(CPUCFG2, FRECIPE, 25, 1)
 FIELD(CPUCFG2, LAM_BH, 27, 1)
 FIELD(CPUCFG2, LAMCAS, 28, 1)
 
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 4aa67749cf..9eb49fb5e3 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -473,6 +473,10 @@ INSN(frecip_s,     ff)
 INSN(frecip_d,     ff)
 INSN(frsqrt_s,     ff)
 INSN(frsqrt_d,     ff)
+INSN(frecipe_s,    ff)
+INSN(frecipe_d,    ff)
+INSN(frsqrte_s,    ff)
+INSN(frsqrte_d,    ff)
 INSN(fmov_s,       ff)
 INSN(fmov_d,       ff)
 INSN(movgr2fr_w,   fr)
@@ -1424,6 +1428,10 @@ INSN_LSX(vfrecip_s,        vv)
 INSN_LSX(vfrecip_d,        vv)
 INSN_LSX(vfrsqrt_s,        vv)
 INSN_LSX(vfrsqrt_d,        vv)
+INSN_LSX(vfrecipe_s,       vv)
+INSN_LSX(vfrecipe_d,       vv)
+INSN_LSX(vfrsqrte_s,       vv)
+INSN_LSX(vfrsqrte_d,       vv)
 
 INSN_LSX(vfcvtl_s_h,       vv)
 INSN_LSX(vfcvth_s_h,       vv)
@@ -2338,6 +2346,10 @@ INSN_LASX(xvfrecip_s,        vv)
 INSN_LASX(xvfrecip_d,        vv)
 INSN_LASX(xvfrsqrt_s,        vv)
 INSN_LASX(xvfrsqrt_d,        vv)
+INSN_LASX(xvfrecipe_s,       vv)
+INSN_LASX(xvfrecipe_d,       vv)
+INSN_LASX(xvfrsqrte_s,       vv)
+INSN_LASX(xvfrsqrte_d,       vv)
 
 INSN_LASX(xvfcvtl_s_h,       vv)
 INSN_LASX(xvfcvth_s_h,       vv)
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index f4a0dea727..356cdf99b7 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -191,6 +191,10 @@ TRANS(frecip_s, FP_SP, gen_ff, gen_helper_frecip_s)
 TRANS(frecip_d, FP_DP, gen_ff, gen_helper_frecip_d)
 TRANS(frsqrt_s, FP_SP, gen_ff, gen_helper_frsqrt_s)
 TRANS(frsqrt_d, FP_DP, gen_ff, gen_helper_frsqrt_d)
+TRANS(frecipe_s, FRECIPE_FP_SP, gen_ff, gen_helper_frecip_s)
+TRANS(frecipe_d, FRECIPE_FP_DP, gen_ff, gen_helper_frecip_d)
+TRANS(frsqrte_s, FRECIPE_FP_SP, gen_ff, gen_helper_frsqrt_s)
+TRANS(frsqrte_d, FRECIPE_FP_DP, gen_ff, gen_helper_frsqrt_d)
 TRANS(flogb_s, FP_SP, gen_ff, gen_helper_flogb_s)
 TRANS(flogb_d, FP_DP, gen_ff, gen_helper_flogb_d)
 TRANS(fclass_s, FP_SP, gen_ff, gen_helper_fclass_s)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 98f856bb29..1c93e19ac4 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4409,12 +4409,20 @@ TRANS(vfrecip_s, LSX, gen_vv_ptr, gen_helper_vfrecip_s)
 TRANS(vfrecip_d, LSX, gen_vv_ptr, gen_helper_vfrecip_d)
 TRANS(vfrsqrt_s, LSX, gen_vv_ptr, gen_helper_vfrsqrt_s)
 TRANS(vfrsqrt_d, LSX, gen_vv_ptr, gen_helper_vfrsqrt_d)
+TRANS(vfrecipe_s, FRECIPE_LSX, gen_vv_ptr, gen_helper_vfrecip_s)
+TRANS(vfrecipe_d, FRECIPE_LSX, gen_vv_ptr, gen_helper_vfrecip_d)
+TRANS(vfrsqrte_s, FRECIPE_LSX, gen_vv_ptr, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrte_d, FRECIPE_LSX, gen_vv_ptr, gen_helper_vfrsqrt_d)
 TRANS(xvfsqrt_s, LASX, gen_xx_ptr, gen_helper_vfsqrt_s)
 TRANS(xvfsqrt_d, LASX, gen_xx_ptr, gen_helper_vfsqrt_d)
 TRANS(xvfrecip_s, LASX, gen_xx_ptr, gen_helper_vfrecip_s)
 TRANS(xvfrecip_d, LASX, gen_xx_ptr, gen_helper_vfrecip_d)
 TRANS(xvfrsqrt_s, LASX, gen_xx_ptr, gen_helper_vfrsqrt_s)
 TRANS(xvfrsqrt_d, LASX, gen_xx_ptr, gen_helper_vfrsqrt_d)
+TRANS(xvfrecipe_s, FRECIPE_LASX, gen_xx_ptr, gen_helper_vfrecip_s)
+TRANS(xvfrecipe_d, FRECIPE_LASX, gen_xx_ptr, gen_helper_vfrecip_d)
+TRANS(xvfrsqrte_s, FRECIPE_LASX, gen_xx_ptr, gen_helper_vfrsqrt_s)
+TRANS(xvfrsqrte_d, FRECIPE_LASX, gen_xx_ptr, gen_helper_vfrsqrt_d)
 
 TRANS(vfcvtl_s_h, LSX, gen_vv_ptr, gen_helper_vfcvtl_s_h)
 TRANS(vfcvth_s_h, LSX, gen_vv_ptr, gen_helper_vfcvth_s_h)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index cf4123cd46..92078f0f9f 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -371,6 +371,10 @@ frecip_s        0000 00010001 01000 10101 ..... .....    @ff
 frecip_d        0000 00010001 01000 10110 ..... .....    @ff
 frsqrt_s        0000 00010001 01000 11001 ..... .....    @ff
 frsqrt_d        0000 00010001 01000 11010 ..... .....    @ff
+frecipe_s       0000 00010001 01000 11101 ..... .....    @ff
+frecipe_d       0000 00010001 01000 11110 ..... .....    @ff
+frsqrte_s       0000 00010001 01001 00001 ..... .....    @ff
+frsqrte_d       0000 00010001 01001 00010 ..... .....    @ff
 fscaleb_s       0000 00010001 00001 ..... ..... .....    @fff
 fscaleb_d       0000 00010001 00010 ..... ..... .....    @fff
 flogb_s         0000 00010001 01000 01001 ..... .....    @ff
@@ -1115,6 +1119,10 @@ vfrecip_s        0111 00101001 11001 11101 ..... .....    @vv
 vfrecip_d        0111 00101001 11001 11110 ..... .....    @vv
 vfrsqrt_s        0111 00101001 11010 00001 ..... .....    @vv
 vfrsqrt_d        0111 00101001 11010 00010 ..... .....    @vv
+vfrecipe_s       0111 00101001 11010 00101 ..... .....    @vv
+vfrecipe_d       0111 00101001 11010 00110 ..... .....    @vv
+vfrsqrte_s       0111 00101001 11010 01001 ..... .....    @vv
+vfrsqrte_d       0111 00101001 11010 01010 ..... .....    @vv
 
 vfcvtl_s_h       0111 00101001 11011 11010 ..... .....    @vv
 vfcvth_s_h       0111 00101001 11011 11011 ..... .....    @vv
@@ -1879,6 +1887,10 @@ xvfrecip_s       0111 01101001 11001 11101 ..... .....    @vv
 xvfrecip_d       0111 01101001 11001 11110 ..... .....    @vv
 xvfrsqrt_s       0111 01101001 11010 00001 ..... .....    @vv
 xvfrsqrt_d       0111 01101001 11010 00010 ..... .....    @vv
+xvfrecipe_s      0111 01101001 11010 00101 ..... .....    @vv
+xvfrecipe_d      0111 01101001 11010 00110 ..... .....    @vv
+xvfrsqrte_s      0111 01101001 11010 01001 ..... .....    @vv
+xvfrsqrte_d      0111 01101001 11010 01010 ..... .....    @vv
 
 xvfcvtl_s_h      0111 01101001 11011 11010 ..... .....    @vv
 xvfcvth_s_h      0111 01101001 11011 11011 ..... .....    @vv
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 3affefdafc..651c5796ca 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -28,6 +28,12 @@
 #define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
 #define avail_IOCSR(C)  (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
 
+#define avail_FRECIPE(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FRECIPE))
+#define avail_FRECIPE_FP_SP(C) (avail_FRECIPE(C) && avail_FP_SP(C))
+#define avail_FRECIPE_FP_DP(C) (avail_FRECIPE(C) && avail_FP_DP(C))
+#define avail_FRECIPE_LSX(C)   (avail_FRECIPE(C) && avail_LSX(C))
+#define avail_FRECIPE_LASX(C)   (avail_FRECIPE(C) && avail_LASX(C))
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
-- 
2.42.0


