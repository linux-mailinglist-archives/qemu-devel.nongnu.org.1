Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A27AD85F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8t-0008Mq-O8; Mon, 25 Sep 2023 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdju-0001eS-5e
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjq-0004mY-Us
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:33 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 7784E20763;
 Mon, 25 Sep 2023 01:02:29 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id 51C9C20712;
 Mon, 25 Sep 2023 01:02:29 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 1/8] target/sparc: Fix VIS fmul8x16 input register.
Date: Mon, 25 Sep 2023 01:03:50 -0400
Message-ID: <20230925050545.30912-2-nbowler@draconx.ca>
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

On a real UltraSparc II CPU, the fmul8x16 instruction reads its first
input from any of the single-precision floating point registers.

But the emulator is reading the input as if the first operand encodes
a double-precision register, which in most cases will not contain the
right data and therefore the output of the emulated instruction is
just garbage.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1901
---
 target/sparc/helper.h     | 2 +-
 target/sparc/translate.c  | 6 +++++-
 target/sparc/vis_helper.c | 9 +++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8f1e78c75..ace731a22c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -126,7 +126,7 @@ DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
 DEF_HELPER_FLAGS_1(fqtox, TCG_CALL_NO_RWG, s64, env)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3bf0ab8135..bb65b8daf8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4750,7 +4750,11 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x031: /* VIS I fmul8x16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8x16);
+                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
+                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
+                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
+                    gen_helper_fmul8x16(cpu_dst_64, cpu_src1_32, cpu_src2_64);
+                    gen_store_fpr_D(dc, rd, cpu_dst_64);
                     break;
                 case 0x033: /* VIS I fmul8x16au */
                     CHECK_FPU_FEATURE(dc, VIS1);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 3afdc6975c..d158b39b85 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -94,16 +94,17 @@ uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
-    VIS64 s, d;
+    VIS32 s;
+    VIS64 d;
     uint32_t tmp;
 
-    s.ll = src1;
+    s.l = src1;
     d.ll = src2;
 
 #define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B64(r);       \
+    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
     if ((tmp & 0xff) > 0x7f) {                                  \
         tmp += 0x100;                                           \
     }                                                           \
-- 
2.41.0


