Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680B7AD863
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8o-0008KA-6q; Mon, 25 Sep 2023 08:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdju-0001eR-5W
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjs-0004oV-Fy
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:33 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 0B1E22077C;
 Mon, 25 Sep 2023 01:02:31 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id CDCC62076F;
 Mon, 25 Sep 2023 01:02:30 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 5/8] target/sparc: Fix VIS fmuld8ulx16 instruction.
Date: Mon, 25 Sep 2023 01:03:54 -0400
Message-ID: <20230925050545.30912-6-nbowler@draconx.ca>
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

On a real UltraSparc II, the fmuld8ulx16 instruction takes two single-
precision input operands and returns a double-precision result.

However, the emulation is taking two double-precision input operands,
which are unlikely to contain the correct values, so the results are
garbage in most cases.  Even if the inputs happen to be correct, the
emulator is rounding the output, which the real processor does not do.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  2 +-
 target/sparc/vis_helper.c | 17 +++++++----------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index adc1ea6653..7a588f3068 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -132,7 +132,7 @@ DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i32, i32)
-DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1017d3bca7..cfccd95c3a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4795,7 +4795,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x039: /* VIS I fmuld8ulx16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld8ulx16);
+                    gen_ne_fop_DFF(dc, rd, rs1, rs2, gen_helper_fmuld8ulx16);
                     break;
                 case 0x03a: /* VIS I fpack32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index de5ddad39a..306383ba60 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -240,24 +240,21 @@ uint64_t helper_fmuld8sux16(uint32_t src1, uint32_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
+uint64_t helper_fmuld8ulx16(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
     uint32_t tmp;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
 
 #define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
+    tmp = (int32_t)s2.VIS_SW32(r) * ((uint32_t)s1.VIS_B32(r * 2));      \
     d.VIS_L64(r) = tmp;
 
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
     PMUL(0);
+    PMUL(1);
 #undef PMUL
 
     return d.ll;
-- 
2.41.0


