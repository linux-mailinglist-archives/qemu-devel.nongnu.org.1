Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AE77F364
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMI-0001Lc-T6; Thu, 17 Aug 2023 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZMB-0000N3-Lc
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZM6-0002aN-Rk
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:54 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHOv36N1kf3UZAA--.47512S3;
 Thu, 17 Aug 2023 17:31:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S17; 
 Thu, 17 Aug 2023 17:31:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 15/18] target/loongarch: Add avail_LSPW to check LSPW
 instructions
Date: Thu, 17 Aug 2023 17:31:18 +0800
Message-Id: <20230817093121.1053890-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S17
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insn_trans/trans_privileged.c.inc | 8 ++++++++
 target/loongarch/translate.h                       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 684ff547a7..099cd871f0 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -437,6 +437,10 @@ static bool trans_ldpte(DisasContext *ctx, arg_ldpte *a)
     TCGv_i32 mem_idx = tcg_constant_i32(ctx->mem_idx);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_LSPW(ctx)) {
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -450,6 +454,10 @@ static bool trans_lddir(DisasContext *ctx, arg_lddir *a)
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
 
+    if (!avail_LSPW(ctx)) {
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 0f244cd83b..f0d7b82932 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -20,6 +20,7 @@
 #define avail_FP(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
 #define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
 #define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.39.1


