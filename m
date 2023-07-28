Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC37660E6
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPBWT-0008JQ-KC; Thu, 27 Jul 2023 20:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qPBWP-0008JB-RR; Thu, 27 Jul 2023 20:39:58 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1qPBWM-0005YV-Ou; Thu, 27 Jul 2023 20:39:57 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VoO0eDf_1690504780; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VoO0eDf_1690504780) by smtp.aliyun-inc.com;
 Fri, 28 Jul 2023 08:39:42 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix zfa fleq.d and fltq.d
Date: Fri, 28 Jul 2023 08:39:06 +0800
Message-Id: <20230728003906.768-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Commit a47842d ("riscv: Add support for the Zfa extension") implemented the zfa extension.
However, it has some typos for fleq.d and fltq.d. Both of them misused the fltq.s
helper function.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/insn_trans/trans_rvzfa.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/insn_trans/trans_rvzfa.c.inc
index 2c715af3e5..0fdd2698f6 100644
--- a/target/riscv/insn_trans/trans_rvzfa.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfa.c.inc
@@ -470,7 +470,7 @@ bool trans_fleq_d(DisasContext *ctx, arg_fleq_d *a)
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
-    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_helper_fleq_d(dest, cpu_env, src1, src2);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
@@ -485,7 +485,7 @@ bool trans_fltq_d(DisasContext *ctx, arg_fltq_d *a)
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
-    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_helper_fltq_d(dest, cpu_env, src1, src2);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
-- 
2.17.1


