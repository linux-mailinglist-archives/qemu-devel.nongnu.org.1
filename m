Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37079F832
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6A-0005Lq-4m; Wed, 13 Sep 2023 22:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc55-0003OO-4r
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc51-00056w-NH
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxyOiTbwJly_gmAA--.39701S3;
 Thu, 14 Sep 2023 10:27:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S58; 
 Thu, 14 Sep 2023 10:27:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 56/57] target/loongarch: Move simply DO_XX marcos togther
Date: Thu, 14 Sep 2023 10:26:44 +0800
Message-Id: <20230914022645.1151356-57-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S58
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
 target/loongarch/vec.h        | 42 ++++++++++++++++++++++++++++++
 target/loongarch/vec_helper.c | 48 -----------------------------------
 2 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 2f23cae7d7..3c9adf8427 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -30,4 +30,46 @@
 #define Q(x)  Q[x]
 #endif /* HOST_BIG_ENDIAN */
 
+#define DO_ADD(a, b)  (a + b)
+#define DO_SUB(a, b)  (a - b)
+#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
+#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
+#define DO_VABSD(a, b)  ((a > b) ? (a -b) : (b-a))
+#define DO_VABS(a)  ((a < 0) ? (-a) : (a))
+#define DO_MIN(a, b) (a < b ? a : b)
+#define DO_MAX(a, b) (a > b ? a : b)
+#define DO_MUL(a, b) (a * b)
+#define DO_MADD(a, b, c)  (a + b * c)
+#define DO_MSUB(a, b, c)  (a - b * c)
+
+#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
+
+#define R_SHIFT(a, b) (a >> b)
+
+#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
+#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
+#define DO_CLO_W(N)  (clz32(~N))
+#define DO_CLO_D(N)  (clz64(~N))
+#define DO_CLZ_B(N)  (clz32(N) - 24)
+#define DO_CLZ_H(N)  (clz32(N) - 16)
+#define DO_CLZ_W(N)  (clz32(N))
+#define DO_CLZ_D(N)  (clz64(N))
+
+#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
+#define DO_BITSET(a, bit) (a | 1ull << bit)
+#define DO_BITREV(a, bit) (a ^ (1ull << bit))
+
+#define VSEQ(a, b) (a == b ? -1 : 0)
+#define VSLE(a, b) (a <= b ? -1 : 0)
+#define VSLT(a, b) (a < b ? -1 : 0)
+
+#define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 6b61a5c447..3faf52cbc4 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -15,9 +15,6 @@
 #include "vec.h"
 #include "tcg/tcg-gvec-desc.h"
 
-#define DO_ADD(a, b)  (a + b)
-#define DO_SUB(a, b)  (a - b)
-
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
 {                                                                    \
@@ -347,9 +344,6 @@ DO_ODD_U_S(vaddwod_h_bu_b, 16, H, UH, B, UB, DO_ADD)
 DO_ODD_U_S(vaddwod_w_hu_h, 32, W, UW, H, UH, DO_ADD)
 DO_ODD_U_S(vaddwod_d_wu_w, 64, D, UD, W, UW, DO_ADD)
 
-#define DO_VAVG(a, b)  ((a >> 1) + (b >> 1) + (a & b & 1))
-#define DO_VAVGR(a, b) ((a >> 1) + (b >> 1) + ((a | b) & 1))
-
 #define DO_3OP(NAME, BIT, E, DO_OP)                            \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -381,8 +375,6 @@ DO_3OP(vavgr_hu, 16, UH, DO_VAVGR)
 DO_3OP(vavgr_wu, 32, UW, DO_VAVGR)
 DO_3OP(vavgr_du, 64, UD, DO_VAVGR)
 
-#define DO_VABSD(a, b)  ((a > b) ? (a -b) : (b-a))
-
 DO_3OP(vabsd_b, 8, B, DO_VABSD)
 DO_3OP(vabsd_h, 16, H, DO_VABSD)
 DO_3OP(vabsd_w, 32, W, DO_VABSD)
@@ -392,8 +384,6 @@ DO_3OP(vabsd_hu, 16, UH, DO_VABSD)
 DO_3OP(vabsd_wu, 32, UW, DO_VABSD)
 DO_3OP(vabsd_du, 64, UD, DO_VABSD)
 
-#define DO_VABS(a)  ((a < 0) ? (-a) : (a))
-
 #define DO_VADDA(NAME, BIT, E)                                 \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -413,9 +403,6 @@ DO_VADDA(vadda_h, 16, H)
 DO_VADDA(vadda_w, 32, W)
 DO_VADDA(vadda_d, 64, D)
 
-#define DO_MIN(a, b) (a < b ? a : b)
-#define DO_MAX(a, b) (a > b ? a : b)
-
 #define VMINMAXI(NAME, BIT, E, DO_OP)                              \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
 {                                                                  \
@@ -500,8 +487,6 @@ DO_VMUH(vmuh_bu, 8, UH, UB, DO_MUH)
 DO_VMUH(vmuh_hu, 16, UW, UH, DO_MUH)
 DO_VMUH(vmuh_wu, 32, UD, UW, DO_MUH)
 
-#define DO_MUL(a, b) (a * b)
-
 DO_EVEN(vmulwev_h_b, 16, H, B, DO_MUL)
 DO_EVEN(vmulwev_w_h, 32, W, H, DO_MUL)
 DO_EVEN(vmulwev_d_w, 64, D, W, DO_MUL)
@@ -526,9 +511,6 @@ DO_ODD_U_S(vmulwod_h_bu_b, 16, H, UH, B, UB, DO_MUL)
 DO_ODD_U_S(vmulwod_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 DO_ODD_U_S(vmulwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
-#define DO_MADD(a, b, c)  (a + b * c)
-#define DO_MSUB(a, b, c)  (a - b * c)
-
 #define VMADDSUB(NAME, BIT, E, DO_OP)                          \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -639,13 +621,6 @@ VMADDWOD_U_S(vmaddwod_h_bu_b, 16, H, UH, B, UB, DO_MUL)
 VMADDWOD_U_S(vmaddwod_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 VMADDWOD_U_S(vmaddwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
-#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
-#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
-#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
-#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
-
 #define VDIV(NAME, BIT, E, DO_OP)                              \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -791,8 +766,6 @@ VEXT2XV(vext2xv_wu_hu, 32, UW, UH)
 VEXT2XV(vext2xv_du_hu, 64, UD, UH)
 VEXT2XV(vext2xv_du_wu, 64, UD, UW)
 
-#define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
-
 DO_3OP(vsigncov_b, 8, B, DO_SIGNCOV)
 DO_3OP(vsigncov_h, 16, H, DO_SIGNCOV)
 DO_3OP(vsigncov_w, 32, W, DO_SIGNCOV)
@@ -1107,8 +1080,6 @@ VSRARI(vsrari_h, 16, H)
 VSRARI(vsrari_w, 32, W)
 VSRARI(vsrari_d, 64, D)
 
-#define R_SHIFT(a, b) (a >> b)
-
 #define VSRLN(NAME, BIT, E1, E2)                                          \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
 {                                                                         \
@@ -2272,15 +2243,6 @@ void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
     }                                                \
 }
 
-#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
-#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
-#define DO_CLO_W(N)  (clz32(~N))
-#define DO_CLO_D(N)  (clz64(~N))
-#define DO_CLZ_B(N)  (clz32(N) - 24)
-#define DO_CLZ_H(N)  (clz32(N) - 16)
-#define DO_CLZ_W(N)  (clz32(N))
-#define DO_CLZ_D(N)  (clz64(N))
-
 DO_2OP(vclo_b, 8, UB, DO_CLO_B)
 DO_2OP(vclo_h, 16, UH, DO_CLO_H)
 DO_2OP(vclo_w, 32, UW, DO_CLO_W)
@@ -2309,10 +2271,6 @@ VPCNT(vpcnt_h, 16, UH, ctpop16)
 VPCNT(vpcnt_w, 32, UW, ctpop32)
 VPCNT(vpcnt_d, 64, UD, ctpop64)
 
-#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
-#define DO_BITSET(a, bit) (a | 1ull << bit)
-#define DO_BITREV(a, bit) (a ^ (1ull << bit))
-
 #define DO_BIT(NAME, BIT, E, DO_OP)                            \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -3053,10 +3011,6 @@ void HELPER(vffint_s_l)(void *vd, void *vj, void *vk,
     *Vd = temp;
 }
 
-#define VSEQ(a, b) (a == b ? -1 : 0)
-#define VSLE(a, b) (a <= b ? -1 : 0)
-#define VSLT(a, b) (a < b ? -1 : 0)
-
 #define VCMPI(NAME, BIT, E, DO_OP)                                 \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
 {                                                                  \
@@ -3381,8 +3335,6 @@ VILVH(vilvh_h, 32, H)
 VILVH(vilvh_w, 64, W)
 VILVH(vilvh_d, 128, D)
 
-#define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
-
 void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
 {
     int i, j, m;
-- 
2.39.1


