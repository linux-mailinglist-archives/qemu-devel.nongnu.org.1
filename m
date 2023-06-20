Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9B736812
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXom-00073N-No; Tue, 20 Jun 2023 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXoi-00072C-DK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXod-0006Ho-EF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxX+uKc5FkkCUHAA--.14745S3;
 Tue, 20 Jun 2023 17:38:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S10; 
 Tue, 20 Jun 2023 17:38:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 08/46] target/loongarch: Implement xvsadd/xvssub
Date: Tue, 20 Jun 2023 17:37:36 +0800
Message-Id: <20230620093814.123650-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S10
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
- XVSADD.{B/H/W/D}[U];
- XVSSUB.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 17 +++++++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++++++
 target/loongarch/insns.decode                | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index eefd16e3f1..2a2993cb95 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1748,6 +1748,23 @@ INSN_LASX(xvneg_h,           xx)
 INSN_LASX(xvneg_w,           xx)
 INSN_LASX(xvneg_d,           xx)
 
+INSN_LASX(xvsadd_b,          xxx)
+INSN_LASX(xvsadd_h,          xxx)
+INSN_LASX(xvsadd_w,          xxx)
+INSN_LASX(xvsadd_d,          xxx)
+INSN_LASX(xvsadd_bu,         xxx)
+INSN_LASX(xvsadd_hu,         xxx)
+INSN_LASX(xvsadd_wu,         xxx)
+INSN_LASX(xvsadd_du,         xxx)
+INSN_LASX(xvssub_b,          xxx)
+INSN_LASX(xvssub_h,          xxx)
+INSN_LASX(xvssub_w,          xxx)
+INSN_LASX(xvssub_d,          xxx)
+INSN_LASX(xvssub_bu,         xxx)
+INSN_LASX(xvssub_hu,         xxx)
+INSN_LASX(xvssub_wu,         xxx)
+INSN_LASX(xvssub_du,         xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cea944c3ba..ec68193686 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -131,6 +131,23 @@ TRANS(xvneg_h, gvec_xx, MO_16, tcg_gen_gvec_neg)
 TRANS(xvneg_w, gvec_xx, MO_32, tcg_gen_gvec_neg)
 TRANS(xvneg_d, gvec_xx, MO_64, tcg_gen_gvec_neg)
 
+TRANS(xvsadd_b, gvec_xxx, MO_8, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_h, gvec_xxx, MO_16, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_w, gvec_xxx, MO_32, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_d, gvec_xxx, MO_64, tcg_gen_gvec_ssadd)
+TRANS(xvsadd_bu, gvec_xxx, MO_8, tcg_gen_gvec_usadd)
+TRANS(xvsadd_hu, gvec_xxx, MO_16, tcg_gen_gvec_usadd)
+TRANS(xvsadd_wu, gvec_xxx, MO_32, tcg_gen_gvec_usadd)
+TRANS(xvsadd_du, gvec_xxx, MO_64, tcg_gen_gvec_usadd)
+TRANS(xvssub_b, gvec_xxx, MO_8, tcg_gen_gvec_sssub)
+TRANS(xvssub_h, gvec_xxx, MO_16, tcg_gen_gvec_sssub)
+TRANS(xvssub_w, gvec_xxx, MO_32, tcg_gen_gvec_sssub)
+TRANS(xvssub_d, gvec_xxx, MO_64, tcg_gen_gvec_sssub)
+TRANS(xvssub_bu, gvec_xxx, MO_8, tcg_gen_gvec_ussub)
+TRANS(xvssub_hu, gvec_xxx, MO_16, tcg_gen_gvec_ussub)
+TRANS(xvssub_wu, gvec_xxx, MO_32, tcg_gen_gvec_ussub)
+TRANS(xvssub_du, gvec_xxx, MO_64, tcg_gen_gvec_ussub)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 78452c622c..be706fe0f7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1340,6 +1340,24 @@ xvneg_h          0111 01101001 11000 01101 ..... .....    @xx
 xvneg_w          0111 01101001 11000 01110 ..... .....    @xx
 xvneg_d          0111 01101001 11000 01111 ..... .....    @xx
 
+xvsadd_b         0111 01000100 01100 ..... ..... .....    @xxx
+xvsadd_h         0111 01000100 01101 ..... ..... .....    @xxx
+xvsadd_w         0111 01000100 01110 ..... ..... .....    @xxx
+xvsadd_d         0111 01000100 01111 ..... ..... .....    @xxx
+xvsadd_bu        0111 01000100 10100 ..... ..... .....    @xxx
+xvsadd_hu        0111 01000100 10101 ..... ..... .....    @xxx
+xvsadd_wu        0111 01000100 10110 ..... ..... .....    @xxx
+xvsadd_du        0111 01000100 10111 ..... ..... .....    @xxx
+
+xvssub_b         0111 01000100 10000 ..... ..... .....    @xxx
+xvssub_h         0111 01000100 10001 ..... ..... .....    @xxx
+xvssub_w         0111 01000100 10010 ..... ..... .....    @xxx
+xvssub_d         0111 01000100 10011 ..... ..... .....    @xxx
+xvssub_bu        0111 01000100 11000 ..... ..... .....    @xxx
+xvssub_hu        0111 01000100 11001 ..... ..... .....    @xxx
+xvssub_wu        0111 01000100 11010 ..... ..... .....    @xxx
+xvssub_du        0111 01000100 11011 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
-- 
2.39.1


