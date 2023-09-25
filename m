Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35A7AD860
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8o-0008KS-Lr; Mon, 25 Sep 2023 08:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjt-0001eP-QP
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjq-0004ml-QQ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:33 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 44CC62076D;
 Mon, 25 Sep 2023 01:02:30 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id 1FBDA20712;
 Mon, 25 Sep 2023 01:02:30 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 3/8] target/sparc: Fix VIS fmul8x16al instruction.
Date: Mon, 25 Sep 2023 01:03:52 -0400
Message-ID: <20230925050545.30912-4-nbowler@draconx.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925050545.30912-1-nbowler@draconx.ca>
References: <20230925050545.30912-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: none client-ip=162.250.196.97; envelope-from=nbowler@draconx.ca;
 helo=mta01.start.ca
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Sep 2023 08:56:43 -0400
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

On a real UltraSparc II, the fmul8x16al instruction takes two single-
precision input operands and returns a double-precision result.  For
the second operand, bits 15:0 are used, and bits 31:16 are ignored.

However, the emulation is taking two double-precision input operands,
and furthermore it is using bits 31:16 of the second operand (ignoring
bits 15:0).  These are unlikely to contain the correct values.

Even still, the emulator overwrites the second input before all outputs
are calculated, so even if by chance the data loaded in happens to be
correct, the results are just garbage except in trivial cases.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  2 +-
 target/sparc/vis_helper.c | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 76e06b8ea5..25d6178ca5 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -127,7 +127,7 @@ DEF_HELPER_FLAGS_1(fqtox, TCG_CALL_NO_RWG, s64, env)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
-DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ca81b35a25..dddee9f974 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4779,7 +4779,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x035: /* VIS I fmul8x16al */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8x16al);
+                    gen_ne_fop_DFF(dc, rd, rs1, rs2, gen_helper_fmul8x16al);
                     break;
                 case 0x036: /* VIS I fmul8sux16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 2fc783a054..386cfd0706 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -122,16 +122,17 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16al(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16al(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
     uint32_t tmp;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
 
 #define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(1) * (int32_t)s.VIS_B64(r);       \
+    tmp = (int32_t)s2.VIS_SW32(0) * (int32_t)s1.VIS_B64(r);     \
     if ((tmp & 0xff) > 0x7f) {                                  \
         tmp += 0x100;                                           \
     }                                                           \
-- 
2.41.0


