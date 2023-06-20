Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B867736817
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpH-0007C8-3s; Tue, 20 Jun 2023 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp3-00079u-0d
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXox-0006N5-0j
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx_eqVc5FkviUHAA--.14882S3;
 Tue, 20 Jun 2023 17:38:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S27; 
 Tue, 20 Jun 2023 17:38:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 25/46] target/loongarch: Implement xvsll xvsrl xvsra xvrotr
Date: Tue, 20 Jun 2023 17:37:53 +0800
Message-Id: <20230620093814.123650-26-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S27
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch includes:
- XVSLL[I].{B/H/W/D};
- XVSRL[I].{B/H/W/D};
- XVSRA[I].{B/H/W/D};
- XVROTR[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 36 ++++++++++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 36 ++++++++++++++++++++
 target/loongarch/insns.decode                | 33 ++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2f1da9db80..0c1c7a7e6e 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2040,6 +2040,42 @@ INSN_LASX(xvori_b,           xx_i)
 INSN_LASX(xvxori_b,          xx_i)
 INSN_LASX(xvnori_b,          xx_i)
 
+INSN_LASX(xvsll_b,           xxx)
+INSN_LASX(xvsll_h,           xxx)
+INSN_LASX(xvsll_w,           xxx)
+INSN_LASX(xvsll_d,           xxx)
+INSN_LASX(xvslli_b,          xx_i)
+INSN_LASX(xvslli_h,          xx_i)
+INSN_LASX(xvslli_w,          xx_i)
+INSN_LASX(xvslli_d,          xx_i)
+
+INSN_LASX(xvsrl_b,           xxx)
+INSN_LASX(xvsrl_h,           xxx)
+INSN_LASX(xvsrl_w,           xxx)
+INSN_LASX(xvsrl_d,           xxx)
+INSN_LASX(xvsrli_b,          xx_i)
+INSN_LASX(xvsrli_h,          xx_i)
+INSN_LASX(xvsrli_w,          xx_i)
+INSN_LASX(xvsrli_d,          xx_i)
+
+INSN_LASX(xvsra_b,           xxx)
+INSN_LASX(xvsra_h,           xxx)
+INSN_LASX(xvsra_w,           xxx)
+INSN_LASX(xvsra_d,           xxx)
+INSN_LASX(xvsrai_b,          xx_i)
+INSN_LASX(xvsrai_h,          xx_i)
+INSN_LASX(xvsrai_w,          xx_i)
+INSN_LASX(xvsrai_d,          xx_i)
+
+INSN_LASX(xvrotr_b,          xxx)
+INSN_LASX(xvrotr_h,          xxx)
+INSN_LASX(xvrotr_w,          xxx)
+INSN_LASX(xvrotr_d,          xxx)
+INSN_LASX(xvrotri_b,         xx_i)
+INSN_LASX(xvrotri_h,         xx_i)
+INSN_LASX(xvrotri_w,         xx_i)
+INSN_LASX(xvrotri_d,         xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index d48f76f118..5d7deb312e 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1977,6 +1977,42 @@ static void do_xvnori_b(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
 
 TRANS(xvnori_b, gvec_xx_i, MO_8, do_xvnori_b)
 
+TRANS(xvsll_b, gvec_xxx, MO_8, tcg_gen_gvec_shlv)
+TRANS(xvsll_h, gvec_xxx, MO_16, tcg_gen_gvec_shlv)
+TRANS(xvsll_w, gvec_xxx, MO_32, tcg_gen_gvec_shlv)
+TRANS(xvsll_d, gvec_xxx, MO_64, tcg_gen_gvec_shlv)
+TRANS(xvslli_b, gvec_xx_i, MO_8, tcg_gen_gvec_shli)
+TRANS(xvslli_h, gvec_xx_i, MO_16, tcg_gen_gvec_shli)
+TRANS(xvslli_w, gvec_xx_i, MO_32, tcg_gen_gvec_shli)
+TRANS(xvslli_d, gvec_xx_i, MO_64, tcg_gen_gvec_shli)
+
+TRANS(xvsrl_b, gvec_xxx, MO_8, tcg_gen_gvec_shrv)
+TRANS(xvsrl_h, gvec_xxx, MO_16, tcg_gen_gvec_shrv)
+TRANS(xvsrl_w, gvec_xxx, MO_32, tcg_gen_gvec_shrv)
+TRANS(xvsrl_d, gvec_xxx, MO_64, tcg_gen_gvec_shrv)
+TRANS(xvsrli_b, gvec_xx_i, MO_8, tcg_gen_gvec_shri)
+TRANS(xvsrli_h, gvec_xx_i, MO_16, tcg_gen_gvec_shri)
+TRANS(xvsrli_w, gvec_xx_i, MO_32, tcg_gen_gvec_shri)
+TRANS(xvsrli_d, gvec_xx_i, MO_64, tcg_gen_gvec_shri)
+
+TRANS(xvsra_b, gvec_xxx, MO_8, tcg_gen_gvec_sarv)
+TRANS(xvsra_h, gvec_xxx, MO_16, tcg_gen_gvec_sarv)
+TRANS(xvsra_w, gvec_xxx, MO_32, tcg_gen_gvec_sarv)
+TRANS(xvsra_d, gvec_xxx, MO_64, tcg_gen_gvec_sarv)
+TRANS(xvsrai_b, gvec_xx_i, MO_8, tcg_gen_gvec_sari)
+TRANS(xvsrai_h, gvec_xx_i, MO_16, tcg_gen_gvec_sari)
+TRANS(xvsrai_w, gvec_xx_i, MO_32, tcg_gen_gvec_sari)
+TRANS(xvsrai_d, gvec_xx_i, MO_64, tcg_gen_gvec_sari)
+
+TRANS(xvrotr_b, gvec_xxx, MO_8, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_h, gvec_xxx, MO_16, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_w, gvec_xxx, MO_32, tcg_gen_gvec_rotrv)
+TRANS(xvrotr_d, gvec_xxx, MO_64, tcg_gen_gvec_rotrv)
+TRANS(xvrotri_b, gvec_xx_i, MO_8, tcg_gen_gvec_rotri)
+TRANS(xvrotri_h, gvec_xx_i, MO_16, tcg_gen_gvec_rotri)
+TRANS(xvrotri_w, gvec_xx_i, MO_32, tcg_gen_gvec_rotri)
+TRANS(xvrotri_d, gvec_xx_i, MO_64, tcg_gen_gvec_rotri)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ce2ad47b88..03c3aa0019 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1641,6 +1641,39 @@ xvori_b          0111 01111101 01 ........ ..... .....    @xx_ui8
 xvxori_b         0111 01111101 10 ........ ..... .....    @xx_ui8
 xvnori_b         0111 01111101 11 ........ ..... .....    @xx_ui8
 
+xvsll_b          0111 01001110 10000 ..... ..... .....    @xxx
+xvsll_h          0111 01001110 10001 ..... ..... .....    @xxx
+xvsll_w          0111 01001110 10010 ..... ..... .....    @xxx
+xvsll_d          0111 01001110 10011 ..... ..... .....    @xxx
+xvslli_b         0111 01110010 11000 01 ... ..... .....   @xx_ui3
+xvslli_h         0111 01110010 11000 1 .... ..... .....   @xx_ui4
+xvslli_w         0111 01110010 11001 ..... ..... .....    @xx_ui5
+xvslli_d         0111 01110010 1101 ...... ..... .....    @xx_ui6
+xvsrl_b          0111 01001110 10100 ..... ..... .....    @xxx
+xvsrl_h          0111 01001110 10101 ..... ..... .....    @xxx
+xvsrl_w          0111 01001110 10110 ..... ..... .....    @xxx
+xvsrl_d          0111 01001110 10111 ..... ..... .....    @xxx
+xvsrli_b         0111 01110011 00000 01 ... ..... .....   @xx_ui3
+xvsrli_h         0111 01110011 00000 1 .... ..... .....   @xx_ui4
+xvsrli_w         0111 01110011 00001 ..... ..... .....    @xx_ui5
+xvsrli_d         0111 01110011 0001 ...... ..... .....    @xx_ui6
+xvsra_b          0111 01001110 11000 ..... ..... .....    @xxx
+xvsra_h          0111 01001110 11001 ..... ..... .....    @xxx
+xvsra_w          0111 01001110 11010 ..... ..... .....    @xxx
+xvsra_d          0111 01001110 11011 ..... ..... .....    @xxx
+xvsrai_b         0111 01110011 01000 01 ... ..... .....   @xx_ui3
+xvsrai_h         0111 01110011 01000 1 .... ..... .....   @xx_ui4
+xvsrai_w         0111 01110011 01001 ..... ..... .....    @xx_ui5
+xvsrai_d         0111 01110011 0101 ...... ..... .....    @xx_ui6
+xvrotr_b         0111 01001110 11100 ..... ..... .....    @xxx
+xvrotr_h         0111 01001110 11101 ..... ..... .....    @xxx
+xvrotr_w         0111 01001110 11110 ..... ..... .....    @xxx
+xvrotr_d         0111 01001110 11111 ..... ..... .....    @xxx
+xvrotri_b        0111 01101010 00000 01 ... ..... .....   @xx_ui3
+xvrotri_h        0111 01101010 00000 1 .... ..... .....   @xx_ui4
+xvrotri_w        0111 01101010 00001 ..... ..... .....    @xx_ui5
+xvrotri_d        0111 01101010 0001 ...... ..... .....    @xx_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
-- 
2.39.1


