Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5C7367F5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXom-00073F-IM; Tue, 20 Jun 2023 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXoh-00071X-3R
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXod-0006Hn-ED
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxSuqJc5FkiiUHAA--.14505S3;
 Tue, 20 Jun 2023 17:38:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S7; 
 Tue, 20 Jun 2023 17:38:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 05/46] target/loongarch: Implement xvreplgr2vr
Date: Tue, 20 Jun 2023 17:37:33 +0800
Message-Id: <20230620093814.123650-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S7
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
- XVREPLGR2VR.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 10 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 16 ++++++++++++++++
 target/loongarch/insns.decode                |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 696f78c491..78e1fd19ac 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_xxx(DisasContext *ctx, arg_xxx * a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, x%d", a->xd, a->xj, a->xk);
 }
 
+static void output_xr(DisasContext *ctx, arg_xr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d", a->xd, a->rj);
+}
+
 INSN_LASX(xvadd_b,           xxx)
 INSN_LASX(xvadd_h,           xxx)
 INSN_LASX(xvadd_w,           xxx)
@@ -1718,3 +1723,8 @@ INSN_LASX(xvsub_h,           xxx)
 INSN_LASX(xvsub_w,           xxx)
 INSN_LASX(xvsub_d,           xxx)
 INSN_LASX(xvsub_q,           xxx)
+
+INSN_LASX(xvreplgr2vr_b,     xr)
+INSN_LASX(xvreplgr2vr_h,     xr)
+INSN_LASX(xvreplgr2vr_w,     xr)
+INSN_LASX(xvreplgr2vr_d,     xr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index c918522f96..d394a4f40a 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -73,3 +73,19 @@ TRANS(xvsub_b, gvec_xxx, MO_8, tcg_gen_gvec_sub)
 TRANS(xvsub_h, gvec_xxx, MO_16, tcg_gen_gvec_sub)
 TRANS(xvsub_w, gvec_xxx, MO_32, tcg_gen_gvec_sub)
 TRANS(xvsub_d, gvec_xxx, MO_64, tcg_gen_gvec_sub)
+
+static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
+{
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    CHECK_ASXE;
+
+    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->xd),
+                         32, ctx->vl / 8, src);
+    return true;
+}
+
+TRANS(xvreplgr2vr_b, gvec_dupx, MO_8)
+TRANS(xvreplgr2vr_h, gvec_dupx, MO_16)
+TRANS(xvreplgr2vr_w, gvec_dupx, MO_32)
+TRANS(xvreplgr2vr_d, gvec_dupx, MO_64)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index bac1903975..2eab7f6a98 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1302,12 +1302,15 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 #
 
 &xxx          xd xj xk
+&xr           xd rj
+
 
 #
 # LASX Formats
 #
 
 @xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
+@xr                .... ........ ..... ..... rj:5 xd:5    &xr
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1319,3 +1322,8 @@ xvsub_h          0111 01000000 11001 ..... ..... .....    @xxx
 xvsub_w          0111 01000000 11010 ..... ..... .....    @xxx
 xvsub_d          0111 01000000 11011 ..... ..... .....    @xxx
 xvsub_q          0111 01010010 11011 ..... ..... .....    @xxx
+
+xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
+xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
+xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
+xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @xr
-- 
2.39.1


