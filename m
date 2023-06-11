Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7972B371
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 20:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8QBf-00005U-H9; Sun, 11 Jun 2023 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBd-000054-8M
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:13 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBb-0001mg-Md
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qL/b7bzUhjgDV5K1GLuIbZ71qsxiqEcNaQjn5fdGnkY=; b=Gfo/4HAtT8MJ2Ou0CI4c6bJM7e
 aMKkz2pQobHKeP2hO82UsmnXbhsB6pxdHfJDXZcHzuNIVZYpJRzgujyxGr+57XQfO6gorx/Hj06mw
 SuTdhH7rXn0kYHLycVNv9kThwJRZFgHr0/G5mDaD9w0n02WG0xbuKGtDpM7ViqIeJ38Y=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 4/6] target/tricore: Add crc32l.w insn
Date: Sun, 11 Jun 2023 20:52:11 +0200
Message-Id: <20230611185213.51345-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
References: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.11.184517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=354481, da=174118654, mc=36, sc=0,
 hc=36, sp=0, fso=354481, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.h          |  3 ++-
 target/tricore/op_helper.c       | 10 +++++++++-
 target/tricore/translate.c       | 12 ++++++++++--
 target/tricore/tricore-opcodes.h |  3 ++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index b64780c37d..24da5e97c0 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -131,7 +131,8 @@ DEF_HELPER_FLAGS_5(mul_h, TCG_CALL_NO_RWG_SE, i64, i32, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_5(mulm_h, TCG_CALL_NO_RWG_SE, i64, i32, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_5(mulr_h, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32, i32)
 /* crc32 */
-DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
+DEF_HELPER_FLAGS_2(crc32_be, TCG_CALL_NO_RWG_SE, i32, i32, i32)
+DEF_HELPER_FLAGS_2(crc32_le, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 /* CSA */
 DEF_HELPER_2(call, void, env, i32)
 DEF_HELPER_1(ret, void, env)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 54f54811d9..8ce404cb93 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2284,7 +2284,7 @@ uint32_t helper_mulr_h(uint32_t arg00, uint32_t arg01,
     return (result1 & 0xffff0000) | (result0 >> 16);
 }
 
-uint32_t helper_crc32(uint32_t arg0, uint32_t arg1)
+uint32_t helper_crc32_be(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[4];
     stl_be_p(buf, arg0);
@@ -2292,6 +2292,14 @@ uint32_t helper_crc32(uint32_t arg0, uint32_t arg1)
     return crc32(arg1, buf, 4);
 }
 
+uint32_t helper_crc32_le(uint32_t arg0, uint32_t arg1)
+{
+    uint8_t buf[4];
+    stl_le_p(buf, arg0);
+
+    return crc32(arg1, buf, 4);
+}
+
 /* context save area (CSA) related helpers */
 
 static int cdc_increment(target_ulong *psw)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 898557d22a..250de80de5 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6190,13 +6190,21 @@ static void decode_rr_divide(DisasContext *ctx)
         CHECK_REG_PAIR(r3);
         gen_unpack(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
         break;
-    case OPC2_32_RR_CRC32:
+    case OPC2_32_RR_CRC32: /* CRC32B.W in 1.6.2 */
         if (has_feature(ctx, TRICORE_FEATURE_161)) {
-            gen_helper_crc32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+            gen_helper_crc32_be(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
+    case OPC2_32_RR_CRC32L_W:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            gen_helper_crc32_le(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
+
     case OPC2_32_RR_POPCNT_W:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
             tcg_gen_ctpop_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 9fab4bd75c..be07f82ec1 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1139,7 +1139,8 @@ enum {
     OPC2_32_RR_DVINIT_U                          = 0x0a,
     OPC2_32_RR_PARITY                            = 0x02,
     OPC2_32_RR_UNPACK                            = 0x08,
-    OPC2_32_RR_CRC32                             = 0x03,
+    OPC2_32_RR_CRC32                             = 0x03, /* CRC32B.W in 1.6.2 */
+    OPC2_32_RR_CRC32L_W                          = 0x07, /* 1.6.2 only */
     OPC2_32_RR_POPCNT_W                          = 0x22, /* 1.6.2 only */
     OPC2_32_RR_DIV                               = 0x20,
     OPC2_32_RR_DIV_U                             = 0x21,
-- 
2.40.1


