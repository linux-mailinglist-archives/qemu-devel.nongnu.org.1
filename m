Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9683753557
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERu-0002Hm-45; Fri, 14 Jul 2023 04:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERr-00022q-8e
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERo-0004pB-3Q
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxBfFmC7Fkf84EAA--.13140S3;
 Fri, 14 Jul 2023 16:46:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S24; 
 Fri, 14 Jul 2023 16:46:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 22/47] target/loongarch: Implement xvsigncov
Date: Fri, 14 Jul 2023 16:45:50 +0800
Message-Id: <20230714084615.2448038-23-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S24
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
- XVSIGNCOV.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/disas.c                     | 5 +++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 5 +++++
 target/loongarch/insns.decode                | 5 +++++
 target/loongarch/vec.h                       | 2 ++
 target/loongarch/vec_helper.c                | 2 --
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 975ea018da..85e0cb7c8d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2010,6 +2010,11 @@ INSN_LASX(vext2xv_wu_hu,     vv)
 INSN_LASX(vext2xv_du_hu,     vv)
 INSN_LASX(vext2xv_du_wu,     vv)
 
+INSN_LASX(xvsigncov_b,       vvv)
+INSN_LASX(xvsigncov_h,       vvv)
+INSN_LASX(xvsigncov_w,       vvv)
+INSN_LASX(xvsigncov_d,       vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5a99c75858..7aab6528a7 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -335,6 +335,11 @@ TRANS(vext2xv_wu_hu, gen_vv, 32, gen_helper_vext2xv_wu_hu)
 TRANS(vext2xv_du_hu, gen_vv, 32, gen_helper_vext2xv_du_hu)
 TRANS(vext2xv_du_wu, gen_vv, 32, gen_helper_vext2xv_du_wu)
 
+TRANS(xvsigncov_b, gvec_vvv, 32, MO_8, do_vsigncov)
+TRANS(xvsigncov_h, gvec_vvv, 32, MO_16, do_vsigncov)
+TRANS(xvsigncov_w, gvec_vvv, 32, MO_32, do_vsigncov)
+TRANS(xvsigncov_d, gvec_vvv, 32, MO_64, do_vsigncov)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index db1a6689f0..7bbda1a142 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1593,6 +1593,11 @@ vext2xv_wu_hu    0111 01101001 11110 01101 ..... .....    @vv
 vext2xv_du_hu    0111 01101001 11110 01110 ..... .....    @vv
 vext2xv_du_wu    0111 01101001 11110 01111 ..... .....    @vv
 
+xvsigncov_b      0111 01010010 11100 ..... ..... .....    @vvv
+xvsigncov_h      0111 01010010 11101 ..... ..... .....    @vvv
+xvsigncov_w      0111 01010010 11110 ..... ..... .....    @vvv
+xvsigncov_d      0111 01010010 11111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index ee50d53f4e..681afd842f 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -72,4 +72,6 @@
 #define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
         unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
 
+#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 024dda5aca..126b67eea5 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -766,8 +766,6 @@ VEXT2XV(vext2xv_wu_hu, 32, UW, UH)
 VEXT2XV(vext2xv_du_hu, 64, UD, UH)
 VEXT2XV(vext2xv_du_wu, 64, UD, UW)
 
-#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
-
 DO_3OP(vsigncov_b, 8, B, DO_SIGNCOV)
 DO_3OP(vsigncov_h, 16, H, DO_SIGNCOV)
 DO_3OP(vsigncov_w, 32, W, DO_SIGNCOV)
-- 
2.39.1


